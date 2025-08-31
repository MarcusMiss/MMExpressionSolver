//
//  FunctionCINT.swift
//  MMExpressionSolver
//

import Foundation

/// Function CINT()
///
/// Implementation of expression-function `CINT()`.
///
/// The CINT() function converts a given value into its `Int` representation.
///
/// ```
/// CINT(value: any) -> integer
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionCINT: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "CINT"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionCINT") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionCINT.symbolFunction,
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
        if p1.isNumericValue {
            return ExpressionValue.of(p1.asConvertedIntegerNumber()!)
        } else if p1.isStringValue {
            if let value: Int = Int(p1.asString()!) {
                return ExpressionValue.of(value)
            }
        }
        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                    funcName: FunctionCINT.symbolFunction,
                                                    paramName: ExpressionFunctionParameter.nameValue,
                                                    value: p1.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionCINT.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionCINT.symbolFunction
    }

}
