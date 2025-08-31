//
//  FunctionSEC.swift
//  MMExpressionSolver
//

import Foundation

/// Function SEC()
///
/// Implementation of expression-function `SEC()`.
///
/// The SEC() function returns the secant of an angle.
///
/// ```
/// SEC(number: numeric value) -> double
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionSEC: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "SEC"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionSEC") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionSEC.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameNumber,
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
            let value: Double = p1.asConvertedDoubleNumber()!
            return ExpressionValue.of(try FunctionSEC.sec(value, functionToken, p1))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionSEC.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionSEC.symbolFunction
    }

    // MARK: - API

    public static func sec(_ value: Double, _ functionToken: Token, _ p1: ExpressionValue) throws(ExpressionError) -> Double {
        if value == 0.5 * .pi {
            throw ExpressionError.parameterInInvalidRange(token: functionToken,
                                                          funcName: FunctionSEC.symbolFunction,
                                                          paramName: ExpressionFunctionParameter.nameNumber,
                                                          value: p1.asStringForError())
        }
        return 1.0 / cos(value)
    }

}
