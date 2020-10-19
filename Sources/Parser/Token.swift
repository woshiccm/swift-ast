import Foundation

/// Token - This structure provides full information about a lexed token.
/// It is not intended to be space efficient, it is intended to return as much
/// information as possible about each returned token.  This is expected to be
/// compressed into a smaller form if memory footprint is important.
///
public struct Token {
    
    /// Kind - The actual flavor of token this is.
    public let kind: TokenKind
    
    /// Text - The actual string covered by the token in the source buffer.
    public let text: String
    
    /// Whether this token is the first token on the line.
    private(set) var isAtStartOfLine: Bool = true
    
    public var commentLength: Int {
        return 0
    }
    
    public var isAnyOperator: Bool {
        return false
    }
    
    /// True if the token is any keyword.
    public var isKeyword: Bool {
        return false
    }
    
    /// True if the token is any literal.
    public var isLiteral: Bool {
        return false
    }
    
    public var hasComment: Bool {
        return commentLength != 0
    }
    
    public func getCommentStart() {
        
    }
}
