//
//  FunctionACOSEC.swift
//  MMExpressionSolver
//

import Foundation

/// Function ACOSEC()
///
/// Implementation of expression-function `ACOSEC()`.
///
/// The ACOSEC() function returns the inverse cosecant of a number.
///
/// ```
/// ACOSEC(number: numeric value) -> double
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionACOSEC: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ACOSEC"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionACOSEC") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionACOSEC.symbolFunction,
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
            if abs(value) < 1.0 {
                throw ExpressionError.parameterInInvalidRange(token: functionToken,
                                                              funcName: FunctionACOSEC.symbolFunction,
                                                              paramName: ExpressionFunctionParameter.nameNumber,
                                                              value: p1.asStringForError())
            }
            return ExpressionValue.of(asin(1.0/value))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionACOSEC.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionACOSEC.symbolFunction
    }

}
