//
//  FunctionSIGN.swift
//  MMExpressionSolver
//

import Foundation

/// Function SIGN()
///
/// Implementation of expression-function `SIGN()`.
///
/// The SIGN() function returns an integer that indicates the sign of a numeric expression — whether it is positive, negative, or zero.
///
/// ```
/// SIGN(value: int) -> int
/// SIGN(value: decimal) -> int
/// SIGN(value: double) -> int
/// SIGN(value: float) -> int
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionSIGN: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "SIGN"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionSIGN") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionSIGN.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [.double, .float, .decimal, .int ])
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.isNumericValue {
            let value: Decimal = p1.asConvertedDecimalNumber()!
            var result: Int
            if value > 0 {
                result = 1
            } else if value < 0 {
                result = -1
            } else {
                result = 0
            }
            return ExpressionValue.of(result)!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameValue,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionSIGN.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionSIGN.symbolFunction
    }

}

