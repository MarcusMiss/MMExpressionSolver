//
//  FunctionCOSECH.swift
//  MMExpressionSolver
//

import Foundation

/// Function COSECH()
///
/// Implementation of expression-function `COSECH()`.
///
/// The COSECH() function returns the hyperbolic cosecant of a number.
///
/// ```
/// COSECH(number: numeric value) -> double
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionCOSECH: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "COSECH"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionCOSECH") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionCOSECH.symbolFunction,
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
            return ExpressionValue.of(try FunctionCOSECH.cosech(value, functionToken, p1))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionCOSECH.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionCOSECH.symbolFunction
    }

    // MARK: - API

    public static func cosech(_ value: Double, _ functionToken: Token, _ p1: ExpressionValue) throws(ExpressionError) -> Double {
        if value.isZero {
            throw ExpressionError.parameterInInvalidRange(token: functionToken,
                                                          funcName: FunctionCOSECH.symbolFunction,
                                                          paramName: ExpressionFunctionParameter.nameNumber,
                                                          value: p1.asStringForError())
        }
        return 2.0 / (exp(value) - exp(-value))
    }

}
