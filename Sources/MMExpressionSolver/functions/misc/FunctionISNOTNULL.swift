//
//  FunctionISNOTNULL.swift
//  MMExpressionSolver
//

import Foundation

/// Function ISNOTNULL()
///
/// Implementation of expression-function `ISNOTNULL()`.
///
/// The ISNOTNULL() (all types) function returns `false` if given value is _null_ (or _nil_), otherwise `true`.
///
/// ```
/// ISNOTNULL(value) -> Bool
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.}
public final class FunctionISNOTNULL: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ISNOTNULL"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionISNOTNULL") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionISNOTNULL.symbolFunction,
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
            return ExpressionValue.of(false)!
        }
        return ExpressionValue.of(true)!
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionISNOTNULL.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionISNOTNULL.symbolFunction
    }

}
