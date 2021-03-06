import Foundation

struct UnicodeScalarInfo: OptionSet {
    let rawValue: Int
    
    static let none     = UnicodeScalarInfo([])
    
    static let horzWS   = UnicodeScalarInfo(rawValue: 0x0001)  // '\t', '\f', '\v'.  Note, no '\0'
    static let vertWS   = UnicodeScalarInfo(rawValue: 0x0002)  // '\r', '\n'
    static let space    = UnicodeScalarInfo(rawValue: 0x0004)  // ' '
    static let digit    = UnicodeScalarInfo(rawValue: 0x0008)  // 0-9
    static let xLetter  = UnicodeScalarInfo(rawValue: 0x0010)  // a-f,A-F
    static let upper    = UnicodeScalarInfo(rawValue: 0x0020)  // A-Z
    static let lower    = UnicodeScalarInfo(rawValue: 0x0040)  // a-z
    static let under    = UnicodeScalarInfo(rawValue: 0x0080)  // _
    static let period   = UnicodeScalarInfo(rawValue: 0x0100)  // .
    static let rawdel   = UnicodeScalarInfo(rawValue: 0x0200)  // {}[]#<>%:;?*+-/^&|~!=,"'
    static let punct    = UnicodeScalarInfo(rawValue: 0x0400)  // `$@()
    
    static let xUpper: UnicodeScalarInfo = [.xLetter, .upper]
    static let xLower: UnicodeScalarInfo = [.xLetter, .lower]
}

extension UnicodeScalar {
    var info: UnicodeScalarInfo {
        switch self.value {
        // 0 NUL, 1 SOH, 2 STX, 3 ETX, 4 EOT, 5 ENQ, 6 ACK, 7 BEL, 8 BS
        case 0...8: return .none
        // 9 HT
        case 9: return .horzWS
        // 10 NL
        case 10: return .vertWS
        // 11 VT, 12 NP
        case 11...12: return .horzWS
        // 13 CR
        case 13: return .vertWS
        // 14 SO, 15 SI, 16 DLE, 17 DC1, 18 DC2, 19 DC3, 20 DC4, 21 NAK, 22 SYN, 23 ETB, 24 CAN, 25 EM, 26 SUB, 27 ESC, 28 FS, 29 GS, 30 RS, 31 US
        case 14...31: return .none
        // 32 SP
        case 32: return .space
        // 33  !, 34  ", 35  #
        case 33...35: return .rawdel
        // 36  $
        case 36: return .punct
        // 37  %, 38  &, 39  '
        case 37...39: return .rawdel
        // 40  (, 41  )
        case 40...41: return .punct
        // 42  *, 43  +, 44   ,, 45  -
        case 42...45: return .rawdel
        // 46  .
        case 46: return .period
        // 47  /
        case 47: return .rawdel
        // 48  0, 49  1, 50  2, 51  3, 52  4, 53  5, 54  6, 55  7, 56  8, 57  9
        case 48...57: return .digit
        // 58  :, 59  ;, 60  <, 61  =, 62  >, 63  ?
        case 58...63: return .rawdel
        // 64  @
        case 64: return .punct
        // 65  A, 66  B, 67  C, 68  D, 69  E, 70  F
        case 65...70: return .xUpper
        // 71  G, 72  H, 73  I, 74  J, 75  K, 76  L, 77  M, 78  N, 79  O, 80  P, 81  Q, 82  R, 83  S, 84  T, 85  U, 86  V, 87  W, 88  X, 89  Y, 90  Z
        case 71...90: return .upper
        // 91  [
        case 91: return .rawdel
        // 92  \
        case 92: return .punct
        // 93  ]
        case 93: return .rawdel
        // 94  ^
        case 94: return .rawdel
        // 95  _
        case 95: return .under
        // 96  `
        case 96: return .punct
        // 97  a, 98  b, 99  c, 100  d, 101  e, 102  f
        case 97...102: return .xLower
        // 103  g, 104  h, 105  i, 106  j, 107  k, 108  l, 109  m, 110  n, 111  o, 112  p, 113  q, 114  r, 115  s, 116  t, 117  u, 118  v, 119  w, 120  x, 121  y, 122  z
        case 103...122: return .lower
        // 123  {, 124  |, 125  }, 126  ~
        case 123...126: return .rawdel
        // 127 DEL
        case 127: return .none
        default: return .none
        }
    }
    
    // CHAR_DIGIT|CHAR_UPPER|CHAR_LOWER
    var isAlphanumeric: Bool {
        return !self.info.isDisjoint(with: [.digit, .upper, .lower])
    }
    
    // CHAR_DIGIT
    var isDigit: Bool {
        return !self.info.isDisjoint(with: .digit)
    }
    
    // CHAR_DIGIT|CHAR_XLETTER
    var isHexDigit: Bool {
        return !self.info.isDisjoint(with: [.digit, .xLetter])
    }
    
    // CHAR_HORZ_WS|CHAR_SPACE
    var isHorizontalWhitespace: Bool {
        return !self.info.isDisjoint(with: [.horzWS, .space])
    }
    
    // CHAR_UPPER|CHAR_LOWER|CHAR_PERIOD|CHAR_PUNCT|
    // CHAR_DIGIT|CHAR_UNDER|CHAR_RAWDEL|CHAR_SPACE
    var isPrintable: Bool {
        return !self.info.isDisjoint(with: [.upper, .lower, .period, .punct, .digit, .under, .rawdel, .space])
    }
    
    // CHAR_HORZ_WS|CHAR_VERT_WS|CHAR_SPACE
    var isWhitespace: Bool {
        return !self.info.isDisjoint(with: [.horzWS, .vertWS, .space])
    }
    
    // CHAR_UPPER|CHAR_LOWER|CHAR_UNDER
    var isClangIdentifierHead: Bool {
        return !self.info.isDisjoint(with: [.upper, .lower, .under])
    }
    
    // CHAR_UPPER|CHAR_LOWER|CHAR_DIGIT|CHAR_UNDER
    var isClangIdentifierBody: Bool {
        return !self.info.isDisjoint(with: [.upper, .lower, .digit, .under])
    }
    
    var isIdentifierHead: Bool {
        if !isIdentifierBody { return false }
        if isASCII && (isDigit || self == "$") { return false }
        
        // N1518: Recommendations for extended identifier characters for C and C++
        // Proposed Annex X.2: Ranges of characters disallowed initially
        let c = value
        if ((c >= 0x0300 && c <= 0x036F) ||
            (c >= 0x1DC0 && c <= 0x1DFF) ||
            (c >= 0x20D0 && c <= 0x20FF) ||
            (c >= 0xFE20 && c <= 0xFE2F)) {
            return false
        }
        
        return true
    }
    
    var isIdentifierBody: Bool {
        if isASCII {
            return isClangIdentifierBody || self == "$"
        }
        
        // N1518: Recommendations for extended identifier characters for C and C++
        // Proposed Annex X.1: Ranges of characters allowed
        let c = value
        return c == 0x00A8 || c == 0x00AA || c == 0x00AD || c == 0x00AF
            || (c >= 0x00B2 && c <= 0x00B5) || (c >= 0x00B7 && c <= 0x00BA)
            || (c >= 0x00BC && c <= 0x00BE) || (c >= 0x00C0 && c <= 0x00D6)
            || (c >= 0x00D8 && c <= 0x00F6) || (c >= 0x00F8 && c <= 0x00FF)
            
            || (c >= 0x0100 && c <= 0x167F)
            || (c >= 0x1681 && c <= 0x180D)
            || (c >= 0x180F && c <= 0x1FFF)
            
            || (c >= 0x200B && c <= 0x200D)
            || (c >= 0x202A && c <= 0x202E)
            || (c >= 0x203F && c <= 0x2040)
            || c == 0x2054
            || (c >= 0x2060 && c <= 0x206F)
            
            || (c >= 0x2070 && c <= 0x218F)
            || (c >= 0x2460 && c <= 0x24FF)
            || (c >= 0x2776 && c <= 0x2793)
            || (c >= 0x2C00 && c <= 0x2DFF)
            || (c >= 0x2E80 && c <= 0x2FFF)
            
            || (c >= 0x3004 && c <= 0x3007)
            || (c >= 0x3021 && c <= 0x302F)
            || (c >= 0x3031 && c <= 0x303F)
            
            || (c >= 0x3040 && c <= 0xD7FF)
            
            || (c >= 0xF900 && c <= 0xFD3D)
            || (c >= 0xFD40 && c <= 0xFDCF)
            || (c >= 0xFDF0 && c <= 0xFE44)
            || (c >= 0xFE47 && c <= 0xFFF8)
            
            || (c >= 0x10000 && c <= 0x1FFFD)
            || (c >= 0x20000 && c <= 0x2FFFD)
            || (c >= 0x30000 && c <= 0x3FFFD)
            || (c >= 0x40000 && c <= 0x4FFFD)
            || (c >= 0x50000 && c <= 0x5FFFD)
            || (c >= 0x60000 && c <= 0x6FFFD)
            || (c >= 0x70000 && c <= 0x7FFFD)
            || (c >= 0x80000 && c <= 0x8FFFD)
            || (c >= 0x90000 && c <= 0x9FFFD)
            || (c >= 0xA0000 && c <= 0xAFFFD)
            || (c >= 0xB0000 && c <= 0xBFFFD)
            || (c >= 0xC0000 && c <= 0xCFFFD)
            || (c >= 0xD0000 && c <= 0xDFFFD)
            || (c >= 0xE0000 && c <= 0xEFFFD)
    }
    
    /// isOperatorStartCodePoint - Return true if the specified code point is a
    /// valid start of an operator.
    var isOperatorHead: Bool {
        // ASCII operator chars.
        if isASCII {
            let opCharts: Set<UnicodeScalar> = ["/", "=", "-", "+", "*", "%", "<", ">", "!", "&", "|", "^", "~", ".", "?"]
            return opCharts.contains(self)
        }
        
        // Unicode math, symbol, arrow, dingbat, and line/box drawing chars.
        let C = value
        return (C >= 0x00A1 && C <= 0x00A7)
            || C == 0x00A9 || C == 0x00AB || C == 0x00AC || C == 0x00AE
            || C == 0x00B0 || C == 0x00B1 || C == 0x00B6 || C == 0x00BB
            || C == 0x00BF || C == 0x00D7 || C == 0x00F7
            || C == 0x2016 || C == 0x2017 || (C >= 0x2020 && C <= 0x2027)
            || (C >= 0x2030 && C <= 0x203E) || (C >= 0x2041 && C <= 0x2053)
            || (C >= 0x2055 && C <= 0x205E) || (C >= 0x2190 && C <= 0x23FF)
            || (C >= 0x2500 && C <= 0x2775) || (C >= 0x2794 && C <= 0x2BFF)
            || (C >= 0x2E00 && C <= 0x2E7F) || (C >= 0x3001 && C <= 0x3003)
            || (C >= 0x3008 && C <= 0x3030)
    }
    
    /// isOperatorContinuationCodePoint - Return true if the specified code point
    /// is a valid operator code point.
    var isOperatorBody: Bool {
        if isOperatorHead { return true }
    
        // Unicode combining characters and variation selectors.
        let C = value
        return (C >= 0x0300 && C <= 0x036F)
            || (C >= 0x1DC0 && C <= 0x1DFF)
            || (C >= 0x20D0 && C <= 0x20FF)
            || (C >= 0xFE00 && C <= 0xFE0F)
            || (C >= 0xFE20 && C <= 0xFE2F)
            || (C >= 0xE0100 && C <= 0xE01EF)
    }
}
