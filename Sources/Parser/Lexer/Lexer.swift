import Foundation

public class Lexer {
    typealias Pointer = String.UnicodeScalarView.Index
    
    var content: String.UnicodeScalarView
    
    private(set) var nextToken: Token
    
    /// The current leading trivia for the next token.
    var leadingTrivia: Trivia
    
    /// The current trailing trivia for the next token.
    var trailingTrivia: Trivia
    
    private var curPtr: Pointer
    
    let startPointer: Pointer
    let endPointer: Pointer
    
    private var nextPtr: Pointer {
       return content.index(after: curPtr)
     }
    
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
        self.curPtr = content.startIndex
        self.nextToken = Token(kind: .unknown(""), text: "")
        leadingTrivia = Trivia.zero
        trailingTrivia = Trivia.zero
        
        startPointer = content.startIndex
        endPointer = content.endIndex
    }
    
    public func formToken(kind: TokenKind) {
        
    }
    
    public func lex() {
        
    }
    
    public func lexImpl() {
        leadingTrivia = Trivia.zero
        trailingTrivia = Trivia.zero
        
        lexTrivia(pieces: &leadingTrivia)
        
        let TokStart = curPtr
        var char: Unicode.Scalar = content[nextPtr]
        
        switch char {
        case "\n", "\r":
            print("Newlines should be eaten by lexTrivia as LeadingTrivia")
        case " ", "\t":
            print("Whitespaces should be eaten by lexTrivia as LeadingTrivia")
            
        case "@": formToken(kind: .atSign)
        case "{": formToken(kind: .leftBrace)
        case "[": formToken(kind: .leftSquareBracket)
        case "(": formToken(kind: .leftParen)
        case "}": formToken(kind: .rightBrace)
        case "]": formToken(kind: .rightSquareBracket)
        case ")": formToken(kind: .rightParen)
            
        case ",": formToken(kind: .comma)
        case ";": formToken(kind: .semicolon)
        case ":": formToken(kind: .colon)
        case "\\": formToken(kind: .backslash)
            
        case "#":
            lexHash()
            
        case "/":
            lexOperatorIdentifier()
        case "%":
            lexOperatorIdentifier()
        case "!":
            lexOperatorIdentifier()
        case "?":
            lexOperatorIdentifier()
        case "<":
            lexOperatorIdentifier()
        case ">":
            lexOperatorIdentifier()
        case "=", "-", "+", "*", "&", "|", "^", "~", ".":
            lexOperatorIdentifier()
        case "a"..."z", "A"..."Z", "_":
            lexIdentifier()
        case "$":
            lexDollarIdent()
        case "0"..."9":
            lexNumber()
        case "\"":
            lexStringLiteral()
        case "`":
            lexEscapedIdentifier()
        default:
            break
        }
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
    public func lexHash() {
        
    }
    
    /// lexIdentifier - Match [a-zA-Z_][a-zA-Z_$0-9]*
    public func lexIdentifier() {
        
    }
    
    /// lexDollarIdent - Match $[0-9a-zA-Z_$]+
    public func lexDollarIdent() {
        
    }
    
    /// lexOperatorIdentifier - Match identifiers formed out of punctuation.
    public func lexOperatorIdentifier() {
        var TokStart = content.index(before: curPtr)
        curPtr = TokStart
        
        do {
            // '.' cannot appear in the middle of an operator unless the operator
            // started with a '.'.
            if content[curPtr] == "." && content[TokStart] != "." {
                return
            }
        }
    }
    
    public func lexHexNumber() {
        
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
    public func lexNumber() {
        
    }
    
    /// lexStringLiteral:
    ///   string_literal ::= ["]([^"\\\n\r]|character_escape)*["]
    ///   string_literal ::= ["]["]["].*["]["]["] - approximately
    ///   string_literal ::= (#+)("")?".*"(\2\1) - "raw" strings
    public func lexStringLiteral() {
        
    }
    
    /// lexEscapedIdentifier:
    ///   identifier ::= '`' identifier '`'
    ///
    /// If it doesn't match this production, the leading ` is a punctuator.
    public func lexEscapedIdentifier() {
        
    }
    
    public func resetToOffset(_ offset: Int) {
        
    }
    
    public func restoreState(_ state: LexerState) {
        
    }
}
