import Foundation

// MARK: - CodeBlockItemSyntax

// MARK: - CodeBlockSyntax

// MARK: - DeclNameArgumentSyntax

// MARK: - DeclNameArgumentsSyntax

// MARK: - TupleExprElementSyntax

// MARK: - ArrayElementSyntax

// MARK: - DictionaryElementSyntax

// MARK: - ClosureCaptureItemSyntax

// MARK: - ClosureCaptureSignatureSyntax

// MARK: - ClosureParamSyntax

// MARK: - ClosureSignatureSyntax

// MARK: - StringSegmentSyntax

// MARK: - ExpressionSegmentSyntax

// MARK: - ObjcNamePieceSyntax

// MARK: - TypeInitializerClauseSyntax

// MARK: - ParameterClauseSyntax

public struct ParameterClause: ASTNodeProtocol {
    
}

// MARK: - ReturnClauseSyntax

public struct ReturnClause: ASTNodeProtocol {
    
}

// MARK: - FunctionSignatureSyntax

public struct FunctionSignature: ASTNodeProtocol {
    enum Cursor: Int {
      case input
      case throwsOrRethrowsKeyword
      case output
    }
    
    public let input: ParameterClause
    public let throwsOrRethrowsKeyword: TokenNode?
    public let output: ReturnClause?
}

// MARK: - IfConfigClauseSyntax

// MARK: - PoundSourceLocationArgsSyntax

// MARK: - DeclModifierSyntax

public struct DeclModifier: ASTNodeProtocol {
    enum Cursor: Int {
      case name
      case detailLeftParen
      case detail
      case detailRightParen
    }
    
    
}

// MARK: - InheritedTypeSyntax

public struct InheritedType: ASTNodeProtocol {
    enum Cursor: Int {
      case typeName
      case trailingComma
    }
}

// MARK: - TypeInheritanceClauseSyntax

public struct TypeInheritanceClause: ASTNodeProtocol {
    enum Cursor: Int {
      case colon
      case inheritedTypeCollection
    }
    
    public let typeInheritanceList: [InheritedType]
}

// MARK: - MemberDeclBlockSyntax

public struct MemberDeclBlock: ASTNodeProtocol {
    
}

// MARK: - MemberDeclListItemSyntax

public struct MemberDeclListItem: ASTNodeProtocol {
    
}

// MARK: - SourceFileSyntax

// MARK: - InitializerClauseSyntax

public struct InitializerClause: ASTNodeProtocol {
    
}

// MARK: - FunctionParameterSyntax

public struct FunctionParameter: ASTNodeProtocol {
    enum Cursor: Int {
      case attributes
      case firstName
      case secondName
      case type
      case ellipsis
      case defaultArgument
      case trailingComma
    }
    
    public let attributes: [Attr]
    public let firstName: TokenNode?
    public let secondName: TokenNode?
    public let type: Type
    public let defaultArgument: InitializerClause?
}

// MARK: - AccessLevelModifierSyntax

// MARK: - AccessPathComponentSyntax

// MARK: - AccessorParameterSyntax

// MARK: - AccessorBlockSyntax

// MARK: - PatternBindingSyntax

// MARK: - EnumCaseElementSyntax

// MARK: - OperatorPrecedenceAndTypesSyntax

// MARK: - PrecedenceGroupRelationSyntax

// MARK: - PrecedenceGroupNameElementSyntax

// MARK: - PrecedenceGroupAssignmentSyntax

// MARK: - PrecedenceGroupAssociativitySyntax

// MARK: - CustomAttributeSyntax

// MARK: - AttributeSyntax

// MARK: - LabeledSpecializeEntrySyntax

// MARK: - NamedAttributeStringArgumentSyntax

// MARK: - DeclNameSyntax

// MARK: - ImplementsAttributeArgumentsSyntax

// MARK: - ObjCSelectorPieceSyntax

// MARK: - DifferentiableAttributeArgumentsSyntax

// MARK: - DifferentiationParamsClauseSyntax

// MARK: - DifferentiationParamsSyntax

// MARK: - DifferentiationParamSyntax

// MARK: - DifferentiableAttributeFuncSpecifierSyntax

// MARK: - FunctionDeclNameSyntax

// MARK: - WhereClauseSyntax

// MARK: - YieldListSyntax

// MARK: - ConditionElementSyntax

// MARK: - AvailabilityConditionSyntax

// MARK: - MatchingPatternConditionSyntax

// MARK: - OptionalBindingConditionSyntax

// MARK: - ElseIfContinuationSyntax

// MARK: - ElseBlockSyntax

// MARK: - SwitchCaseSyntax

// MARK: - SwitchDefaultLabelSyntax

// MARK: - CaseItemSyntax

// MARK: - SwitchCaseLabelSyntax

// MARK: - CatchClauseSyntax

// MARK: - GenericWhereClauseSyntax

public struct GenericWhereClause: ASTNodeProtocol {
    enum Cursor: Int {
      case whereKeyword
      case requirementList
    }
    
    public let requirementList: [GenericRequirement]
}

// MARK: - GenericRequirementSyntax

public struct GenericRequirement: ASTNodeProtocol {
    
}

// MARK: - SameTypeRequirementSyntax

public struct SameTypeRequirement: ASTNodeProtocol {
    enum Cursor: Int {
      case leftTypeIdentifier
      case equalityToken
      case rightTypeIdentifier
    }
    
    
}

// MARK: - GenericParameterSyntax

// MARK: - GenericParameterClauseSyntax

public struct GenericParameterClause: ASTNodeProtocol {
    
}

// MARK: - ConformanceRequirementSyntax

public struct ConformanceRequirement: ASTNodeProtocol {

}

// MARK: - CompositionTypeElementSyntax

// MARK: - TupleTypeElementSyntax

// MARK: - GenericArgumentSyntax

// MARK: - GenericArgumentClauseSyntax

// MARK: - TypeAnnotationSyntax

// MARK: - TuplePatternElementSyntax

// MARK: - AvailabilityArgumentSyntax

// MARK: - AvailabilityLabeledArgumentSyntax

// MARK: - AvailabilityVersionRestrictionSyntax

// MARK: - VersionTupleSyntax


