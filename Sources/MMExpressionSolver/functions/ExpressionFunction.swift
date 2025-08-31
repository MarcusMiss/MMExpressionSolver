//
//  ExpressionFunction.swift
//  MMExpressionSolver
//

import Foundation

/// Expression-funtion to provide for evaluation of functions.
///  
/// Protocol describing abilities of an expression-function.
///  
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public protocol ExpressionFunction: Identifiable<FunctionIdentifier>, CustomStringConvertible, CustomDebugStringConvertible {

    /// Definition of function.
    var definition: ExpressionFunctionDefinition { get }
    /// Symbols representing functions. Minimum one.
    var symbols: [String] { get }

    /// Evaluate function value.
    /// - Parameters:
    ///   - expression: source-expression
    ///   - context: evaluation-context
    ///   - functionToken: token referring to this function
    ///   - arguments: arguments for function-call
    /// - Returns: Evaluated value
    /// - Throws: ``ExpressionError`` in case of errors
    func evaluateFunction(expression: MMExpression,
                          context: any ExpressionEvaluationContext,
                          functionToken: Token,
                          arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue

}
