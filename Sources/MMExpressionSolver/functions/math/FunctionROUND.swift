//
//  FunctionROUND.swift
//  MMExpressionSolver
//

import Foundation

/// Function ROUND()
///
/// Implementation of expression-function `ROUND()`.
///
/// The ROUND() function returns a numeric value rounded to the nearest integer or to a specified number of decimal places.
/// It follows the standard rounding rule.
///
/// ```
/// ROUND(value: decimal) -> decimal
/// ROUND(value: double) -> double
/// ROUND(value: float) -> float
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionROUND: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ROUND"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionROUND") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionROUND.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [.double, .float, .decimal])
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.type == .decimal {
            return ExpressionValue.of(Decimal(p1.asConvertedDoubleNumber()!.rounded()))!
        } else if p1.type == .double {
            return ExpressionValue.of(p1.asDouble()!.rounded())!
        } else if p1.type == .float {
            return ExpressionValue.of(p1.asFloat()!.rounded())!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameValue,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionROUND.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionROUND.symbolFunction
    }

}

