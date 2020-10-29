import Foundation

struct Scanner {
    private let source: String
    private(set) var current: String.UnicodeScalarIndex
    let start: String.UnicodeScalarIndex
    let end: String.UnicodeScalarIndex
    let contentStart: String.UnicodeScalarIndex
    
    func text(from start: String.UnicodeScalarIndex) -> String {
        return String(source.unicodeScalars[start..<current])
    }
    
    var isAtStart: Bool {
        return current == start
    }
    
    var isAtEnd: Bool {
        return current >= end
    }
    
    var peek: UnicodeScalar {
        if isAtEnd { return "\0" }
        return source.unicodeScalars[current]
    }
    
    var peekNext: UnicodeScalar {
        let back = source.unicodeScalars.index(before: current)
        if back <= source.unicodeScalars.startIndex { return "\0" }
        return source.unicodeScalars[back]
    }
    
    var peekBack: UnicodeScalar {
        let next = source.unicodeScalars.index(before: current)
        if next >= source.unicodeScalars.endIndex { return "\0" }
        return source.unicodeScalars[next]
    }
    
    init(_ source: String) {
        self.source = source
        current = source.unicodeScalars.startIndex
        start = source.unicodeScalars.startIndex
        end = source.unicodeScalars.endIndex
        contentStart = source.unicodeScalars.startIndex
    }
    
    @discardableResult mutating func advance() -> UnicodeScalar {
        let result = peek
        current = source.unicodeScalars.index(after: current)
        return result
    }
    
    mutating func putback() {
        current = source.unicodeScalars.index(before: current)
    }
    
    mutating func rewind(to newIdx: String.UnicodeScalarIndex) {
        current = newIdx
    }
    
    @discardableResult mutating func match(_ expected: UnicodeScalar) -> Bool {
        return match { $0 == expected }
    }
    
    @discardableResult mutating func match(_ filter: (UnicodeScalar) -> Bool) -> Bool {
        if isAtEnd { return false }
        if !filter(peek) { return false }
        
        advance()
        return true
    }
    
    mutating func skip(over skippable: Set<UnicodeScalar>) {
        while !isAtEnd && skippable.contains(peek) { advance() }
    }
    
    mutating func skip(while filter: (UnicodeScalar) -> Bool) {
        while !isAtEnd && filter(peek) { advance() }
    }
    
    mutating func skip(while filter: (UnicodeScalar, UnicodeScalar) -> Bool) {
        while !isAtEnd && filter(peek, peekNext) { advance() }
    }
}
