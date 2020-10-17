import Foundation

public class Parser {
    
    private let lexer: Lexer
    private let source: String
    
    public init(source: String) {
        self.source = source
        self.lexer = Lexer(source: source)
    }
    
    public init(url: URL) {
        let fileData = try? Data(contentsOf: url)
        let source = fileData?.withUnsafeBytes { buf in
          return String.fromBuffer(buf.bindMemory(to: UInt8.self))
        } ?? ""
        self.source = source
        self.lexer = Lexer(source: source)
    }
    
    public func parse() {
        
    }
    
    func parseTopLevel() {
        
    }
    
    func parseExpr() {
        
    }
    
    
}
