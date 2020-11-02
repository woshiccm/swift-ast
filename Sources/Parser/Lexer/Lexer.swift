import Foundation

public class Lexer {
    typealias Pointer = String.UnicodeScalarView.Index
    
    var content: String.UnicodeScalarView
        
    private(set) var nextToken: Token
    private(set) var scanner: Scanner
    
    /// The current leading trivia for the next token.
    var leadingTrivia: Trivia
    
    /// The current trailing trivia for the next token.
    var trailingTrivia: Trivia
    
    /// Determine whether this token occurred at the start of a line.
    var isAtStartOfLine = true
        
    public struct SourceLoc {
        
    }
    
    public struct LexerState {
        let location: SourceLoc
    }
    
    /// The source code to be lexed
    private let source: String
    
    public convenience init(url: URL) {
        let fileData = try? Data(contentsOf: url)
        let source = fileData?.withUnsafeBytes { buf in
          return String.fromBuffer(buf.bindMemory(to: UInt8.self))
        } ?? ""
        self.init(source: source)
    }
    
    public init(source: String) {
        self.source = source
        self.content = source.unicodeScalars
        self.scanner = Scanner(source)
        self.nextToken = Token(kind: .unknown, text: "")
        leadingTrivia = Trivia.zero
        trailingTrivia = Trivia.zero
    }
    
    private func formToken(kind: TokenKind, from start: String.UnicodeScalarIndex) -> Token {
        return formToken(kind: kind, with: scanner.text(from: start))
    }
    
    private func formToken(kind: TokenKind, with text: String) -> Token {
        return Token(kind: kind, text: text)
    }
    
    public func lex() {
        
    }
    
    public func lexImpl() -> Token {
        guard !scanner.isAtEnd else {
            return formToken(kind: .eof, with: "")
        }
        leadingTrivia = Trivia.zero
        trailingTrivia = Trivia.zero
        
        lexTrivia(pieces: &leadingTrivia)
        
        let tokStart = scanner.current
        let char = scanner.advance()
        
        switch char {
        case "\n", "\r":
            print("Newlines should be eaten by lexTrivia as LeadingTrivia")
        case " ", "\t":
            print("Whitespaces should be eaten by lexTrivia as LeadingTrivia")
            
        case "@": return formToken(kind: .atSign, from: tokStart)
        case "{": return formToken(kind: .leftBrace, from: tokStart)
        case "[": return formToken(kind: .leftSquareBracket, from: tokStart)
        case "(": return formToken(kind: .leftParen, from: tokStart)
        case "}": return formToken(kind: .rightBrace, from: tokStart)
        case "]": return formToken(kind: .rightSquareBracket, from: tokStart)
        case ")": return formToken(kind: .rightParen, from: tokStart)
            
        case ",": return formToken(kind: .comma, from: tokStart)
        case ";": return formToken(kind: .semicolon, from: tokStart)
        case ":": return formToken(kind: .colon, from: tokStart)
        case "\\": return formToken(kind: .backslash, from: tokStart)
            
        case "#":
            return lexHash()
            
        case "/":
            if scanner.peek == "/" { // "//"
                skipSlashSlashComment(eatNewline: true)
                return lexImpl()
            } else if scanner.peek == "*" { // "/*"
                skipSlashStarComment()
                return lexImpl()
            }
            return lexOperatorIdentifier()
        case "%":
            return lexOperatorIdentifier()
        case "!":
            if isLeftBound(tokStart) {
                return formToken(kind: .exclamationMark, from: tokStart)
            }
            return lexOperatorIdentifier()
        case "?":
            if isLeftBound(tokStart) {
                return formToken(kind: .postfixQuestionMark, from: tokStart)
            }
            return lexOperatorIdentifier()
        case "<":
            if scanner.peek == "#" {
                return tryLexEditorPlaceholder()
            }
            return lexOperatorIdentifier()
        case ">":
            return lexOperatorIdentifier()
        case "=", "-", "+", "*", "&", "|", "^", "~", ".":
            return lexOperatorIdentifier()
        case "a"..."z", "A"..."Z", "_":
            return lexIdentifier()
        case "$":
            return lexDollarIdent()
        case "0"..."9":
            return lexNumber()
        case "\"", "'":
            return lexStringLiteral()
        case "`":
            return lexEscapedIdentifier()
        default:
            break
        }
        
        return formToken(kind: .unknown, from: tokStart)
    }
    
    public func lexTrivia(pieces: inout Trivia) {
        let startCharacterOfTokens: Set<UnicodeScalar> = ["@", "{", "[", "(", "}", "]", ")",
                                                          ",", ";", ":", "\\", "$",
                                                          "0", "1", "2", "3", "4",
                                                          "5", "6", "7", "8", "9",
                                                          "\"", "'", "`"]
        let startOfOperators: Set<UnicodeScalar> = ["%", "!", "?", "=",
                                                    "-", "+", "*", "&",
                                                    "|", "^", "~", "."]
        loop: while true {
            let triviaStart = scanner.current
            
            let char = scanner.advance()
            switch char {
            case "\n":
                pieces.appending(.newlines(1))
                isAtStartOfLine = true
                continue
            case "\r":
                isAtStartOfLine = true
                if scanner.match("\n") {
                    pieces.appending(.carriageReturnLineFeeds(1))
                } else {
                    pieces.appending(.carriageReturns(1))
                }
                continue
            case " ":
                pieces.appending(.spaces(1))
                continue
            case "\t":
                pieces.appending(.tabs(1))
                continue
            case "\u{C}":
                pieces.appending(.formfeeds(1))
                continue
            case "/":
                if scanner.peek == "/" {
                    // '// ...' comment.
                    let isDocComment = scanner.peekNext == "/"
                    skipSlashSlashComment(eatNewline: false)
                    continue
                } else if scanner.peek == "*" {
                    // '/* ... */' comment.
                    let isDocComment = scanner.peekNext == "*"
                    skipSlashStarComment()
                    continue
                }
                break
            case "#":
                if triviaStart == scanner.contentStart && scanner.peek == "!" {
                    // Hashbang '#!/path/to/swift'.
                    scanner.putback()
                    skipHashbang(eatNewline: false)
                    continue
                }
                break
            case "<", ">":
                if tryLexConflictMarker(eatNewline: false) {
                    // Conflict marker.
                    continue
                }
                break loop
            // Start character of tokens.
            case _ where startCharacterOfTokens.contains(char):
                break loop
            // Start of identifiers.
            case "a"..."z", "A"..."Z", "_":
                break loop
            // Start of operators.
            case _ where startOfOperators.contains(char):
                break loop
            default:
                continue
            }
        }
        scanner.putback()
    }
    
    /// Advance to the end of the line.
    /// If EatNewLine is true, CurPtr will be at end of newline character.
    /// Otherwise, CurPtr will be at newline character.
    public func skipToEndOfLine(eatNewline: Bool) {
        let isEOL = advanceToEndOfLine()
        
        if eatNewline && isEOL {
            scanner.advance()
            isAtStartOfLine = true
        }
    }
    
    
    public func advanceToEndOfLine() -> Bool {
        while !scanner.isAtEnd {
            switch scanner.advance() {
            case "\n", "\r":
                scanner.putback()
                return true
            default:
                break
            }
        }
        return false
    }
    
    /// Skip to the end of the line of a // comment.
    public func skipSlashSlashComment(eatNewline: Bool) {
        assert(scanner.peekBack == "/" && scanner.peek == "/", "Not a // comment")
        return skipToEndOfLine(eatNewline: eatNewline)
    }
    
    /// Skip a #! hashbang line.
    public func skipHashbang(eatNewline: Bool) {
        skipToEndOfLine(eatNewline: eatNewline)
    }
    
    /// skipSlashStarComment - /**/ comments are skipped (treated as whitespace).
    /// Note that (unlike in C) block comments can be nested.
    public func skipSlashStarComment() {
        let isMultiline = skipToEndOfSlashStarComment()
        if isMultiline {
            isAtStartOfLine = true
        }
    }
    
    public func skipToEndOfSlashStarComment() -> Bool {
        // Make sure to advance over the * so that we don't incorrectly handle /*/ as
        // the beginning and end of the comment.
        scanner.advance()
        
        // /**/ comments can be nested, keep track of how deep we've gone.
        var depth: Int = 1
        var isMultiline = false
        
        while !scanner.isAtEnd {
            switch scanner.advance() {
            case "*" where scanner.match("/"):
                depth -= 1
                if depth == 0 { return isMultiline }
                break
            case "/" where scanner.match("*"):
                depth += 1
            case "\n", "\r":
                isMultiline = true
            default:
                break
            }
        }
        
        // Otherwise, we have an unterminated /* comment.
        return isMultiline
    }
    
    /// lexHash - Handle #], #! for shebangs, and the family of #identifiers.
    public func lexHash() -> Token {
        scanner.putback()
        
        let tmpPtr = scanner.current
        
        // Scan for [a-zA-Z]+ to see what we match.
        if scanner.peek.isClangIdentifierHead {
            scanner.advance()
            scanner.skip { $0.isClangIdentifierBody }
        }
        
        // Map the character sequence onto
        let identifier = scanner.text(from: tmpPtr)
        switch identifier {
        case "if": return formToken(kind: .poundIfKeyword, from: tmpPtr)
        case "else": return formToken(kind: .poundElseKeyword, from: tmpPtr)
        case "elseif": return formToken(kind: .poundElseifKeyword, from: tmpPtr)
        case "endif": return formToken(kind: .poundEndifKeyword, from: tmpPtr)
        case "keyPath": return formToken(kind: .poundKeyPathKeyword, from: tmpPtr)
        case "line": return formToken(kind: .poundLineKeyword, from: tmpPtr)
        case "sourceLocation": return formToken(kind: .poundSourceLocationKeyword, from: tmpPtr)
        case "selector": return formToken(kind: .poundSelectorKeyword, from: tmpPtr)
        case "file": return formToken(kind: .poundFileKeyword, from: tmpPtr)
        case "column": return formToken(kind: .poundColumnKeyword, from: tmpPtr)
        case "function": return formToken(kind: .poundFunctionKeyword, from: tmpPtr)
        case "dsohandle": return formToken(kind: .poundDsohandleKeyword, from: tmpPtr)
        default:
            // Otherwise, unwind the parser to identifier found and just return a .pound token.
            scanner.rewind(to: tmpPtr)
            scanner.advance() // over the pound
            return formToken(kind: .pound, from: tmpPtr)
        }
    }
    
    /// lexIdentifier - Match [a-zA-Z_][a-zA-Z_$0-9]*
    public func lexIdentifier() -> Token {
        scanner.putback()
        let tokStart = scanner.current
        
         _ = scanner.match { $0.isIdentifierHead }
        // Lex [a-zA-Z_$0-9[[:XID_Continue:]]]*
        scanner.skip { $0.isIdentifierBody }
        
        let text = scanner.text(from: tokStart)
        let kind = TokenKind(text: text)
        if kind.isKeyword {
            return formToken(kind: kind, with: text)
        }
        return formToken(kind: .identifier, with: text)
    }
    
    /// lexDollarIdent - Match $[0-9a-zA-Z_$]+
    public func lexDollarIdent() -> Token {
        scanner.putback()
        let tokStart = scanner.current
        
        _ = scanner.match("$")
        
        var isAllDigits = true
        while !scanner.isAtEnd {
            if scanner.peek.isDigit {
                scanner.advance()
            } else if (scanner.peek.isClangIdentifierHead || scanner.peek == "$") {
                isAllDigits = false
                break
            } else {
                break
            }
        }
        
        let text = scanner.text(from: tokStart)
        if text.count == 1 {
            return formToken(kind: .identifier, with: text)
        }
        
        if !isAllDigits {
            return formToken(kind: .identifier, with: text)
        } else {
            return formToken(kind: .dollarIdentifier, with: text)
        }
    }
    
    /// lexOperatorIdentifier - Match identifiers formed out of punctuation.
    public func lexOperatorIdentifier() -> Token {
        scanner.putback()
        let tokStart = scanner.current
        let tokStartChar = scanner.peek
                
        _ = scanner.match { $0.isOperatorHead }
        
        while !scanner.isAtEnd {
            if !scanner.peek.isOperatorBody { break }
            
            // '.' cannot appear in the middle of an operator unless the operator
            // started with a '.'.
            if (scanner.peek == "." && tokStartChar != ".") {
                break
            }
            // If there is a "//" or "/*" in the middle of an identifier token,
            // it starts a comment.
            if scanner.peek == "/" && (scanner.peekNext == "/" || scanner.peekNext == "*") { break }
            
            scanner.advance()
        }
        
        // Decide between the binary, prefix, and postfix cases.
        // It's binary if either both sides are bound or both sides are not bound.
        // Otherwise, it's postfix if left-bound and prefix if right-bound.
        let leftBound = isLeftBound(tokStart)
        let rightBound = isRightBound(scanner.current, isLeftBound: leftBound)
        
        let text = scanner.text(from: tokStart)
        switch text {
        case "=":
            return formToken(kind: .equal, with: text)
        case "&" where !(leftBound == rightBound || leftBound):
            return formToken(kind: .prefixAmpersand, with: text)
        case ".":
            if  (leftBound == rightBound) {
                return formToken(kind: .period, with: text)
            }
            if (rightBound) {
                return formToken(kind: .prefixPeriod, with: text)
            }
            
            // If left bound but not right bound, handle some likely situations.
            
            // If there is just some horizontal whitespace before the next token, its
            // addition is probably incorrect.
            var afterHorzWhitespace = scanner
            afterHorzWhitespace.skip(over: [" ", "\t"])
            // First, when we are code completing "x. <ESC>", then make sure to return
            // a tok::period, since that is what the user is wanting to know about.
            
            if isRightBound(afterHorzWhitespace.current, isLeftBound: leftBound)
                // Don't consider comments to be this.  A leading slash is probably
                // either // or /* and most likely occurs just in our testsuite for
                // expected-error lines.
                && afterHorzWhitespace.peek != "/" {
                // FIXME: make a fixit suggestion to remove whitespace between
                // the "." and the end of horizontal whitespace
                return formToken(kind: .period, with: text)
            }
            
            // Otherwise, it is probably a missing member.
            return formToken(kind: .unknown, from: tokStart)
        case "?":
            if leftBound {
                return formToken(kind: .postfixQuestionMark, with: text)
            }
            return formToken(kind: .postfixQuestionMark, with: text)
        case "->":
            return formToken(kind: .arrow, with: text)
        case "*/":
            return formToken(kind: .unknown, with: text)
        case _ where text.count > 2:
            var finder = Scanner(text)
            // Verify there is no "*/" in the middle of the identifier token, we reject
            // it as potentially ending a block comment.
            finder.skip { $0 != "*"}
            if finder.peekNext == "/" {
                return formToken(kind: .unknown, with: text)
            }
            
        default: break
        }
        
        switch (leftBound, rightBound) {
        case (true, true):
            return formToken(kind: .unspacedBinaryOperator, with: text)
        case (false, false):
            return formToken(kind: .spacedBinaryOperator, with: text)
        case (true, false):
            return formToken(kind: .postfixOperator, with: text)
        case (false, true):
            return formToken(kind: .prefixOperator, with: text)
        }
    }
    
    public func lexHexNumber() -> Token {
        scanner.putback()
        let tokStart = scanner.current
        
        func expectedDigit() -> Token {
            scanner.skip { $0.isIdentifierBody }
            return formToken(kind: .unknown, from: tokStart)
        }
        
        func expectedHexDigit() -> Token {
            // FIXME: diagnose invalid digit in int literal
            return expectedDigit()
        }
        
        scanner.advance() // skip over 0
        scanner.advance() // skip over x
        
        // 0x[0-9a-fA-F][0-9a-fA-F_]*
        if !scanner.match({ $0.isHexDigit }) {
            return expectedHexDigit()
        }
        
        scanner.skip { $0.isHexDigit || $0 == "_" }
        
        if scanner.peek != "." && scanner.peek != "p" && scanner.peek != "P" {
            if scanner.match({ $0.isIdentifierBody }) {
                return expectedHexDigit()
            }
            return formToken(kind: .integerLiteral, from: tokStart)
        }
        
        var ptrOnDot: Scanner?
        
        // (\.[0-9A-Fa-f][0-9A-Fa-f_]*)?
        if scanner.peek == "." {
            ptrOnDot = scanner
            
            scanner.advance()
            
            // If the character after the '.' is not a digit, assume we have an int
            // literal followed by a dot expression.
            if !scanner.peek.isHexDigit {
                scanner.putback()
                return formToken(kind: .integerLiteral, from: tokStart)
            }
            
            scanner.skip { $0.isHexDigit || $0 == "_" }
            
            if scanner.peek != "p" && scanner.peek != "P" {
                if !ptrOnDot!.peekNext.isDigit {
                    // e.g: 0xff.description
                    scanner = ptrOnDot!
                    return formToken(kind: .integerLiteral, from: tokStart)
                }
                return formToken(kind: .unknown, from: tokStart)
            }
        }
        
        // [pP][+-]?[0-9][0-9_]*
        assert(scanner.peek == "p" || scanner.peek == "P", "not at a hex float exponent?!")
        scanner.advance() // skip over p or P
        
        let signedExponent = scanner.match{ $0 == "+" || $0 == "-" }
        
        if !scanner.peek.isDigit {
            if let onDot = ptrOnDot, !onDot.peekNext.isDigit && !signedExponent {
                // e.g: 0xff.fpValue, 0xff.fp
                scanner = onDot
                return formToken(kind: .integerLiteral, from: tokStart)
            }
            
            // Note: 0xff.fp+otherExpr can be valid expression. But we don't accept it.

            // There are 3 cases to diagnose if the exponent starts with a non-digit:
            // identifier (invalid character), underscore (invalid first character),
            // non-identifier (empty exponent)
            if scanner.match({ $0.isIdentifierBody }) {
                // FIXME: diagnose invalid digit in fp exponent
                return expectedDigit()
            } else {
                // FIXME: diagnose expected digit in fp exponent
                return expectedDigit()
            }
        }
        
        scanner.skip { $0.isDigit || $0 == "_" }
        
        if scanner.match({ $0.isIdentifierBody }) {
            // FIXME: diagnose invalid digit in fp exponent
            return expectedDigit()
        }
        
        return formToken(kind: .floatingLiteral, from: tokStart)
    }
    
    private enum ExpectedDigitKind {
        case binary, octal, decimal, hex
    }
    
    /// lexNumber:
    ///   integer_literal  ::= [0-9][0-9_]*
    ///   integer_literal  ::= 0x[0-9a-fA-F][0-9a-fA-F_]*
    ///   integer_literal  ::= 0o[0-7][0-7_]*
    ///   integer_literal  ::= 0b[01][01_]*
    ///   floating_literal ::= [0-9][0-9]_*\.[0-9][0-9_]*
    ///   floating_literal ::= [0-9][0-9]*\.[0-9][0-9_]*[eE][+-]?[0-9][0-9_]*
    ///   floating_literal ::= [0-9][0-9_]*[eE][+-]?[0-9][0-9_]*
    ///   floating_literal ::= 0x[0-9A-Fa-f][0-9A-Fa-f_]*
    ///                          (\.[0-9A-Fa-f][0-9A-Fa-f_]*)?[pP][+-]?[0-9][0-9_]*
    public func lexNumber() -> Token {
        scanner.putback()
        let tokStart = scanner.current
        assert(scanner.peek.isDigit || scanner.peek == ".", "Unexpected start")
        
        func expectedDigit() -> Token {
            scanner.skip { $0.isIdentifierBody }
            return formToken(kind: .unknown, from: tokStart)
        }
        
        func expectedIntDigit(_ digitKind: ExpectedDigitKind) -> Token {
            // FIXME: diagnose invalid digit in int literal
            return expectedDigit()
        }
        
        if scanner.peek == "0" && scanner.peekNext == "x" {
            return lexHexNumber()
        }
        
        if scanner.peek == "0" && scanner.peekNext == "o" {
            // 0o[0-7][0-7_]*
            scanner.advance() // advance over "0"
            scanner.advance() // advance over "o"
            
            if scanner.peek < "0" || scanner.peek > "7" {
                return expectedIntDigit(.octal)
            }
            
            scanner.skip { ($0 >= "0" && $0 <= "7") || $0 == "_" }
            
            if scanner.match({ $0.isIdentifierBody }) {
                return expectedIntDigit(.octal)
            }
            
            return formToken(kind: .integerLiteral, from: tokStart)
        }
        
        if scanner.peek == "0" && scanner.peekNext == "b" {
            // 0b[01][01_]*
            scanner.advance() // advance over "0"
            scanner.advance() // advance over "b"
            
            if scanner.peek != "0" && scanner.peek != "1" {
                return expectedIntDigit(.binary)
            }
            
            scanner.skip(over: ["0", "1", "_"])
            
            if scanner.match({ $0.isIdentifierBody }) {
                return expectedIntDigit(.octal)
            }
            
            return formToken(kind: .integerLiteral, from: tokStart)
        }
        
        // Handle a leading [0-9]+, lexing an integer or falling through if we have a
        // floating point value.
        scanner.skip { $0.isDigit || $0 == "_" }
        
        // Lex things like 4.x as '4' followed by a tok::period.
        if scanner.peek == "." {
            // NextToken is the soon to be previous token
            // Therefore: x.0.1 is sub-tuple access, not x.float_literal
            if !scanner.peekNext.isDigit || nextToken.kind == .period {
                return formToken(kind: .integerLiteral, from: tokStart)
            }
        } else {
            // Floating literals must have '.', 'e', or 'E' after digits.  If it is
            // something else, then this is the end of the token.
            if scanner.peek != "e" && scanner.peek != "E" {
                if scanner.match({ $0.isIdentifierBody }) {
                    return expectedIntDigit(.octal)
                }
                return formToken(kind: .integerLiteral, from: tokStart)
            }
        }
        
        // Lex decimal point.
        if scanner.match(".") {
            scanner.skip { $0.isDigit || $0 == "_" }
        }
        
        // Lex exponent.
        if scanner.match({ $0 == "e" || $0 == "E" }) {
            _ = scanner.match({ $0 == "+" || $0 == "-" })
            
            if !scanner.peek.isDigit {
                // There are 3 cases to diagnose if the exponent starts with a non-digit:
                // identifier (invalid character), underscore (invalid first character),
                // non-identifier (empty exponent)
                return expectedDigit()
            }
            
            scanner.skip { $0.isDigit || $0 == "_" }
            
            if scanner.match({ $0.isIdentifierBody }) {
                // FIXME: diagnose invalid digit in fp exponent
                return expectedDigit()
            }
        }
        
        return formToken(kind: .floatingLiteral, from: tokStart)
    }
    
    ///   unicode_character_escape ::= [\]u{hex+}
    ///   hex                      ::= [0-9a-fA-F]
    private func lexUnicodeEscape() -> CharValue {
        assert(scanner.peek == "{", "Invalid unicode escape")
        scanner.advance()
        
        let digitStart = scanner.current
        
        scanner.skip { $0.isHexDigit }
        
        if scanner.peek != "}" {
            return .error
        }
        let digits = scanner.text(from: digitStart)
        
        scanner.advance()
        
        if digits.count < 1 || digits.count > 8 {
            // FIXME: diagnose invalid u escape
            return .error
        }
        
        return CharValue(UInt32(digits, radix: 16)!)
    }
    
    /// skipToEndOfInterpolatedExpression - Given the first character after a \(
    /// sequence in a string literal (the start of an interpolated expression),
    /// scan forward to the end of the interpolated expression and return the end.
    /// On success, the returned pointer will point to the ')' at the end of the
    /// interpolated expression.  On failure, it will point to the first character
    /// that cannot be lexed as part of the interpolated expression; this character
    /// will never be ')'.
    ///
    /// This function performs brace and quote matching, keeping a stack of
    /// outstanding delimiters as it scans the string.
    func skipToEndOfInterpolatedExpression(isMultilineString: Bool) {
        var openDelimiters: [UnicodeScalar] = []
        var allowNewline: [Bool] = []
        allowNewline.append(isMultilineString)
        
        var inStringLiteral: Bool {
            return openDelimiters.last == "\"" || openDelimiters.last == "'"
        }
        
        while !scanner.isAtEnd {
            // This is a simple scanner, capable of recognizing nested parentheses and
            // string literals but not much else.  The implications of this include not
            // being able to break an expression over multiple lines in an interpolated
            // string.  This limitation allows us to recover from common errors though.
            //
            // On success scanning the expression body, the real lexer will be used to
            // relex the body when parsing the expressions.  We let it diagnose any
            // issues with malformed tokens or other problems.
            let char = scanner.advance()
            switch char {
            // String literals in general cannot be split across multiple lines;
            // interpolated ones are no exception - unless multiline literals.
            case "\n", "\r":
                if allowNewline.last! {
                    continue
                }
                // Will be diagnosed as an unterminated string literal.
                return
            case "\"", "'":
                if !inStringLiteral {
                    // Open string literal.
                    openDelimiters.append(char)
                    allowNewline.append(advanceIfMultilineDelimiter(curPtr: &scanner))
                    continue
                }
                
                // In string literal.

                // Skip if it's an another kind of quote in string literal. e.g. "foo's".
                if openDelimiters.last != scanner.peekBack {
                    continue
                }
                
                // Multi-line string can only be closed by '"""'.
                if allowNewline.last! && !advanceIfMultilineDelimiter(curPtr: &scanner) {
                    continue
                }
                
                // Check whether we have equivalent number of '#'s.
                
                
                // Close string literal.
                _ = openDelimiters.popLast()
                _ = allowNewline.popLast()
            case "\\":
                // We ignore invalid escape sequence here. They should be diagnosed in
                // the real lexer functions.
                if inStringLiteral {
                    let char = scanner.advance()
                    switch char {
                    case "(":
                        // Entering a recursive interpolated expression
                        openDelimiters.append("(")
                        continue
                    case "\n", "\r":
                        // Don't jump over newline/EOF due to preceding backslash.
                        // Let the outer switch to handle it.
                        scanner.putback()
                        continue
                    default:
                        continue
                    }
                }
            // Paren nesting deeper to support "foo = \((a+b)-(c*d)) bar".
            case "(":
                if !inStringLiteral {
                    openDelimiters.append("(")
                }
                continue
            case ")":
                if openDelimiters.isEmpty {
                    // No outstanding open delimiters; we're done.
                    scanner.putback()
                    return
                } else if openDelimiters.last == "(" {
                    // Pop the matching bracket and keep going.
                    _ = openDelimiters.popLast()
                    continue
                } else {
                    // It's a right parenthesis in a string literal.
                    assert(inStringLiteral)
                    continue
                }
            case "/":
                if inStringLiteral {
                    continue
                }
                
                if scanner.peek == "*" {
                    if skipToEndOfSlashStarComment() && !allowNewline.last! {
                        // Multiline comment is prohibited in string literal.
                        // Return the start of the comment.
                        scanner.putback()
                        return
                    }
                } else if scanner.peek == "/" {
                    if !allowNewline.last! {
                        // '//' comment is impossible in single line string literal.
                        // Return the start of the comment.
                        scanner.putback()
                        return
                    }
                    // Advance to the end of the comment.
                    if advanceToEndOfLine() {
                        scanner.advance()
                    }
                }
                continue
            default:
                // Normal token character.
                continue
            }
        }
    }
    
    /// advanceIfMultilineDelimiter - Centralized check for multiline delimiter.
    func advanceIfMultilineDelimiter(curPtr: inout Scanner) -> Bool {
        if curPtr.peekBack == "\"" && curPtr.peek == "\"" && curPtr.peekNext == "\"" {
            curPtr.advance()
            curPtr.advance()
            return true
        }
        return false
    }
    
    private struct CharValue: Equatable {
        private let value: UInt32
        
        static let error = CharValue(UInt32.max - 1)
        static let end = CharValue(UInt32.max)
        
        init(_ value: UInt32) {
            self.value = value
        }
        
        init(_ scalar: UnicodeScalar) {
            self.value = scalar.value
        }
        
        var scalar: UnicodeScalar? {
            return UnicodeScalar(value)
        }
        
        static func ==(lhs: Lexer.CharValue, rhs: Lexer.CharValue) -> Bool {
            return lhs.value == rhs.value
        }
    }
    
    /// lexCharacter - Read a character and return its UTF32 code.  If this is the
    /// end of enclosing string/character sequence (i.e. the character is equal to
    /// 'StopQuote'), this returns ~0U and advances 'CurPtr' pointing to the end of
    /// terminal quote.  If this is a malformed character sequence, it emits a
    /// diagnostic (when EmitDiagnostics is true) and returns ~1U.
    ///
    ///   character_escape  ::= [\][\] | [\]t | [\]n | [\]r | [\]" | [\]' | [\]0
    ///   character_escape  ::= unicode_character_escape
    private func lexCharacter(stopQuote: UnicodeScalar, isMultilineString: Bool) -> CharValue {
        let char = scanner.advance()
        
        switch char {
        case "\"", "'":
            if stopQuote == char {
                if isMultilineString && !advanceIfMultilineDelimiter(curPtr: &scanner) {
                    return CharValue("\"")
                }
                return .end
            }
            
            // Otherwise, this is just a character.
            return CharValue(char)
            
        case "\n", "\r": // String literals cannot have \n or \r in them.
            assert(isMultilineString, "Caller must handle newlines in non-multiline")
            return CharValue(char)
            
        case "\\": // Escapes.
            break
        default:
            // Normal characters are part of the string.
            // If this is a "high" UTF-8 character, validate it.
            if !char.isASCII {
                if !char.isPrintable {
                    if !isMultilineString && char == "\t" {
                        // FIXME: diagnose unprintable ascii character
                    }
                }
            }
            
            return CharValue(char)
        }
        
        // Escape processing.  We already ate the "\".
        switch scanner.peek {
        // Simple single-character escapes.
        case "0": scanner.advance(); return CharValue("\0")
        case "n": scanner.advance(); return CharValue("\n")
        case "r": scanner.advance(); return CharValue("\r")
        case "t": scanner.advance(); return CharValue("\t")
        case "\"": scanner.advance(); return CharValue("\"")
        case "'": scanner.advance(); return CharValue("'")
        case "\\": scanner.advance(); return CharValue("\\")
            
        case "u": //  \u HEX HEX HEX HEX
            scanner.advance()
            if scanner.peek != "{" {
                return .error
            }
            
            let charValue = lexUnicodeEscape()
            if charValue == .error {
                return .error
            }
            
            // Check to see if the encoding is valid.
            guard let _ = charValue.scalar else {
                // FIXME diagnose invalid scalar
                return .error
            }
            
            return charValue
        
        case " ", "\t", "\n", "\r":
            if isMultilineString && maybeConsumeNewlineEscape(curPtr: &scanner) {
                return CharValue("\n")
            }
            fallthrough
        default: // Invalid escape.
          // If this looks like a plausible escape character, recover as though this
          // is an invalid escape.
            scanner.match { $0.isAlphanumeric }
            return .error
        }
    }
    
    /// maybeConsumeNewlineEscape - Check for valid elided newline escape and
    /// move pointer passed in to the character after the end of the line.
    private func maybeConsumeNewlineEscape(curPtr: inout Scanner) -> Bool {
        var tmpPtr = curPtr
        while !tmpPtr.isAtEnd {
            switch tmpPtr.advance() {
            case " ", "\t":
                continue
            case "\r":
                scanner.match("\n")
                fallthrough
            case "\n":
                curPtr = tmpPtr
                return true
            default:
                return false
            }
        }
        
        return false
    }
    
    private func formStringLiteralToken(tokStart: String.UnicodeScalarIndex,
                                        isMultilineString: Bool) -> Token {
        return formToken(kind: .stringLiteral, from: tokStart)
    }
    
    /// lexStringLiteral:
    ///   string_literal ::= ["]([^"\\\n\r]|character_escape)*["]
    ///   string_literal ::= ["]["]["].*["]["]["] - approximately
    ///   string_literal ::= (#+)("")?".*"(\2\1) - "raw" strings
    public func lexStringLiteral() -> Token {
        scanner.putback()
        let tokStart = scanner.current
        let quoteChar = scanner.advance()
        
        // NOTE: We only allow single-quote string literals so we can emit useful
        // diagnostics about changing them to double quotes.
        assert(quoteChar == "\"" || quoteChar == "'", "Unexpected start")
        let isMultilineString = advanceIfMultilineDelimiter(curPtr: &scanner)
        if isMultilineString && scanner.peek == "\n" && scanner.peek == "\r" {
            // FIXME: diagnose illegal multiline string start, fixit: insert \n
        }
        
        var wasErroneous = false
        while true {
            // Handle string interpolation.
            
            if (scanner.peek == "\\" && scanner.peekNext == "(") {
                scanner.advance() // skip the "\"
                scanner.advance() // skip the "("
                // Consume tokens until we hit the corresponding ')'.
                skipToEndOfInterpolatedExpression(isMultilineString: isMultilineString)
                
                if (scanner.peek == ")") {
                    // Successfully scanned the body of the expression literal.
                    scanner.advance()
                } else if (scanner.peek == "\r" || scanner.peek == "\n") && isMultilineString {
                    // The only case we reach here is unterminated single line string in the
                    // interpolation. For better recovery, go on after emitting an error.
                    wasErroneous = true
                } else {
                    return formToken(kind: .unknown, from: tokStart)
                }
            }
            
            // String literals cannot have \n or \r in them (unless multiline).
            if (scanner.peek == "\r" || scanner.peek == "\n" && !isMultilineString) || scanner.isAtEnd {
                // FIXME: diagnose unterminated string
                return formToken(kind: .unknown, from: tokStart)
            }
            
            let charValue = lexCharacter(stopQuote: quoteChar, isMultilineString: isMultilineString)
            // This is the end of string, we are done.
            if charValue == .end {
                break
            }
            
            // Remember we had already-diagnosed invalid characters.
            wasErroneous = wasErroneous || charValue == .error
        }
        
        if quoteChar == "'" {
            assert(!isMultilineString, "Single quoted string cannot have custom delimitor, nor multiline")
        }
        
        if wasErroneous {
            return formToken(kind: .unknown, from: tokStart)
        }
        
        return formStringLiteralToken(tokStart: tokStart, isMultilineString: isMultilineString)
    }
    
    /// lexEscapedIdentifier:
    ///   identifier ::= '`' identifier '`'
    ///
    /// If it doesn't match this production, the leading ` is a punctuator.
    public func lexEscapedIdentifier() -> Token {
        scanner.putback()
        let quote = scanner.current
        scanner.advance()
        
        if scanner.match({ $0.isIdentifierHead }) {
            scanner.skip { $0.isIdentifierBody }
            
            // If we have the terminating "`", it's an escaped identifier.
            if scanner.match("`") {
                return formToken(kind: .identifier, from: quote)
            }
        }
        
        // Special case; allow '`$`'.
        if scanner.peek == "$" && scanner.peekNext == "`" {
            scanner.advance() // advance over "$"
            scanner.advance() // advance over "`"
            
            // FIXME: mark it as an escaped identifier?
            return formToken(kind: .identifier, from: quote)
        }
        
        return formToken(kind: .backtick, from: quote)
    }
    
    /// Kinds of conflict marker which the lexer might encounter.
    enum ConflictMarkerKind {
        /// A normal or diff3 conflict marker, initiated by at least 7 "<"s,
        /// separated by at least 7 "="s or "|"s, and terminated by at least 7 ">"s.
        case normal
        /// A Perforce-style conflict marker, initiated by 4 ">"s,
        /// separated by 4 "="s, and terminated by 4 "<"s.
        case perforce
    }
    
    /// Find the end of a version control conflict marker.
    func findConflictEnd(cmk: ConflictMarkerKind) -> Bool {
        let terminator = cmk == .perforce ? "<<<<\n" : ">>>>>>> "
        let termLen = terminator.count
        
        // Get a reference to the rest of the buffer minus the length of the start
        // of the conflict marker.
        return true
    }
    
    /// Try to lex conflict markers by checking for the presence of the start and
    /// end of the marker in diff3 or Perforce style respectively.
    public func tryLexConflictMarker(eatNewline: Bool) -> Bool {
        scanner.putback()
        // Only a conflict marker if it starts at the beginning of a line.
        if scanner.current != scanner.contentStart && scanner.peek != "\n" && scanner.peek != "\r" {
            return false
        }
        
        // Check to see if we have <<<<<<< or >>>>.
        if !scanner.starts(with: "<<<<<<< ") && !scanner.starts(with: ">>>> ") {
            return false
        }
        
        let kind: ConflictMarkerKind = scanner.peek == "<" ? .normal : .perforce
        
        if findConflictEnd(cmk: kind) {
            // Diagnose at the conflict marker, then jump ahead to the end.
            
            // Skip ahead to the end of the marker.
            if !scanner.isAtEnd {
                skipToEndOfLine(eatNewline: eatNewline)
            }
            return true
        }
        
        // No end of conflict marker found.
        return false
    }
    
    /// <#T##IndexPath#
    public func tryLexEditorPlaceholder() -> Token {
        assert(scanner.peekBack == "<" && scanner.peek == "#")
        let tokStart = scanner.index(offsetBy: -1)
        
        var ptr = scanner
        ptr.advance()
        
        while ptr.index(offsetBy: 1) < ptr.end {
            if ptr.peek == "\n" {
                continue
            }
            if ptr.peek == "<" && ptr.peekNext == "#" {
                continue
            }
            if ptr.peek == "#" && ptr.peekNext == ">" {
                // Found it. Flag it as error (or warning, if in playground mode) for the
                // rest of the compiler pipeline and lex it as an identifier.
                ptr.advance(by: 2)
                scanner.rewind(to: ptr.current)
                return formToken(kind: .identifier, from: tokStart)
            }
            
            ptr.advance()
        }
        
        // Not a well-formed placeholder.
        return lexOperatorIdentifier()
    }
}
