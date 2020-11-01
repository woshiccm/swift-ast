import Foundation
import Parser

func getInput(_ file: String) -> URL {
  var result = URL(fileURLWithPath: #file)
  result.deleteLastPathComponent()
  result.appendPathComponent("Inputs")
  result.appendPathComponent(file)
  return result
}

//let lexer = Lexer(url: getInput("lexer.swift"))

let lexer = Lexer(url: URL(fileURLWithPath: "/Users/roy/Desktop/lexer.swift"))


while true {
    let token = lexer.lexImpl()
    print(token.text)
    print(token.kind)
    print("----------")
    
    if token.kind == .eof {
        break
    }
    
}
