//
//  ExpressionOperatorDefinition.swift
//  MMExpressionSolver
//

import Foundation

/// Type of operator.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public enum OperatorType: String, CaseIterable {
    /// Prefix-operator
    case prefix
    /// Infix-operator
    case infix
    /// Postfix-operator
    case postfix
}

/// Precedence of operator.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public enum OperatorPrecedence: Int, CaseIterable {
    case or = 2
    case and = 4
    case equality = 7
    case comparison = 10
    case additive = 20
    case multiplicative = 30
    case power = 40
    case unary = 60
    case powerHigher = 80
}

/// Definition of an expression-operator.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public struct ExpressionOperatorDefinition: CustomStringConvertible, CustomDebugStringConvertible {

    // MARK: - Properties

    /// type of operator
    public let type: OperatorType
    /// precedence of operator
    public let precedence: OperatorPrecedence

    /// indicator if left- or right associative
    public let isLeftAssociative: Bool
    /// indicator if evaluation is lazy
    public let isLazy: Bool

    /// indicator if operator is of type prefix (eg. _-VALUE_)
    public var isPrefix: Bool { get { self.type == .prefix } }
    /// indicator if operator is of type infix (eg. _VALUE-VALUE_)
    public var isInfix: Bool { get { self.type == .infix } }
    /// indicator if operator is of type postdix (eg. _VALUE!_
    public var isPostfix: Bool { get { self.type == .postfix } }

    // MARK: - Initialization

    /// Initialization of this object.
    /// - Parameters:
    ///   - type: operator type
    ///   - precedence: operator precedence
    ///   - isLeftAssociative: operator is left-associated
    ///   - isLazy: evaluation will be _lazy_
    public init(type: OperatorType,
         precedence: OperatorPrecedence,
         isLeftAssociative: Bool,
         isLazy: Bool) {
        self.type = type
        self.precedence = precedence
        self.isLeftAssociative = isLeftAssociative
        self.isLazy = isLazy
    }

    
    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return "type: \(self.type), precedence: \(self.precedence), isLeftAssociative: \(self.isLeftAssociative), , isLazy: \(self.isLazy)"
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "ExpressionOperatorDefinition(type: \(self.type), precedence: \(self.precedence), isLeftAssociative: \(self.isLeftAssociative), , isLazy: \(self.isLazy))"
    }

}
