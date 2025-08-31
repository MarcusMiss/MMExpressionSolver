//
//  FunctionABS.swift
//  MMExpressionSolver
//

import Foundation

/// Function ABS()
///
/// Implementation of expression-function `ABS()`.
///
/// The ABS() (absolute value) function returns the non-negative magnitude of a numeric expression by removing its sign.
///
/// ```
/// ABS(value: int) -> int
/// ABS(value: decimal) -> decimal
/// ABS(value: double) -> double
/// ABS(value: float) -> float
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionABS: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ABS"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionABS") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionABS.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [.double, .float, .decimal, .int ])
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.type == .decimal {
            return ExpressionValue.of(abs(p1.asDecimal()!))!
        } else if p1.type == .double {
            return ExpressionValue.of(abs(p1.asDouble()!))!
        } else if p1.type == .float {
            return ExpressionValue.of(abs(p1.asFloat()!))!
        } else if p1.type == .int {
            return ExpressionValue.of(abs(p1.asInteger()!))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameValue,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionABS.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionABS.symbolFunction
    }

}
