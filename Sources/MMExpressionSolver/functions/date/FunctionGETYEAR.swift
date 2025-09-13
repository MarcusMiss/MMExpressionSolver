//
//  FunctionGETYEAR.swift
//  MMExpressionSolver
//

import Foundation

/// Function GETYEAR()
///
/// Implementation of expression-function `GETYEAR()`.
///
/// Return years from given date.
///
/// ```
/// GETYEAR(value: date) -> int
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.2.0>. }
public final class FunctionGETYEAR: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "GETYEAR"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionGETYEAR") }}

    // MARK: - Protocol ExpressionFunction
    
    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionGETYEAR.symbolFunction,
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
        return ExpressionValue.of(context.calendar.component(.year, from: p1.asDateTime()!))
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionGETYEAR.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionGETYEAR.symbolFunction
    }

}
