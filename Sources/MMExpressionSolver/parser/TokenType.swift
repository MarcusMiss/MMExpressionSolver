//
//  TokenType.swift
//  MMExpressionSolver
//

import Foundation

/// Enumeration of token-types.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public enum TokenType: String, CaseIterable, Sendable {
    case comma
    case variable
    case braceOpen
    case braceClose
    case literalString
    case literalNumber
    case operatorInfix
    case operatorPrefix
    case operatorPostfix
    case function
    case functionParamStart
    case arrayOpen
    case arrayClose
    case arrayIndex
    case separatorStructure
}
