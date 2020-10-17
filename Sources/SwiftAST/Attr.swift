import Foundation

public struct Attr {
    enum Cursor: Int {
      case atSignToken
      case attributeName
      case leftParen
      case argument
      case rightParen
      case tokenList
    }
    
    public let attributeName: String
    public let argument: [String]?
}
