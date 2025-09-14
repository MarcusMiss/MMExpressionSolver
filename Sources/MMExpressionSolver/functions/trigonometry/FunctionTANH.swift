//
//  FunctionTANH.swift
//  MMExpressionSolver
//

import Foundation

/// Function TANH()
///
/// Implementation of expression-function `TANH()`.
///
/// The TANH() function returns the hyperbolic tangent of a number.
///
/// ```
/// TANH(number: numeric value) -> double
/// TANH(number: measurement<angle>) -> double
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionTANH: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "TANH"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionTANH") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionTANH.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameNumber,
                                        strictTypes: [.double, .float, .decimal, .int, .measurement(unit: .unitAngle)])
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
            return ExpressionValue.of(tanh(value))!
        } else if p1.isUnitAngle {
            let value: Measurement<UnitAngle> = p1.asUnitAngle()!.converted(to: .radians)
            return ExpressionValue.of(tanh(value.value))
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionTANH.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionTANH.symbolFunction
    }

}
