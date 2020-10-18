import Foundation

extension Lexer {
    
    /// Is the operator beginning at the given character "left-bound"?
    func isLeftBound(_ tokBegin: Pointer) -> Bool {
        // don't mess with original scanner
        var scanner = self.scanner
        
        scanner.rewind(to: tokBegin)
        
        if scanner.isAtStart { return false }
        
        scanner.putback()
        switch scanner.peek {
        case " ": fallthrough
        case "\r": fallthrough
        case "\n": fallthrough
        case "\t": fallthrough // whitespace
        case "(": fallthrough
        case "[": fallthrough
        case "{": fallthrough // opening delimiters
        case ",": fallthrough
        case ";": fallthrough
        case ":": fallthrough // expression separators
        case "\0": // whitespace / last char in file
            return false
            
        case "/":
            if scanner.isAtStart { return true }
            scanner.putback()
            return scanner.peek != "*" // End of a slash-star comment, so whitespace.
        
        default: return true
        }
    }
    
    /// Is the operator ending at the given character (actually one past the end)
    /// "right-bound"?
    ///
    /// The code-completion point is considered right-bound.
    func isRightBound(_ tokEnd: Pointer, isLeftBound: Bool) -> Bool {
        // don't mess with original scanner
        var scanner = self.scanner
        
        scanner.rewind(to: tokEnd)
        
        switch scanner.peek {
        case " ": fallthrough
        case "\r": fallthrough
        case "\n": fallthrough
        case "\t": fallthrough // whitespace
        case ")": fallthrough
        case "]": fallthrough
        case "}": fallthrough // closing delimiters
        case ",": fallthrough
        case ";": fallthrough
        case ":": fallthrough // expression separators
        case "\0": // whitespace / last char in file
            return false
        
        case ".":
            // Prefer the '^' in "x^.y" to be a postfix op, not binary, but the '^' in
            // "^.y" to be a prefix op, not binary.
            return !isLeftBound
            
        case "/" where (scanner.peekNext == "/" || scanner.peekNext == "*"):
            return false
            
        default:
            return true
        }
    }
}
