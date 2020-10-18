import Foundation

fileprivate extension UnicodeScalar {
//    var isWhitespace: Bool {
//        return self == " " || self == "\t" || self == "\n" || self == "\r"
//    }

    var isAlpha: Bool {
        let alphaChars = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".unicodeScalars)
        return alphaChars.contains(self)
    }

    var isNumeric: Bool {
        let numChars = Set("0123456789".unicodeScalars)
        return numChars.contains(self)
    }

    var isAlnum: Bool {
        return isAlpha || isNumeric
    }

    /// Valid identifier characters are alphanumeric or '_'
    var isIdentifier: Bool {
        return isAlnum || self == "_"
    }

    /// If the character represents a character that can occur in operators
    /// Currently includes '+', '-', '*', '/', '='
    var isOperator: Bool {
        let operatorChars = Set("+-*/=<>".unicodeScalars)
        return operatorChars.contains(self)
    }
}

fileprivate extension UnicodeScalar {
    
    var valuee: Int32 {
        let s = String(self).unicodeScalars
        return Int32(s[s.startIndex].value)
    }
    
    var isDig: Bool {
        return CharacterSet.decimalDigits.contains(self)
    }
    
    func isNumOr_() -> Bool {
        return isdigit(valuee) != 0 || self == "_" || self == "."
    }
    func isHexNumOr_() -> Bool {
        return ishexnumber(valuee) != 0 || self == "_"
    }
    
    func isAlphaOr_() -> Bool {
        return isalpha(valuee) != 0 || self == "_"
    }
    
    func isWhiteSpace() -> Bool {
        return isspace(valuee) != 0
    }
}

