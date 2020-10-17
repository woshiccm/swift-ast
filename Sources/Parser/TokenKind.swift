//// Automatically Generated From TokenKind.swift.gyb.
//// Do Not Edit Directly!
//===----------------- TokenKind.swift - Token Kind Enum ------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Base

/// Enumerates the kinds of tokens in the Swift language.
public enum TokenKind {
  case eof
  case associatedtypeKeyword
  case classKeyword
  case deinitKeyword
  case enumKeyword
  case extensionKeyword
  case funcKeyword
  case importKeyword
  case initKeyword
  case inoutKeyword
  case letKeyword
  case operatorKeyword
  case precedencegroupKeyword
  case protocolKeyword
  case structKeyword
  case subscriptKeyword
  case typealiasKeyword
  case varKeyword
  case fileprivateKeyword
  case internalKeyword
  case privateKeyword
  case publicKeyword
  case staticKeyword
  case deferKeyword
  case ifKeyword
  case guardKeyword
  case doKeyword
  case repeatKeyword
  case elseKeyword
  case forKeyword
  case inKeyword
  case whileKeyword
  case returnKeyword
  case breakKeyword
  case continueKeyword
  case fallthroughKeyword
  case switchKeyword
  case caseKeyword
  case defaultKeyword
  case whereKeyword
  case catchKeyword
  case throwKeyword
  case asKeyword
  case anyKeyword
  case falseKeyword
  case isKeyword
  case nilKeyword
  case rethrowsKeyword
  case superKeyword
  case selfKeyword
  case capitalSelfKeyword
  case trueKeyword
  case tryKeyword
  case throwsKeyword
  case __file__Keyword
  case __line__Keyword
  case __column__Keyword
  case __function__Keyword
  case __dso_handle__Keyword
  case wildcardKeyword
  case leftParen
  case rightParen
  case leftBrace
  case rightBrace
  case leftSquareBracket
  case rightSquareBracket
  case leftAngle
  case rightAngle
  case period
  case prefixPeriod
  case comma
  case ellipsis
  case colon
  case semicolon
  case equal
  case atSign
  case pound
  case prefixAmpersand
  case arrow
  case backtick
  case backslash
  case exclamationMark
  case postfixQuestionMark
  case infixQuestionMark
  case stringQuote
  case singleQuote
  case multilineStringQuote
  case poundKeyPathKeyword
  case poundLineKeyword
  case poundSelectorKeyword
  case poundFileKeyword
  case poundFilePathKeyword
  case poundColumnKeyword
  case poundFunctionKeyword
  case poundDsohandleKeyword
  case poundAssertKeyword
  case poundSourceLocationKeyword
  case poundWarningKeyword
  case poundErrorKeyword
  case poundIfKeyword
  case poundElseKeyword
  case poundElseifKeyword
  case poundEndifKeyword
  case poundAvailableKeyword
  case poundFileLiteralKeyword
  case poundImageLiteralKeyword
  case poundColorLiteralKeyword
  case integerLiteral(String)
  case floatingLiteral(String)
  case stringLiteral(String)
  case unknown(String)
  case identifier(String)
  case unspacedBinaryOperator(String)
  case spacedBinaryOperator(String)
  case postfixOperator(String)
  case prefixOperator(String)
  case dollarIdentifier(String)
  case contextualKeyword(String)
  case rawStringDelimiter(String)
  case stringSegment(String)
  case stringInterpolationAnchor
  case yield

  /// The textual representation of this token kind.
  public var text: String {
    switch self {
    case .eof: return ""
    case .associatedtypeKeyword: return "associatedtype"
    case .classKeyword: return "class"
    case .deinitKeyword: return "deinit"
    case .enumKeyword: return "enum"
    case .extensionKeyword: return "extension"
    case .funcKeyword: return "func"
    case .importKeyword: return "import"
    case .initKeyword: return "init"
    case .inoutKeyword: return "inout"
    case .letKeyword: return "let"
    case .operatorKeyword: return "operator"
    case .precedencegroupKeyword: return "precedencegroup"
    case .protocolKeyword: return "protocol"
    case .structKeyword: return "struct"
    case .subscriptKeyword: return "subscript"
    case .typealiasKeyword: return "typealias"
    case .varKeyword: return "var"
    case .fileprivateKeyword: return "fileprivate"
    case .internalKeyword: return "internal"
    case .privateKeyword: return "private"
    case .publicKeyword: return "public"
    case .staticKeyword: return "static"
    case .deferKeyword: return "defer"
    case .ifKeyword: return "if"
    case .guardKeyword: return "guard"
    case .doKeyword: return "do"
    case .repeatKeyword: return "repeat"
    case .elseKeyword: return "else"
    case .forKeyword: return "for"
    case .inKeyword: return "in"
    case .whileKeyword: return "while"
    case .returnKeyword: return "return"
    case .breakKeyword: return "break"
    case .continueKeyword: return "continue"
    case .fallthroughKeyword: return "fallthrough"
    case .switchKeyword: return "switch"
    case .caseKeyword: return "case"
    case .defaultKeyword: return "default"
    case .whereKeyword: return "where"
    case .catchKeyword: return "catch"
    case .throwKeyword: return "throw"
    case .asKeyword: return "as"
    case .anyKeyword: return "Any"
    case .falseKeyword: return "false"
    case .isKeyword: return "is"
    case .nilKeyword: return "nil"
    case .rethrowsKeyword: return "rethrows"
    case .superKeyword: return "super"
    case .selfKeyword: return "self"
    case .capitalSelfKeyword: return "Self"
    case .trueKeyword: return "true"
    case .tryKeyword: return "try"
    case .throwsKeyword: return "throws"
    case .__file__Keyword: return "__FILE__"
    case .__line__Keyword: return "__LINE__"
    case .__column__Keyword: return "__COLUMN__"
    case .__function__Keyword: return "__FUNCTION__"
    case .__dso_handle__Keyword: return "__DSO_HANDLE__"
    case .wildcardKeyword: return "_"
    case .leftParen: return "("
    case .rightParen: return ")"
    case .leftBrace: return "{"
    case .rightBrace: return "}"
    case .leftSquareBracket: return "["
    case .rightSquareBracket: return "]"
    case .leftAngle: return "<"
    case .rightAngle: return ">"
    case .period: return "."
    case .prefixPeriod: return "."
    case .comma: return ","
    case .ellipsis: return "..."
    case .colon: return ":"
    case .semicolon: return ";"
    case .equal: return "="
    case .atSign: return "@"
    case .pound: return "#"
    case .prefixAmpersand: return "&"
    case .arrow: return "->"
    case .backtick: return "`"
    case .backslash: return "\\"
    case .exclamationMark: return "!"
    case .postfixQuestionMark: return "?"
    case .infixQuestionMark: return "?"
    case .stringQuote: return "\""
    case .singleQuote: return "\'"
    case .multilineStringQuote: return "\"\"\""
    case .poundKeyPathKeyword: return "#keyPath"
    case .poundLineKeyword: return "#line"
    case .poundSelectorKeyword: return "#selector"
    case .poundFileKeyword: return "#file"
    case .poundFilePathKeyword: return "#filePath"
    case .poundColumnKeyword: return "#column"
    case .poundFunctionKeyword: return "#function"
    case .poundDsohandleKeyword: return "#dsohandle"
    case .poundAssertKeyword: return "#assert"
    case .poundSourceLocationKeyword: return "#sourceLocation"
    case .poundWarningKeyword: return "#warning"
    case .poundErrorKeyword: return "#error"
    case .poundIfKeyword: return "#if"
    case .poundElseKeyword: return "#else"
    case .poundElseifKeyword: return "#elseif"
    case .poundEndifKeyword: return "#endif"
    case .poundAvailableKeyword: return "#available"
    case .poundFileLiteralKeyword: return "#fileLiteral"
    case .poundImageLiteralKeyword: return "#imageLiteral"
    case .poundColorLiteralKeyword: return "#colorLiteral"
    case .integerLiteral(let text): return text
    case .floatingLiteral(let text): return text
    case .stringLiteral(let text): return text
    case .unknown(let text): return text
    case .identifier(let text): return text
    case .unspacedBinaryOperator(let text): return text
    case .spacedBinaryOperator(let text): return text
    case .postfixOperator(let text): return text
    case .prefixOperator(let text): return text
    case .dollarIdentifier(let text): return text
    case .contextualKeyword(let text): return text
    case .rawStringDelimiter(let text): return text
    case .stringSegment(let text): return text
    case .stringInterpolationAnchor: return ")"
    case .yield: return "yield"
    }
  }

  public var isKeyword: Bool {
    switch self {
    case .eof: return false
    case .associatedtypeKeyword: return true
    case .classKeyword: return true
    case .deinitKeyword: return true
    case .enumKeyword: return true
    case .extensionKeyword: return true
    case .funcKeyword: return true
    case .importKeyword: return true
    case .initKeyword: return true
    case .inoutKeyword: return true
    case .letKeyword: return true
    case .operatorKeyword: return true
    case .precedencegroupKeyword: return true
    case .protocolKeyword: return true
    case .structKeyword: return true
    case .subscriptKeyword: return true
    case .typealiasKeyword: return true
    case .varKeyword: return true
    case .fileprivateKeyword: return true
    case .internalKeyword: return true
    case .privateKeyword: return true
    case .publicKeyword: return true
    case .staticKeyword: return true
    case .deferKeyword: return true
    case .ifKeyword: return true
    case .guardKeyword: return true
    case .doKeyword: return true
    case .repeatKeyword: return true
    case .elseKeyword: return true
    case .forKeyword: return true
    case .inKeyword: return true
    case .whileKeyword: return true
    case .returnKeyword: return true
    case .breakKeyword: return true
    case .continueKeyword: return true
    case .fallthroughKeyword: return true
    case .switchKeyword: return true
    case .caseKeyword: return true
    case .defaultKeyword: return true
    case .whereKeyword: return true
    case .catchKeyword: return true
    case .throwKeyword: return true
    case .asKeyword: return true
    case .anyKeyword: return true
    case .falseKeyword: return true
    case .isKeyword: return true
    case .nilKeyword: return true
    case .rethrowsKeyword: return true
    case .superKeyword: return true
    case .selfKeyword: return true
    case .capitalSelfKeyword: return true
    case .trueKeyword: return true
    case .tryKeyword: return true
    case .throwsKeyword: return true
    case .__file__Keyword: return true
    case .__line__Keyword: return true
    case .__column__Keyword: return true
    case .__function__Keyword: return true
    case .__dso_handle__Keyword: return true
    case .wildcardKeyword: return true
    case .leftParen: return false
    case .rightParen: return false
    case .leftBrace: return false
    case .rightBrace: return false
    case .leftSquareBracket: return false
    case .rightSquareBracket: return false
    case .leftAngle: return false
    case .rightAngle: return false
    case .period: return false
    case .prefixPeriod: return false
    case .comma: return false
    case .ellipsis: return false
    case .colon: return false
    case .semicolon: return false
    case .equal: return false
    case .atSign: return false
    case .pound: return false
    case .prefixAmpersand: return false
    case .arrow: return false
    case .backtick: return false
    case .backslash: return false
    case .exclamationMark: return false
    case .postfixQuestionMark: return false
    case .infixQuestionMark: return false
    case .stringQuote: return false
    case .singleQuote: return false
    case .multilineStringQuote: return false
    case .poundKeyPathKeyword: return true
    case .poundLineKeyword: return true
    case .poundSelectorKeyword: return true
    case .poundFileKeyword: return true
    case .poundFilePathKeyword: return true
    case .poundColumnKeyword: return true
    case .poundFunctionKeyword: return true
    case .poundDsohandleKeyword: return true
    case .poundAssertKeyword: return true
    case .poundSourceLocationKeyword: return true
    case .poundWarningKeyword: return true
    case .poundErrorKeyword: return true
    case .poundIfKeyword: return true
    case .poundElseKeyword: return true
    case .poundElseifKeyword: return true
    case .poundEndifKeyword: return true
    case .poundAvailableKeyword: return true
    case .poundFileLiteralKeyword: return true
    case .poundImageLiteralKeyword: return true
    case .poundColorLiteralKeyword: return true
    case .integerLiteral: return false
    case .floatingLiteral: return false
    case .stringLiteral: return false
    case .unknown: return false
    case .identifier: return false
    case .unspacedBinaryOperator: return false
    case .spacedBinaryOperator: return false
    case .postfixOperator: return false
    case .prefixOperator: return false
    case .dollarIdentifier: return false
    case .contextualKeyword: return false
    case .rawStringDelimiter: return false
    case .stringSegment: return false
    case .stringInterpolationAnchor: return false
    case .yield: return false
    }
  }
  
  var kind: String {
    switch self {
    case .eof: return "eof"
    case .associatedtypeKeyword: return "kw_associatedtype"
    case .classKeyword: return "kw_class"
    case .deinitKeyword: return "kw_deinit"
    case .enumKeyword: return "kw_enum"
    case .extensionKeyword: return "kw_extension"
    case .funcKeyword: return "kw_func"
    case .importKeyword: return "kw_import"
    case .initKeyword: return "kw_init"
    case .inoutKeyword: return "kw_inout"
    case .letKeyword: return "kw_let"
    case .operatorKeyword: return "kw_operator"
    case .precedencegroupKeyword: return "kw_precedencegroup"
    case .protocolKeyword: return "kw_protocol"
    case .structKeyword: return "kw_struct"
    case .subscriptKeyword: return "kw_subscript"
    case .typealiasKeyword: return "kw_typealias"
    case .varKeyword: return "kw_var"
    case .fileprivateKeyword: return "kw_fileprivate"
    case .internalKeyword: return "kw_internal"
    case .privateKeyword: return "kw_private"
    case .publicKeyword: return "kw_public"
    case .staticKeyword: return "kw_static"
    case .deferKeyword: return "kw_defer"
    case .ifKeyword: return "kw_if"
    case .guardKeyword: return "kw_guard"
    case .doKeyword: return "kw_do"
    case .repeatKeyword: return "kw_repeat"
    case .elseKeyword: return "kw_else"
    case .forKeyword: return "kw_for"
    case .inKeyword: return "kw_in"
    case .whileKeyword: return "kw_while"
    case .returnKeyword: return "kw_return"
    case .breakKeyword: return "kw_break"
    case .continueKeyword: return "kw_continue"
    case .fallthroughKeyword: return "kw_fallthrough"
    case .switchKeyword: return "kw_switch"
    case .caseKeyword: return "kw_case"
    case .defaultKeyword: return "kw_default"
    case .whereKeyword: return "kw_where"
    case .catchKeyword: return "kw_catch"
    case .throwKeyword: return "kw_throw"
    case .asKeyword: return "kw_as"
    case .anyKeyword: return "kw_Any"
    case .falseKeyword: return "kw_false"
    case .isKeyword: return "kw_is"
    case .nilKeyword: return "kw_nil"
    case .rethrowsKeyword: return "kw_rethrows"
    case .superKeyword: return "kw_super"
    case .selfKeyword: return "kw_self"
    case .capitalSelfKeyword: return "kw_Self"
    case .trueKeyword: return "kw_true"
    case .tryKeyword: return "kw_try"
    case .throwsKeyword: return "kw_throws"
    case .__file__Keyword: return "kw___FILE__"
    case .__line__Keyword: return "kw___LINE__"
    case .__column__Keyword: return "kw___COLUMN__"
    case .__function__Keyword: return "kw___FUNCTION__"
    case .__dso_handle__Keyword: return "kw___DSO_HANDLE__"
    case .wildcardKeyword: return "kw__"
    case .leftParen: return "l_paren"
    case .rightParen: return "r_paren"
    case .leftBrace: return "l_brace"
    case .rightBrace: return "r_brace"
    case .leftSquareBracket: return "l_square"
    case .rightSquareBracket: return "r_square"
    case .leftAngle: return "l_angle"
    case .rightAngle: return "r_angle"
    case .period: return "period"
    case .prefixPeriod: return "period_prefix"
    case .comma: return "comma"
    case .ellipsis: return "ellipsis"
    case .colon: return "colon"
    case .semicolon: return "semi"
    case .equal: return "equal"
    case .atSign: return "at_sign"
    case .pound: return "pound"
    case .prefixAmpersand: return "amp_prefix"
    case .arrow: return "arrow"
    case .backtick: return "backtick"
    case .backslash: return "backslash"
    case .exclamationMark: return "exclaim_postfix"
    case .postfixQuestionMark: return "question_postfix"
    case .infixQuestionMark: return "question_infix"
    case .stringQuote: return "string_quote"
    case .singleQuote: return "single_quote"
    case .multilineStringQuote: return "multiline_string_quote"
    case .poundKeyPathKeyword: return "pound_keyPath"
    case .poundLineKeyword: return "pound_line"
    case .poundSelectorKeyword: return "pound_selector"
    case .poundFileKeyword: return "pound_file"
    case .poundFilePathKeyword: return "pound_filePath"
    case .poundColumnKeyword: return "pound_column"
    case .poundFunctionKeyword: return "pound_function"
    case .poundDsohandleKeyword: return "pound_dsohandle"
    case .poundAssertKeyword: return "pound_assert"
    case .poundSourceLocationKeyword: return "pound_sourceLocation"
    case .poundWarningKeyword: return "pound_warning"
    case .poundErrorKeyword: return "pound_error"
    case .poundIfKeyword: return "pound_if"
    case .poundElseKeyword: return "pound_else"
    case .poundElseifKeyword: return "pound_elseif"
    case .poundEndifKeyword: return "pound_endif"
    case .poundAvailableKeyword: return "pound_available"
    case .poundFileLiteralKeyword: return "pound_fileLiteral"
    case .poundImageLiteralKeyword: return "pound_imageLiteral"
    case .poundColorLiteralKeyword: return "pound_colorLiteral"
    case .integerLiteral(_): return "integer_literal"
    case .floatingLiteral(_): return "floating_literal"
    case .stringLiteral(_): return "string_literal"
    case .unknown(_): return "unknown"
    case .identifier(_): return "identifier"
    case .unspacedBinaryOperator(_): return "oper_binary_unspaced"
    case .spacedBinaryOperator(_): return "oper_binary_spaced"
    case .postfixOperator(_): return "oper_postfix"
    case .prefixOperator(_): return "oper_prefix"
    case .dollarIdentifier(_): return "dollarident"
    case .contextualKeyword(_): return "contextual_keyword"
    case .rawStringDelimiter(_): return "raw_string_delimiter"
    case .stringSegment(_): return "string_segment"
    case .stringInterpolationAnchor: return "string_interpolation_anchor"
    case .yield: return "kw_yield"
    }
  }

  var sourceLength: SourceLength {
    switch self {
    case .eof: return .zero
    case .associatedtypeKeyword: return SourceLength(utf8Length: 14)
    case .classKeyword: return SourceLength(utf8Length: 5)
    case .deinitKeyword: return SourceLength(utf8Length: 6)
    case .enumKeyword: return SourceLength(utf8Length: 4)
    case .extensionKeyword: return SourceLength(utf8Length: 9)
    case .funcKeyword: return SourceLength(utf8Length: 4)
    case .importKeyword: return SourceLength(utf8Length: 6)
    case .initKeyword: return SourceLength(utf8Length: 4)
    case .inoutKeyword: return SourceLength(utf8Length: 5)
    case .letKeyword: return SourceLength(utf8Length: 3)
    case .operatorKeyword: return SourceLength(utf8Length: 8)
    case .precedencegroupKeyword: return SourceLength(utf8Length: 15)
    case .protocolKeyword: return SourceLength(utf8Length: 8)
    case .structKeyword: return SourceLength(utf8Length: 6)
    case .subscriptKeyword: return SourceLength(utf8Length: 9)
    case .typealiasKeyword: return SourceLength(utf8Length: 9)
    case .varKeyword: return SourceLength(utf8Length: 3)
    case .fileprivateKeyword: return SourceLength(utf8Length: 11)
    case .internalKeyword: return SourceLength(utf8Length: 8)
    case .privateKeyword: return SourceLength(utf8Length: 7)
    case .publicKeyword: return SourceLength(utf8Length: 6)
    case .staticKeyword: return SourceLength(utf8Length: 6)
    case .deferKeyword: return SourceLength(utf8Length: 5)
    case .ifKeyword: return SourceLength(utf8Length: 2)
    case .guardKeyword: return SourceLength(utf8Length: 5)
    case .doKeyword: return SourceLength(utf8Length: 2)
    case .repeatKeyword: return SourceLength(utf8Length: 6)
    case .elseKeyword: return SourceLength(utf8Length: 4)
    case .forKeyword: return SourceLength(utf8Length: 3)
    case .inKeyword: return SourceLength(utf8Length: 2)
    case .whileKeyword: return SourceLength(utf8Length: 5)
    case .returnKeyword: return SourceLength(utf8Length: 6)
    case .breakKeyword: return SourceLength(utf8Length: 5)
    case .continueKeyword: return SourceLength(utf8Length: 8)
    case .fallthroughKeyword: return SourceLength(utf8Length: 11)
    case .switchKeyword: return SourceLength(utf8Length: 6)
    case .caseKeyword: return SourceLength(utf8Length: 4)
    case .defaultKeyword: return SourceLength(utf8Length: 7)
    case .whereKeyword: return SourceLength(utf8Length: 5)
    case .catchKeyword: return SourceLength(utf8Length: 5)
    case .throwKeyword: return SourceLength(utf8Length: 5)
    case .asKeyword: return SourceLength(utf8Length: 2)
    case .anyKeyword: return SourceLength(utf8Length: 3)
    case .falseKeyword: return SourceLength(utf8Length: 5)
    case .isKeyword: return SourceLength(utf8Length: 2)
    case .nilKeyword: return SourceLength(utf8Length: 3)
    case .rethrowsKeyword: return SourceLength(utf8Length: 8)
    case .superKeyword: return SourceLength(utf8Length: 5)
    case .selfKeyword: return SourceLength(utf8Length: 4)
    case .capitalSelfKeyword: return SourceLength(utf8Length: 4)
    case .trueKeyword: return SourceLength(utf8Length: 4)
    case .tryKeyword: return SourceLength(utf8Length: 3)
    case .throwsKeyword: return SourceLength(utf8Length: 6)
    case .__file__Keyword: return SourceLength(utf8Length: 8)
    case .__line__Keyword: return SourceLength(utf8Length: 8)
    case .__column__Keyword: return SourceLength(utf8Length: 10)
    case .__function__Keyword: return SourceLength(utf8Length: 12)
    case .__dso_handle__Keyword: return SourceLength(utf8Length: 14)
    case .wildcardKeyword: return SourceLength(utf8Length: 1)
    case .leftParen: return SourceLength(utf8Length: 1)
    case .rightParen: return SourceLength(utf8Length: 1)
    case .leftBrace: return SourceLength(utf8Length: 1)
    case .rightBrace: return SourceLength(utf8Length: 1)
    case .leftSquareBracket: return SourceLength(utf8Length: 1)
    case .rightSquareBracket: return SourceLength(utf8Length: 1)
    case .leftAngle: return SourceLength(utf8Length: 1)
    case .rightAngle: return SourceLength(utf8Length: 1)
    case .period: return SourceLength(utf8Length: 1)
    case .prefixPeriod: return SourceLength(utf8Length: 1)
    case .comma: return SourceLength(utf8Length: 1)
    case .ellipsis: return SourceLength(utf8Length: 3)
    case .colon: return SourceLength(utf8Length: 1)
    case .semicolon: return SourceLength(utf8Length: 1)
    case .equal: return SourceLength(utf8Length: 1)
    case .atSign: return SourceLength(utf8Length: 1)
    case .pound: return SourceLength(utf8Length: 1)
    case .prefixAmpersand: return SourceLength(utf8Length: 1)
    case .arrow: return SourceLength(utf8Length: 2)
    case .backtick: return SourceLength(utf8Length: 1)
    case .backslash: return SourceLength(utf8Length: 1)
    case .exclamationMark: return SourceLength(utf8Length: 1)
    case .postfixQuestionMark: return SourceLength(utf8Length: 1)
    case .infixQuestionMark: return SourceLength(utf8Length: 1)
    case .stringQuote: return SourceLength(utf8Length: 1)
    case .singleQuote: return SourceLength(utf8Length: 1)
    case .multilineStringQuote: return SourceLength(utf8Length: 3)
    case .poundKeyPathKeyword: return SourceLength(utf8Length: 8)
    case .poundLineKeyword: return SourceLength(utf8Length: 5)
    case .poundSelectorKeyword: return SourceLength(utf8Length: 9)
    case .poundFileKeyword: return SourceLength(utf8Length: 5)
    case .poundFilePathKeyword: return SourceLength(utf8Length: 9)
    case .poundColumnKeyword: return SourceLength(utf8Length: 7)
    case .poundFunctionKeyword: return SourceLength(utf8Length: 9)
    case .poundDsohandleKeyword: return SourceLength(utf8Length: 10)
    case .poundAssertKeyword: return SourceLength(utf8Length: 7)
    case .poundSourceLocationKeyword: return SourceLength(utf8Length: 15)
    case .poundWarningKeyword: return SourceLength(utf8Length: 8)
    case .poundErrorKeyword: return SourceLength(utf8Length: 6)
    case .poundIfKeyword: return SourceLength(utf8Length: 3)
    case .poundElseKeyword: return SourceLength(utf8Length: 5)
    case .poundElseifKeyword: return SourceLength(utf8Length: 7)
    case .poundEndifKeyword: return SourceLength(utf8Length: 6)
    case .poundAvailableKeyword: return SourceLength(utf8Length: 10)
    case .poundFileLiteralKeyword: return SourceLength(utf8Length: 12)
    case .poundImageLiteralKeyword: return SourceLength(utf8Length: 13)
    case .poundColorLiteralKeyword: return SourceLength(utf8Length: 13)
    case .integerLiteral(let text): return SourceLength(of: text)
    case .floatingLiteral(let text): return SourceLength(of: text)
    case .stringLiteral(let text): return SourceLength(of: text)
    case .unknown(let text): return SourceLength(of: text)
    case .identifier(let text): return SourceLength(of: text)
    case .unspacedBinaryOperator(let text): return SourceLength(of: text)
    case .spacedBinaryOperator(let text): return SourceLength(of: text)
    case .postfixOperator(let text): return SourceLength(of: text)
    case .prefixOperator(let text): return SourceLength(of: text)
    case .dollarIdentifier(let text): return SourceLength(of: text)
    case .contextualKeyword(let text): return SourceLength(of: text)
    case .rawStringDelimiter(let text): return SourceLength(of: text)
    case .stringSegment(let text): return SourceLength(of: text)
    case .stringInterpolationAnchor: return SourceLength(utf8Length: 1)
    case .yield: return SourceLength(utf8Length: 5)
    }
  }
}

extension TokenKind: Equatable {
  public static func ==(lhs: TokenKind, rhs: TokenKind) -> Bool {
    switch (lhs, rhs) {
    case (.eof, .eof): return true
    case (.associatedtypeKeyword, .associatedtypeKeyword): return true
    case (.classKeyword, .classKeyword): return true
    case (.deinitKeyword, .deinitKeyword): return true
    case (.enumKeyword, .enumKeyword): return true
    case (.extensionKeyword, .extensionKeyword): return true
    case (.funcKeyword, .funcKeyword): return true
    case (.importKeyword, .importKeyword): return true
    case (.initKeyword, .initKeyword): return true
    case (.inoutKeyword, .inoutKeyword): return true
    case (.letKeyword, .letKeyword): return true
    case (.operatorKeyword, .operatorKeyword): return true
    case (.precedencegroupKeyword, .precedencegroupKeyword): return true
    case (.protocolKeyword, .protocolKeyword): return true
    case (.structKeyword, .structKeyword): return true
    case (.subscriptKeyword, .subscriptKeyword): return true
    case (.typealiasKeyword, .typealiasKeyword): return true
    case (.varKeyword, .varKeyword): return true
    case (.fileprivateKeyword, .fileprivateKeyword): return true
    case (.internalKeyword, .internalKeyword): return true
    case (.privateKeyword, .privateKeyword): return true
    case (.publicKeyword, .publicKeyword): return true
    case (.staticKeyword, .staticKeyword): return true
    case (.deferKeyword, .deferKeyword): return true
    case (.ifKeyword, .ifKeyword): return true
    case (.guardKeyword, .guardKeyword): return true
    case (.doKeyword, .doKeyword): return true
    case (.repeatKeyword, .repeatKeyword): return true
    case (.elseKeyword, .elseKeyword): return true
    case (.forKeyword, .forKeyword): return true
    case (.inKeyword, .inKeyword): return true
    case (.whileKeyword, .whileKeyword): return true
    case (.returnKeyword, .returnKeyword): return true
    case (.breakKeyword, .breakKeyword): return true
    case (.continueKeyword, .continueKeyword): return true
    case (.fallthroughKeyword, .fallthroughKeyword): return true
    case (.switchKeyword, .switchKeyword): return true
    case (.caseKeyword, .caseKeyword): return true
    case (.defaultKeyword, .defaultKeyword): return true
    case (.whereKeyword, .whereKeyword): return true
    case (.catchKeyword, .catchKeyword): return true
    case (.throwKeyword, .throwKeyword): return true
    case (.asKeyword, .asKeyword): return true
    case (.anyKeyword, .anyKeyword): return true
    case (.falseKeyword, .falseKeyword): return true
    case (.isKeyword, .isKeyword): return true
    case (.nilKeyword, .nilKeyword): return true
    case (.rethrowsKeyword, .rethrowsKeyword): return true
    case (.superKeyword, .superKeyword): return true
    case (.selfKeyword, .selfKeyword): return true
    case (.capitalSelfKeyword, .capitalSelfKeyword): return true
    case (.trueKeyword, .trueKeyword): return true
    case (.tryKeyword, .tryKeyword): return true
    case (.throwsKeyword, .throwsKeyword): return true
    case (.__file__Keyword, .__file__Keyword): return true
    case (.__line__Keyword, .__line__Keyword): return true
    case (.__column__Keyword, .__column__Keyword): return true
    case (.__function__Keyword, .__function__Keyword): return true
    case (.__dso_handle__Keyword, .__dso_handle__Keyword): return true
    case (.wildcardKeyword, .wildcardKeyword): return true
    case (.leftParen, .leftParen): return true
    case (.rightParen, .rightParen): return true
    case (.leftBrace, .leftBrace): return true
    case (.rightBrace, .rightBrace): return true
    case (.leftSquareBracket, .leftSquareBracket): return true
    case (.rightSquareBracket, .rightSquareBracket): return true
    case (.leftAngle, .leftAngle): return true
    case (.rightAngle, .rightAngle): return true
    case (.period, .period): return true
    case (.prefixPeriod, .prefixPeriod): return true
    case (.comma, .comma): return true
    case (.ellipsis, .ellipsis): return true
    case (.colon, .colon): return true
    case (.semicolon, .semicolon): return true
    case (.equal, .equal): return true
    case (.atSign, .atSign): return true
    case (.pound, .pound): return true
    case (.prefixAmpersand, .prefixAmpersand): return true
    case (.arrow, .arrow): return true
    case (.backtick, .backtick): return true
    case (.backslash, .backslash): return true
    case (.exclamationMark, .exclamationMark): return true
    case (.postfixQuestionMark, .postfixQuestionMark): return true
    case (.infixQuestionMark, .infixQuestionMark): return true
    case (.stringQuote, .stringQuote): return true
    case (.singleQuote, .singleQuote): return true
    case (.multilineStringQuote, .multilineStringQuote): return true
    case (.poundKeyPathKeyword, .poundKeyPathKeyword): return true
    case (.poundLineKeyword, .poundLineKeyword): return true
    case (.poundSelectorKeyword, .poundSelectorKeyword): return true
    case (.poundFileKeyword, .poundFileKeyword): return true
    case (.poundFilePathKeyword, .poundFilePathKeyword): return true
    case (.poundColumnKeyword, .poundColumnKeyword): return true
    case (.poundFunctionKeyword, .poundFunctionKeyword): return true
    case (.poundDsohandleKeyword, .poundDsohandleKeyword): return true
    case (.poundAssertKeyword, .poundAssertKeyword): return true
    case (.poundSourceLocationKeyword, .poundSourceLocationKeyword): return true
    case (.poundWarningKeyword, .poundWarningKeyword): return true
    case (.poundErrorKeyword, .poundErrorKeyword): return true
    case (.poundIfKeyword, .poundIfKeyword): return true
    case (.poundElseKeyword, .poundElseKeyword): return true
    case (.poundElseifKeyword, .poundElseifKeyword): return true
    case (.poundEndifKeyword, .poundEndifKeyword): return true
    case (.poundAvailableKeyword, .poundAvailableKeyword): return true
    case (.poundFileLiteralKeyword, .poundFileLiteralKeyword): return true
    case (.poundImageLiteralKeyword, .poundImageLiteralKeyword): return true
    case (.poundColorLiteralKeyword, .poundColorLiteralKeyword): return true
    case (.integerLiteral(let lhsText), .integerLiteral(let rhsText)):
      return lhsText == rhsText
    case (.floatingLiteral(let lhsText), .floatingLiteral(let rhsText)):
      return lhsText == rhsText
    case (.stringLiteral(let lhsText), .stringLiteral(let rhsText)):
      return lhsText == rhsText
    case (.unknown(let lhsText), .unknown(let rhsText)):
      return lhsText == rhsText
    case (.identifier(let lhsText), .identifier(let rhsText)):
      return lhsText == rhsText
    case (.unspacedBinaryOperator(let lhsText), .unspacedBinaryOperator(let rhsText)):
      return lhsText == rhsText
    case (.spacedBinaryOperator(let lhsText), .spacedBinaryOperator(let rhsText)):
      return lhsText == rhsText
    case (.postfixOperator(let lhsText), .postfixOperator(let rhsText)):
      return lhsText == rhsText
    case (.prefixOperator(let lhsText), .prefixOperator(let rhsText)):
      return lhsText == rhsText
    case (.dollarIdentifier(let lhsText), .dollarIdentifier(let rhsText)):
      return lhsText == rhsText
    case (.contextualKeyword(let lhsText), .contextualKeyword(let rhsText)):
      return lhsText == rhsText
    case (.rawStringDelimiter(let lhsText), .rawStringDelimiter(let rhsText)):
      return lhsText == rhsText
    case (.stringSegment(let lhsText), .stringSegment(let rhsText)):
      return lhsText == rhsText
    case (.stringInterpolationAnchor, .stringInterpolationAnchor): return true
    case (.yield, .yield): return true
    default: return false
    }
  }
}

