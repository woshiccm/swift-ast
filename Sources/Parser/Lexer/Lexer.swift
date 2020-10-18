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
    
    public func formToken(kind: TokenKind) -> Token {
        return formToken(kind: .eof)
    }
    
    public func lex() {
        
    }
    
    public func lexImpl() -> Token {
        guard !scanner.isAtEnd else {
            return formToken(kind: .eof)
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
            
        case "@": return formToken(kind: .atSign)
        case "{": return formToken(kind: .leftBrace)
        case "[": return formToken(kind: .leftSquareBracket)
        case "(": return formToken(kind: .leftParen)
        case "}": return formToken(kind: .rightBrace)
        case "]": return formToken(kind: .rightSquareBracket)
        case ")": return formToken(kind: .rightParen)
            
        case ",": return formToken(kind: .comma)
        case ";": return formToken(kind: .semicolon)
        case ":": return formToken(kind: .colon)
        case "\\": return formToken(kind: .backslash)
            
        case "#":
            return lexHash()
            
        case "/":
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
        
        return formToken(kind: .eof)
    }
    
    public func lexTrivia(pieces: inout Trivia) {
        
    }
    
    /// Advance to the end of the line.
    /// If EatNewLine is true, CurPtr will be at end of newline character.
    /// Otherwise, CurPtr will be at newline character.
    public func skipToEndOfLine(eatNewline: Bool) {
        
    }
    
    /// Skip to the end of the line of a // comment.
    public func skipSlashSlashComment(eatNewline: Bool) {
        
    }
    
    /// Skip a #! hashbang line.
    public func skipHashbang(eatNewline: Bool) {
        
    }
    
    /// skipSlashStarComment - /**/ comments are skipped (treated as whitespace).
    /// Note that (unlike in C) block comments can be nested.
    public func skipSlashStarComment() {
        
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
        case "if": return formToken(kind: .poundIfKeyword)
        case "else": return formToken(kind: .poundElseKeyword)
        case "elseif": return formToken(kind: .poundElseifKeyword)
        case "endif": return formToken(kind: .poundEndifKeyword)
        case "keyPath": return formToken(kind: .poundKeyPathKeyword)
        case "line": return formToken(kind: .poundLineKeyword)
        case "sourceLocation": return formToken(kind: .poundSourceLocationKeyword)
        case "selector": return formToken(kind: .poundSelectorKeyword)
        case "file": return formToken(kind: .poundFileKeyword)
        case "column": return formToken(kind: .poundColumnKeyword)
        case "function": return formToken(kind: .poundFunctionKeyword)
        case "dsohandle": return formToken(kind: .poundDsohandleKeyword)
        default:
            // Otherwise, unwind the parser to identifier found and just return a .pound token.
            scanner.rewind(to: tmpPtr)
            scanner.advance() // over the pound
            return formToken(kind: .pound)
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
            return formToken(kind: kind)
        }
        return formToken(kind: .identifier(text))
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
            return formToken(kind: .identifier(text))
        }
        
        if !isAllDigits {
            return formToken(kind: .identifier(text))
        } else {
            return formToken(kind: .dollarIdentifier(text))
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
            return formToken(kind: .equal)
        case "&" where !(leftBound == rightBound || leftBound):
            return formToken(kind: .prefixAmpersand)
        case ".":
            if  (leftBound == rightBound) {
                return formToken(kind: .period)
            }
            if (rightBound) {
                return formToken(kind: .prefixPeriod)
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
                return formToken(kind: .period)
            }
            
            // Otherwise, it is probably a missing member.
            return formToken(kind: .unknown(text))
        case "?":
            if leftBound {
                return formToken(kind: .postfixQuestionMark)
            }
            return formToken(kind: .postfixQuestionMark)
        case "->":
            return formToken(kind: .arrow)
        case "*/":
            return formToken(kind: .unknown(text))
        case _ where text.count > 2:
            var finder = Scanner(text)
            // Verify there is no "*/" in the middle of the identifier token, we reject
            // it as potentially ending a block comment.
            finder.skip { $0 != "*"}
            if finder.peekNext == "/" {
                return formToken(kind: .unknown(text))
            }
            
        default: break
        }
        
        switch (leftBound, rightBound) {
        case (true, true):
            return formToken(kind: .unspacedBinaryOperator(text))
        case (false, false):
            return formToken(kind: .spacedBinaryOperator(text))
        case (true, false):
            return formToken(kind: .postfixOperator(text))
        case (false, true):
            return formToken(kind: .prefixOperator(text))
        }
    }
    
    public func lexHexNumber() -> Token {
        return formToken(kind: .eof)
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
        return formToken(kind: .eof)
    }
    
    /// lexStringLiteral:
    ///   string_literal ::= ["]([^"\\\n\r]|character_escape)*["]
    ///   string_literal ::= ["]["]["].*["]["]["] - approximately
    ///   string_literal ::= (#+)("")?".*"(\2\1) - "raw" strings
    public func lexStringLiteral() -> Token {
        return formToken(kind: .eof)
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
                return formToken(kind: .identifier(""))
            }
        }
        
        // Special case; allow '`$`'.
        if scanner.peek == "$" && scanner.peekNext == "`" {
            scanner.advance() // advance over "$"
            scanner.advance() // advance over "`"
            
            // FIXME: mark it as an escaped identifier?
            return formToken(kind: .identifier(""))
        }
        
        return formToken(kind: .backtick)
    }
    
    public func resetToOffset(_ offset: Int) {
        
    }
    
    public func restoreState(_ state: LexerState) {
        
    }
}
