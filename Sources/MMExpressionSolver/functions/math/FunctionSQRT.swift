//
//  FunctionSQRT.swift
//  MMExpressionSolver
//

import Foundation

/// Function SQRT()
///
/// Implementation of expression-function `SQRT()`.
///
/// The SQRT() (square root) function returns the non-negative square root of a numeric expression.
/// In other words, it computes the value that, when multiplied by itself, equals the given number.
///
/// ```
/// SQRT(value: decimal) -> decimal
/// SQRT(value: double) -> double
/// SQRT(value: float) -> float
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionSQRT: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "SQRT"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionSQRT") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionSQRT.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [.double, .float, .decimal])
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.type == .decimal {
            return ExpressionValue.of(Decimal(sqrt(p1.asConvertedDoubleNumber()!)))!
        } else if p1.type == .double {
            return ExpressionValue.of(sqrt(p1.asDouble()!))!
        } else if p1.type == .float {
            return ExpressionValue.of(sqrt(p1.asFloat()!))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameValue,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionSQRT.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionSQRT.symbolFunction
    }

}
