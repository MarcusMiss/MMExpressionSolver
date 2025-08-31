//
//  FunctionACOS.swift
//  MMExpressionSolver
//

import Foundation

/// Function ACOS()
///
/// Implementation of expression-function `ACOS()`.
///
/// The ACOS() function returns the arc cosine (inverse cosine) of a number.
///
/// ```
/// ACOS(number: numeric value) -> double
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionACOS: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ACOS"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionACOS") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionACOS.symbolFunction,
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
            if value < -1.0 || value > 1.0 {
                throw ExpressionError.parameterInInvalidRange(token: functionToken,
                                                              funcName: FunctionACOS.symbolFunction,
                                                              paramName: ExpressionFunctionParameter.nameNumber,
                                                              value: p1.asStringForError())
            }
            return ExpressionValue.of(acos(value))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionACOS.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionACOS.symbolFunction
    }

}
