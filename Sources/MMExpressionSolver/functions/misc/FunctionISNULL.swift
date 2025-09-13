//
//  FunctionISNULL.swift
//  MMExpressionSolver
//

import Foundation

/// Function ISNULL()
///
/// Implementation of expression-function `ISNULL()`.
///
/// The ISNULL() (all types) function returns `true` if given value is _null_ (or _nil_), otherwise `false`.
///
/// ```
/// ISNULL(value) -> Bool
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.}
public final class FunctionISNULL: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ISNULL"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionISNULL") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionISNULL.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue, allowNull: true)
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.type == .null {
            return ExpressionValue.of(true)!
        }
        return ExpressionValue.of(false)!
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionISNULL.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionISNULL.symbolFunction
    }

}
