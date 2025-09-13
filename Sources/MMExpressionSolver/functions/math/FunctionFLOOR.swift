//
//  FunctionFLOOR.swift
//  MMExpressionSolver
//

import Foundation

/// Function FLOOR()
///
/// Implementation of expression-function `FLOOR()`.
///
/// The FLOOR() function returns the largest value less than or equal to a given numeric expression.
/// In other words, it rounds a number downward toward negative infinity.
///
/// ```
/// FLOOR(value: decimal) -> decimal
/// FLOOR(value: double) -> double
/// FLOOR(value: float) -> float
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionFLOOR: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "FLOOR"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionFLOOR") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionFLOOR.symbolFunction,
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
            return ExpressionValue.of(Decimal(floor(p1.asConvertedDoubleNumber()!)))!
        } else if p1.type == .double {
            return ExpressionValue.of(floor(p1.asDouble()!))!
        } else if p1.type == .float {
            return ExpressionValue.of(floor(p1.asFloat()!))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameValue,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionFLOOR.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionFLOOR.symbolFunction
    }

}
