import Foundation

public struct Token {
    
    public let kind: TokenKind
    public let text: String
    public var commentLength: Int {
        return 0
    }
    
    public var isAnyOperator: Bool {
        return false
    }
    
    /// Determine whether this token occurred at the start of a line.
    public var isAtStartOfLine: Bool {
        return true
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
