//
//  FunctionCDEC.swift
//  MMExpressionSolver
//

import Foundation

/// Function CDEC()
///
/// Implementation of expression-function `CDEC()`.
///
/// The CDEC() function converts a given value into its `Decimal` representation.
///
/// ```
/// CDEC(value: any) -> decimnal
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionCDEC: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "CDEC"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionCDEC") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionCDEC.symbolFunction,
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
            return ExpressionValue.of(p1.asConvertedDecimalNumber()!)
        } else if p1.isStringValue {
            if let value: Decimal = Decimal(string: p1.asString()!) {
                return ExpressionValue.of(value)
            }
        }
        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                    funcName: FunctionCDEC.symbolFunction,
                                                    paramName: ExpressionFunctionParameter.nameValue,
                                                    value: p1.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionCDEC.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionCDEC.symbolFunction
    }

}
