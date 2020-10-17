import Foundation

/// Represent the user-facing part of SourceLocation that can be calculated
/// on demand.
struct ComputedLocation: Codable, CustomDebugStringConvertible {
  /// The line in the file where this location resides. 1-based.
  let line: Int

  /// The UTF-8 byte offset from the beginning of the line where this location
  /// resides. 1-based.
  let column: Int

  /// The file in which this location resides.
  let file: String

  var debugDescription: String {
    // Print file name?
    return "\(line):\(column)"
  }

  init(line: Int, column: Int, file: String) {
    self.line = line
    self.column = column
    self.file = file
  }
}

/// Represents a source location in a Swift file.
public struct SourceLocation: Codable, CustomDebugStringConvertible {

  /// Line and column that can be computed on demand.
  private var compLoc: ComputedLocation?

  /// The UTF-8 byte offset into the file where this location resides.
  public let offset: Int

  /// The line in the file where this location resides. 1-based.
  public var line: Int? {
    return compLoc?.line
  }

  /// The UTF-8 byte offset from the beginning of the line where this location
  /// resides. 1-based.
  public var column: Int? {
    return compLoc?.column
  }

  /// The file in which this location resides.
  public var file: String? {
    return compLoc?.file
  }

  public var debugDescription: String {
    guard let compLoc = compLoc else {
      return "\(offset)"
    }
    return compLoc.debugDescription
  }

  public init(line: Int, column: Int, offset: Int, file: String) {
    self.offset = offset
    self.compLoc = ComputedLocation(line: line, column: column, file: file)
  }
}

/// Represents a start and end location in a Swift file.
public struct SourceRange: Codable, CustomDebugStringConvertible {

  /// The beginning location in the source range.
  public let start: SourceLocation

  /// The beginning location in the source range.
  public let end: SourceLocation

  public var debugDescription: String {
    return "(\(start.debugDescription),\(end.debugDescription))"
  }

  public init(start: SourceLocation, end: SourceLocation) {
    self.start = start
    self.end = end
  }
}
