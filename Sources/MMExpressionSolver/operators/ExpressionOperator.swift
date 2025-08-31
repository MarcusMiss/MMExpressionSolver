//
//  ExpressionOperator.swift
//  MMExpressionSolver
//

import Foundation

/// Expression-operator to calculate values.
///
/// Protocol describing abilities of an expression-operator.
/// An expression-operator is used calculate values:
/// - as a _prefix_-or _postfix_-operator with one operand
/// - as _infix_-operator with to operands
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public protocol ExpressionOperator: Identifiable<OperatorIdentifier>, CustomStringConvertible, CustomDebugStringConvertible {
    
    /// Definition of operator
    var definition: ExpressionOperatorDefinition { get }
    /// Symbols representing operator. Minimum one.
    var symbols: [String] { get }
    
    /// Evaluation of operator.
    /// - Parameters:
    ///   - context: execution context
    ///   - operatorToken: representd by token
    ///   - arguments: operator arguments
    func evaluateOperator(context: any ExpressionEvaluationContext,
                          operatorToken: Token,
                          arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue

}
