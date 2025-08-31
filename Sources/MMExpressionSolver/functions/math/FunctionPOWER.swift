//
//  FunctionPOWER.swift
//  MMExpressionSolver
//

import Foundation

/// Function POWER()
///
/// Implementation of expression-function `POWER()`.
///
/// The POWER() function returns the result of raising a numeric base to the power of a given exponent.
///
/// ```
/// POWER(value: decimal, power: int) -> decimal
/// POWER(value: double, power: int) -> decimal
/// POWER(value: int, power: int) -> decimal
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionPOWER: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "POWER"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionPOWER") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionPOWER.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [.double, .float, .decimal, .int]),
            ExpressionFunctionParameter(name: "power",
                                        strictTypes: [.int])
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        let p2: ExpressionValue = arguments[1]
        if p1.isNumericValue && p2.isNumericValue {
            let value: Decimal = p1.asConvertedDecimalNumber()!
            let powValue: Int = p2.asConvertedIntegerNumber()!
            return ExpressionValue.of(pow(value, powValue))!
        }
        throw ExpressionError.invalidParameterType(token: functionToken,
                                                   funcName: definition.name,
                                                   paramName: ExpressionFunctionParameter.nameValue,
                                                   value: p1.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionPOWER.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionPOWER.symbolFunction
    }

}
