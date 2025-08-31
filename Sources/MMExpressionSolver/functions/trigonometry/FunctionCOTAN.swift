//
//  FunctionCOTAN.swift
//  MMExpressionSolver
//

import Foundation

/// Function COTAN()
///
/// Implementation of expression-function `COTAN()`.
///
/// The COTAN() function returns the cotangent of an angle.
///
/// ```
/// COTAN(number: numeric value) -> double
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionCOTAN: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "COTAN"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionCOTAN") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionCOTAN.symbolFunction,
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
            return ExpressionValue.of(try FunctionCOTAN.cotan(value, functionToken, p1))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionCOTAN.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionCOTAN.symbolFunction
    }

    // MARK: - API

    public static func cotan(_ value: Double, _ functionToken: Token, _ p1: ExpressionValue) throws(ExpressionError) -> Double {
        if value.isZero {
            throw ExpressionError.parameterInInvalidRange(token: functionToken,
                                                          funcName: FunctionCOTAN.symbolFunction,
                                                          paramName: ExpressionFunctionParameter.nameNumber,
                                                          value: p1.asStringForError())
        }
        return 1.0 / tan(value)
    }

}
