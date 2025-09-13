//
//  FunctionGETSECOND.swift
//  MMExpressionSolver
//

import Foundation

/// Function GETSECOND()
///
/// Implementation of expression-function `GETSECOND()`.
///
/// Return second from given date.
///
/// ```
/// GETSECOND(value: date) -> int
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.2.0>. }
public final class FunctionGETSECOND: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "GETSECOND"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionGETSECOND") }}

    // MARK: - Protocol ExpressionFunction
    
    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionGETSECOND.symbolFunction,
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
        return ExpressionValue.of(context.calendar.component(.second, from: p1.asDateTime()!))
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionGETSECOND.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionGETSECOND.symbolFunction
    }

}
