//
//  FunctionADDDAY.swift
//  MMExpressionSolver
//

import Foundation

/// Function ADDDAY()
///
/// Implementation of expression-function `ADDDAY()`.
///
/// Add given days to given date.
///
/// ```
/// ADDDAY(value: date, day: int) -> date
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.2.0>. }
public final class FunctionADDDAY: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ADDDAY"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionADDDAY") }}

    // MARK: - Protocol ExpressionFunction
    
    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionADDDAY.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue, strictTypes: [.datetime]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameDay, strictTypes: [.int]),
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        let p2: ExpressionValue = arguments[1]
        if !p1.isDateTime {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameValue,
                                                       value: p1.asStringForError())
        }
        if !p2.isIntegerValue {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameDay,
                                                       value: p2.asStringForError())
        }
        guard let result: Date = context.calendar.date(byAdding: DateComponents(day: p2.asInteger()!), to: p1.asDateTime()!) else {
            throw ExpressionError.invalidParameterValue(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameDay,
                                                       value: p2.asStringForError())
        }
        return ExpressionValue.of(result)
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionADDDAY.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionADDDAY.symbolFunction
    }

}
