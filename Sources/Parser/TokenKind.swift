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
  case integerLiteral
  case floatingLiteral
  case stringLiteral
  case unknown
  case identifier
  case unspacedBinaryOperator
  case spacedBinaryOperator
  case postfixOperator
  case prefixOperator
  case dollarIdentifier
  case contextualKeyword
  case rawStringDelimiter
  case stringSegment
  case stringInterpolationAnchor
  case yield
    
    init(text: String) {
        self = .unknown
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
  
}
