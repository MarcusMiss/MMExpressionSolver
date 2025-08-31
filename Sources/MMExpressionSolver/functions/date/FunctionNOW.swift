//
//  FunctionNOW.swift
//  MMExpressionSolver
//

import Foundation

/// Function NOW()
///
/// Implementation of expression-function `NOW()`.
///
/// Evaluates current date.
///
/// ```
/// NOW() -> date
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionNOW: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "NOW"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionNOW") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionNOW.symbolFunction,
        parameters:[]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        return ExpressionValue.of(Date())!
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionNOW.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionNOW.symbolFunction
    }

}
