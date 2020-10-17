import Foundation

// MARK: - UnknownDeclSyntax

public struct UnknownDecl: DeclProtocol {
    
}

// MARK: - TypealiasDeclSyntax

public struct TypealiasDecl: DeclProtocol {
    
}

// MARK: - AssociatedtypeDeclSyntax

public struct AssociatedtypeDecl: DeclProtocol {
    
}

// MARK: - IfConfigDeclSyntax

public struct IfConfigDecl: DeclProtocol {
    
}

// MARK: - PoundErrorDeclSyntax

public struct PoundErrorDecl: DeclProtocol {
    
}

// MARK: - PoundWarningDeclSyntax

public struct PoundWarningDecl: DeclProtocol {
    
}

// MARK: - PoundSourceLocationSyntax

public struct PoundSourceLocation: DeclProtocol {
    
}

// MARK: - ClassDeclSyntax

public struct ClassDecl: DeclProtocol {
    enum Cursor: Int {
      case attributes
      case modifiers
      case identifier
      case genericParameterClause
      case inheritanceClause
      case genericWhereClause
      case members
    }
    
    public let attributes: [Attr]
    public let modifiers: [DeclModifier]
    public let members: [DeclMember]
    public let identifier: TokenNode
    public let genericParameterClause: GenericParameterClause?
    public let inheritanceClause: TypeInheritanceClause?
    public let genericWhereClause: GenericWhereClause?
}

// MARK: - StructDeclSyntax

public typealias DeclMember = DeclProtocol

public struct StructDecl: DeclProtocol {
    enum Cursor: Int {
      case attributes
      case modifiers
      case identifier
      case genericParameterClause
      case inheritanceClause
      case genericWhereClause
      case members
    }
    
    public let attributes: [Attr]
    public let modifiers: [DeclModifier]
    public let members: [DeclMember]
    public let identifier: TokenNode
    public let genericParameterClause: GenericParameterClause?
    public let inheritanceClause: TypeInheritanceClause?
    public let genericWhereClause: GenericWhereClause?
}

// MARK: - ProtocolDeclSyntax

public struct ProtocolDecl: DeclProtocol {
    enum Cursor: Int {
      case attributes
      case modifiers
      case identifier
      case inheritanceClause
      case genericWhereClause
      case members
    }
    
    public let attributes: [Attr]
    public let modifiers: [DeclModifier]
    public let members: [DeclMember]
    public let identifier: TokenNode
    public let inheritanceClause: TypeInheritanceClause?
    public let genericWhereClause: GenericWhereClause?
}

// MARK: - ExtensionDeclSyntax

public struct ExtensionDecl: DeclProtocol {
    
}

// MARK: - FunctionDeclSyntax

public struct FunctionDecl: DeclProtocol {
    enum Cursor: Int {
      case attributes
      case modifiers
      case identifier
      case genericParameterClause
      case signature
      case genericWhereClause
      case body
    }
    
    public let attributes: [Attr]
    public let modifiers: [DeclModifier]
    public let identifier: TokenNode
    public let genericParameterClause: GenericParameterClause?
    public let genericWhereClause: GenericWhereClause?
    
    
    
}

// MARK: - InitializerDeclSyntax

public struct InitializerDecl: DeclProtocol {
    
}

// MARK: - DeinitializerDeclSyntax

public struct DeinitializerDecl: DeclProtocol {
    
}

// MARK: - SubscriptDeclSyntax

public struct SubscriptDecl: DeclProtocol {
    
}

// MARK: - ImportDeclSyntax

public struct ImportDecl: DeclProtocol {
    
}

// MARK: - AccessorDeclSyntax

public struct AccessorDecl: DeclProtocol {
    
}

// MARK: - VariableDeclSyntax

public struct VariableDecl: DeclProtocol {
    
}

// MARK: - EnumCaseDeclSyntax

public struct EnumCaseDecl: DeclProtocol {
    
}

// MARK: - EnumDeclSyntax

public struct EnumDecl: DeclProtocol {
    
}

// MARK: - OperatorDeclSyntax

public struct OperatorDecl: DeclProtocol {
    
}

// MARK: - PrecedenceGroupDeclSyntax

public struct PrecedenceGroupDecl: DeclProtocol {
    
}
