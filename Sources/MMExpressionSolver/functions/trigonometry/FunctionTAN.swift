//
//  FunctionTAN.swift
//  MMExpressionSolver
//

import Foundation

/// Function TAN()
///
/// Implementation of expression-function `TAN()`.
///
/// The TAN() function returns the trigonometric tangent of an angle.
///
/// ```
/// TAN(number: numeric value) -> double
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionTAN: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "TAN"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionTAN") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionTAN.symbolFunction,
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
            return ExpressionValue.of(tan(value))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionTAN.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionTAN.symbolFunction
    }

}
