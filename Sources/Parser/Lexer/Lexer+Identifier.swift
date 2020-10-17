import Foundation

extension Lexer {
    
    /// Is the operator beginning at the given character "left-bound"?
    func isLeftBound(_ tokBegin: Pointer) -> Bool {
        let pointer = content.index(before: tokBegin)
        switch content[pointer] {
        case " ", "\r", "\n", "\t", "(", "[", "{", ",", ";" , ":", "\0":
            return false
        case "/":
            if pointer != startPointer {
                return false // End of a slash-star comment, so whitespace.
            } else {
                return true
            }
        default: return true
        }
    }
    
    /// Is the operator ending at the given character (actually one past the end)
    /// "right-bound"?
    ///
    /// The code-completion point is considered right-bound.
    func isRightBound(_ tokEnd: Pointer, isLeftBound: Bool) -> Bool {
        switch content[tokEnd] {
        case " ", "\r", "\n", "\t", ")", "]", "}", ",", ";", ":", "\0":
            return false
        case ".":
            return !isLeftBound
        case "/":
            // A following comment counts as whitespace, so this token is not right bound.
            let pointer = content.index(after: tokEnd)
            if (content[pointer] == "/" || content[pointer] == "*") {
                return false
            } else {
                return true
            }
        default: return true
        }
    }
}
