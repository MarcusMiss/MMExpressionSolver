//
//  FunctionACOSH.swift
//  MMExpressionSolver
//

import Foundation

/// Function ACOSH()
///
/// Implementation of expression-function `ACOSH()`.
///
/// The ACOSH() function returns the inverse hyperbolic cosine of a number.
///
/// ```
/// ACOSH(number: numeric value) -> double
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionACOSH: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ACOSH"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionACOSH") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionACOSH.symbolFunction,
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
            return ExpressionValue.of(try FunctionACOSH.acosh(value, functionToken, p1))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionACOSH.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionACOSH.symbolFunction
    }

    // MARK: - API

    public static func acosh(_ value: Double, _ functionToken: Token, _ p1: ExpressionValue) throws(ExpressionError) -> Double {
        if value < 1.0 {
            throw ExpressionError.parameterInInvalidRange(token: functionToken,
                                                          funcName: FunctionACOSH.symbolFunction,
                                                          paramName: ExpressionFunctionParameter.nameNumber,
                                                          value: p1.asStringForError())
        }
        return log(value + sqrt(value * value - 1.0))
    }

}
