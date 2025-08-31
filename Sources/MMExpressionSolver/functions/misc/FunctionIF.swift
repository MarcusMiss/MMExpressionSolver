//
//  FunctionIF.swift
//  MMExpressionSolver
//

import Foundation

/// Function IF()
///
/// Implementation of expression-function `IF()`.
///
/// The IF() function returns conditional value A (in case of `true`) or value B (in case of `false`).
///
/// ```
/// IF(condition: bool, A, B ) -> A | B
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
///
public final class FunctionIF: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "IF"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionIF") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionIF.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: "expr", strictTypes: [.boolean]),
            ExpressionFunctionParameter(name: "truepath" , strictTypes: [.nodeAST], isLazy: true),
            ExpressionFunctionParameter(name: "falsepath", strictTypes: [.nodeAST], isLazy: true)
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.type == .boolean {
            let condition: Bool = p1.asBoolean()!
            if condition {
                return try expression.evaluateNode(context: context, node: arguments[1].asNode()!)
            } else {
                return try expression.evaluateNode(context: context, node: arguments[2].asNode()!)
            }
        }
        throw ExpressionError.invalidParameterType(token: functionToken,
                                                   funcName: definition.name,
                                                   paramName: ExpressionFunctionParameter.nameValue,
                                                   value: p1.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionIF.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionIF.symbolFunction
    }

}
