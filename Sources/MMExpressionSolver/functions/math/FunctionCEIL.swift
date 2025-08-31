//
//  FunctionCEIL.swift
//  MMExpressionSolver
//

import Foundation

/// Function CEIL()
///
/// Implementation of expression-function `CEIL()`.
///
/// The CEIL() (ceiling) function returns the smallest integer value greater than or equal to a given numeric expression.
/// In other words, it rounds a number upward to the nearest whole number.
///
/// ```
/// CEIL(value: decimal) -> decimal
/// CEIL(value: double) -> double
/// CEIL(value: float) -> float
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionCEIL: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "CEIL"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionCEIL") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionCEIL.symbolFunction,
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
            return ExpressionValue.of(Decimal(ceil(p1.asConvertedDoubleNumber()!)))!
        } else if p1.type == .double {
            return ExpressionValue.of(ceil(p1.asDouble()!))!
        } else if p1.type == .float {
            return ExpressionValue.of(ceil(p1.asFloat()!))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameValue,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionCEIL.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionCEIL.symbolFunction
    }

}
