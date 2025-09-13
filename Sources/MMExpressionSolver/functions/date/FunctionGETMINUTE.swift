//
//  FunctionGETMINUTE.swift
//  MMExpressionSolver
//

import Foundation

/// Function GETMINUTE()
///
/// Implementation of expression-function `GETMINUTE()`.
///
/// Return minute from given date.
///
/// ```
/// GETMINUTE(value: date) -> int
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.2.0>. }
public final class FunctionGETMINUTE: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "GETMINUTE"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionGETMINUTE") }}

    // MARK: - Protocol ExpressionFunction
    
    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionGETMINUTE.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue, strictTypes: [.datetime]),
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if !p1.isDateTime {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameValue,
                                                       value: p1.asStringForError())
        }
        return ExpressionValue.of(context.calendar.component(.minute, from: p1.asDateTime()!))
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionGETMINUTE.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionGETMINUTE.symbolFunction
    }

}
