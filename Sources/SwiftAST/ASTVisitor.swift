import Foundation

/// The enum describes how the SyntaxVistor should continue after visiting
/// the current node.
public enum ASTVisitorContinueKind {

  /// The visitor should visit the descendents of the current node.
  case visitChildren

  /// The visitor should avoid visiting the descendents of the current node.
  case skipChildren
}

open class ASTVisitor {
    public init() {}
    
    open func visit(_ node: UnknownDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: UnknownExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: UnknownStmt) -> ASTVisitorContinueKind {
      return .visitChildren
    }

    open func visit(_ node: InOutExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: PoundColumnExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: TryExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: IdentifierExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: SuperRefExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: NilLiteralExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: DiscardAssignmentExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: AssignmentExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: SequenceExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: PoundLineExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: PoundFileExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: PoundFilePathExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: PoundFunctionExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: PoundDsohandleExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: SymbolicReferenceExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: PrefixOperatorExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: BinaryOperatorExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: FloatLiteralExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: TupleExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: ArrayExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: DictionaryExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: IntegerLiteralExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: BooleanLiteralExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: TernaryExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: MemberAccessExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: IsExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: AsExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: TypeExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: ClosureExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: UnresolvedPatternExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: FunctionCallExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: SubscriptExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: OptionalChainingExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: ForcedValueExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: PostfixUnaryExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: SpecializeExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: KeyPathExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: KeyPathBaseExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: ObjcSelectorExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: EditorPlaceholderExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: ObjectLiteralExpr) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: TypealiasDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: AssociatedtypeDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: IfConfigDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: PoundErrorDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: PoundWarningDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: ClassDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: StructDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: ProtocolDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: ExtensionDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: FunctionDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: InitializerDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: DeinitializerDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: SubscriptDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: ImportDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    open func visit(_ node: AccessorDecl) -> ASTVisitorContinueKind {
      return .visitChildren
    }
    
    
    
    
}
