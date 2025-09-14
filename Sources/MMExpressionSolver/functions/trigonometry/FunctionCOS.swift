//
//  FunctionCOS.swift
//  MMExpressionSolver
//

import Foundation

/// Function COS()
///
/// Implementation of expression-function `COS()`.
///
/// The COS() function returns the trigonometric cosine of an angle..
///
/// ```
/// COS(number: numeric value) -> double
/// COS(number: measurement<angle>) -> double
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionCOS: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "COS"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionCOS") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionCOS.symbolFunction,
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
            return ExpressionValue.of(cos(value))!
        } else if p1.isUnitAngle {
            let value: Measurement<UnitAngle> = p1.asUnitAngle()!.converted(to: .radians)
            return ExpressionValue.of(cos(value.value))
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionCOS.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionCOS.symbolFunction
    }

}
