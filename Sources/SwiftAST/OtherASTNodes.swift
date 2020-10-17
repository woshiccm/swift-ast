import Foundation
import Parser

// MARK: UnknownSyntax

public struct UnknownNode: ASTNodeProtocol {
    
}

// MARK: TokenSyntax

public struct TokenNode: ASTNodeProtocol {
    public var text: String {
        return tokenKind.text
    }
    public let tokenKind: TokenKind
}
