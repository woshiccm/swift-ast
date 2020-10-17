import Foundation

extension String {
  static func fromBuffer(_ textBuffer: UnsafeBufferPointer<UInt8>) -> String {
    return String(decoding: textBuffer, as: UTF8.self)
  }

  var isNativeUTF8: Bool {
    return utf8.withContiguousStorageIfAvailable { _ in 0 } != nil
  }

  mutating func makeNativeUTF8IfNeeded() {
    if !isNativeUTF8 {
      self += ""
    }
  }

  func utf8Slice(offset: Int, length: Int) -> Substring {
    if length == 0 {
      return Substring()
    }
    let utf8 = self.utf8
    let begin = utf8.index(utf8.startIndex, offsetBy: offset)
    let end = utf8.index(begin, offsetBy: length)
    return Substring(utf8[begin..<end])
  }
}
