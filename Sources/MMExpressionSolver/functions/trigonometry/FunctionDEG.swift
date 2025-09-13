//
//  FunctionDEG.swift
//  MMExpressionSolver
//

import Foundation

/// Function DEG()
///
/// Implementation of expression-function `DEG()`.
///
/// Converts radiant to degree.
///
/// ```
/// DEG(number: numeric value) -> double
/// DEG(number: measurement<angle>) -> double
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionDEG: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "DEG"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionDEG") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionDEG.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameNumber,
                                        strictTypes: [.double, .float, .decimal, .int, .measurement(unit: .unitAngle) ])
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
            return ExpressionValue.of((value * 180.0 / .pi))!
        } else if p1.isUnitAngle {
            let value: Measurement<UnitAngle> = p1.asUnitAngle()!
            return ExpressionValue.of(value.converted(to: .degrees))
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionDEG.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionDEG.symbolFunction
    }

}
