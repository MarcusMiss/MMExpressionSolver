//
//  FunctionCSTR.swift
//  MMExpressionSolver
//

import Foundation

/// Function CSTR()
///
/// Implementation of expression-function `CSTR()`.
///
/// The CSTR() function converts a given value into its string (text) representation.
///
/// ```
/// CSTR(value: any) -> string
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionCSTR: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "CSTR"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionCSTR") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionCSTR.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue, allowNull: true)
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.isNullValue {
            return ExpressionValue.of("");
        }
        return ExpressionValue.of(p1.asStandardString())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionCSTR.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionCSTR.symbolFunction
    }

}
