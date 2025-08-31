//
//  FunctionACOTAN.swift
//  MMExpressionSolver
//

import Foundation

/// Function ACOTAN()
///
/// Implementation of expression-function `ACOTAN()`.
///
/// The ACONTAN() function returns the inverse cotangent of a number.
///
/// ```
/// ACOTAN(number: numeric value) -> double
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionACOTAN: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ACOTAN"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionACOTAN") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionACOTAN.symbolFunction,
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
            return ExpressionValue.of(try FunctionACOTAN.acotan(value))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionACOTAN.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionACOTAN.symbolFunction
    }

    // MARK: - API

    public static func acotan(_ value: Double) throws(ExpressionError) -> Double {
        if value == 0.0 {
            return .pi / 2.0
        } else if value > 0 {
            return atan(1.0 / value)
        } else {
            return atan(1.0 / value) * .pi
        }
    }

}
