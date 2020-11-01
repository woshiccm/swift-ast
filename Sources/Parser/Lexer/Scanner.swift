import Foundation

struct Scanner {
    private let source: String
    private(set) var current: String.UnicodeScalarIndex
    let start: String.UnicodeScalarIndex
    let end: String.UnicodeScalarIndex
    let contentStart: String.UnicodeScalarIndex
    let characters: [UnicodeScalar]
    var curIndex: Int = 0
    
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
        let next = source.unicodeScalars.index(after: current)
        if next >= source.unicodeScalars.endIndex { return "\0" }
        return source.unicodeScalars[next]
    }
    
    var peekBack: UnicodeScalar {
        let back = source.unicodeScalars.index(before: current)
        if back >= source.unicodeScalars.endIndex { return "\0" }
        return source.unicodeScalars[back]
    }
    
    init(_ source: String) {
        self.source = source
        current = source.unicodeScalars.startIndex
        start = source.unicodeScalars.startIndex
        end = source.unicodeScalars.endIndex
        contentStart = source.unicodeScalars.startIndex
        
        characters = Array(source.unicodeScalars)
    }
    
    func starts(with possiblePrefix: String) -> Bool {
        return source.starts(with: possiblePrefix)
    }
        
    func peek(at index: String.UnicodeScalarIndex) -> UnicodeScalar {
        assert(index >= start && index <= end)
        return source.unicodeScalars[index]
    }
    
    func index(offsetBy distance: Int) -> String.UnicodeScalarIndex {
        return source.unicodeScalars.index(current, offsetBy: distance)
    }
    
    func distance(from start: String.Index, to end: String.Index) -> String.IndexDistance {
        return source.distance(from: start, to: end)
    }
    
    @discardableResult mutating func advance(by distance: Int = 1) -> UnicodeScalar {
        let result = peek
        current = index(offsetBy: distance)
        return result
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
