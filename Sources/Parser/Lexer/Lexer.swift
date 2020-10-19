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
    
    public init(source: String) {
        self.source = source
        self.content = source.unicodeScalars
        self.scanner = Scanner(source)
        self.nextToken = Token(kind: .unknown(""), text: "")
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
            if scanner.match("/") { // "//"
                skipSlashSlashComment(eatNewline: true)
                return lexImpl()
            } else if scanner.match("*") { // "/*"
                skipSlashStarComment()
                return lexImpl()
            }
            return lexOperatorIdentifier()
        case "%":
            return lexOperatorIdentifier()
        case "!":
            return lexOperatorIdentifier()
        case "?":
            return lexOperatorIdentifier()
        case "<":
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
        case "\"":
            return lexStringLiteral()
        case "`":
            return lexEscapedIdentifier()
        default:
            break
        }
        
        return formToken(kind: .unknown(""), from: tokStart)
    }
    
    public func lexTrivia(pieces: inout Trivia) {
        
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
        return formToken(kind: .identifier(text), with: text)
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
            return formToken(kind: .identifier(text), with: text)
        }
        
        if !isAllDigits {
            return formToken(kind: .identifier(text), with: text)
        } else {
            return formToken(kind: .dollarIdentifier(text), with: text)
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
            return formToken(kind: .unknown(text), from: tokStart)
        case "?":
            if leftBound {
                return formToken(kind: .postfixQuestionMark, with: text)
            }
            return formToken(kind: .postfixQuestionMark, with: text)
        case "->":
            return formToken(kind: .arrow, with: text)
        case "*/":
            return formToken(kind: .unknown(text), with: text)
        case _ where text.count > 2:
            var finder = Scanner(text)
            // Verify there is no "*/" in the middle of the identifier token, we reject
            // it as potentially ending a block comment.
            finder.skip { $0 != "*"}
            if finder.peekNext == "/" {
                return formToken(kind: .unknown(text), with: text)
            }
            
        default: break
        }
        
        switch (leftBound, rightBound) {
        case (true, true):
            return formToken(kind: .unspacedBinaryOperator(text), with: text)
        case (false, false):
            return formToken(kind: .spacedBinaryOperator(text), with: text)
        case (true, false):
            return formToken(kind: .postfixOperator(text), with: text)
        case (false, true):
            return formToken(kind: .prefixOperator(text), with: text)
        }
    }
    
    public func lexHexNumber() -> Token {
        return formToken(kind: .eof, with: "")
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
        return formToken(kind: .eof, with: "")
    }
    
    /// lexStringLiteral:
    ///   string_literal ::= ["]([^"\\\n\r]|character_escape)*["]
    ///   string_literal ::= ["]["]["].*["]["]["] - approximately
    ///   string_literal ::= (#+)("")?".*"(\2\1) - "raw" strings
    public func lexStringLiteral() -> Token {
        return formToken(kind: .eof, with: "")
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
                return formToken(kind: .identifier(""), from: quote)
            }
        }
        
        // Special case; allow '`$`'.
        if scanner.peek == "$" && scanner.peekNext == "`" {
            scanner.advance() // advance over "$"
            scanner.advance() // advance over "`"
            
            // FIXME: mark it as an escaped identifier?
            return formToken(kind: .identifier(""), from: quote)
        }
        
        return formToken(kind: .backtick, from: quote)
    }
    
    public func resetToOffset(_ offset: Int) {
        
    }
    
    public func restoreState(_ state: LexerState) {
        
    }
}
