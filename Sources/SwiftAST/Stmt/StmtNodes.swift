import Foundation

// MARK: - UnknownStmtSyntax

public struct UnknownStmt: StmtProtocol {
    
}

// MARK: - ContinueStmtSyntax

public struct ContinueStmt: StmtProtocol {
    
    enum Cursor: Int {
      case continueKeyword
      case label
    }
    
    public init?(_ node: ASTNode) {
      
    }
    
}

// MARK: - WhileStmtSyntax

public struct WhileStmt: StmtProtocol {
    
}

// MARK: - DeferStmtSyntax

public struct DeferStmt: StmtProtocol {
    
}

// MARK: - ExpressionStmtSyntax

public struct ExpressionStmt: StmtProtocol {
    
}

// MARK: - RepeatWhileStmtSyntax

public struct RepeatWhileStmt: StmtProtocol {
    
}

// MARK: - GuardStmtSyntax

public struct GuardStmt: StmtProtocol {
    
}

// MARK: - ForInStmtSyntax

public struct ForInStmt: StmtProtocol {
    
}

// MARK: - SwitchStmtSyntax

public struct SwitchStmt: StmtProtocol {
    
}

// MARK: - DoStmtSyntax

public struct DoStmt: StmtProtocol {
    
}

// MARK: - ReturnStmtSyntax

public struct ReturnStmt: StmtProtocol {
    
}

// MARK: - YieldStmtSyntax

public struct YieldStmt: StmtProtocol {
    
}

// MARK: - FallthroughStmtSyntax

public struct FallthroughStmt: StmtProtocol {
    
}

// MARK: - BreakStmtSyntax

public struct BreakStmt: StmtProtocol {
    
}

// MARK: - DeclarationStmtSyntax

public struct DeclarationStmt: StmtProtocol {
    
}

// MARK: - ThrowStmtSyntax

public struct ThrowStmt: StmtProtocol {
    
}

// MARK: - IfStmtSyntax

public struct IfStmt: StmtProtocol {
    enum Cursor: Int {
      case labelName
      case labelColon
      case ifKeyword
      case conditions
      case body
      case elseKeyword
      case elseBody
    }
    
    public init?(_ node: ASTNode) {
      
    }
    
    
    
}

// MARK: - PoundAssertStmtSyntax

public struct PoundAssertStmt {
    
}

