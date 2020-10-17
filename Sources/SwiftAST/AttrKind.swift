import Foundation

public enum AccessLevel: String {
    case `private`
    case `fileprivate`
    case `internal`
    case `public`
    case `open`
}

public enum InlineKind: String {
    case never
    case always
}
