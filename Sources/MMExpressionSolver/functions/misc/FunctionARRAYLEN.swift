//
//  FunctionARRAYLEN.swift
//  MMExpressionSolver
//

import Foundation

/// Function ISNULL()
///
/// Implementation of expression-function `ARRAYLEN()`.
///
/// The ARRAYLEN() function returns length of given array.
///
/// ```
/// ARRAYLEN(array) -> Int
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
///
public final class FunctionARRAYLEN: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ARRAYLEN"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionARRAYLEN") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionARRAYLEN.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [.array])
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.type == .array {
            return ExpressionValue.of(p1.asArray()!.count)!
        }
        throw ExpressionError.invalidParameterType(token: functionToken,
                                                   funcName: definition.name,
                                                   paramName: ExpressionFunctionParameter.nameValue,
                                                   value: p1.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionARRAYLEN.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionARRAYLEN.symbolFunction
    }

}
