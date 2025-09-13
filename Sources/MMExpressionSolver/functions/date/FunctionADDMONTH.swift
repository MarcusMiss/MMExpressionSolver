//
//  FunctionADDMONTH.swift
//  MMExpressionSolver
//

import Foundation

/// Function ADDMONTH()
///
/// Implementation of expression-function `ADDMONTH()`.
///
/// Add given months to given date.
///
/// ```
/// ADDMONTH(value: date, month: int) -> date
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.2.0>. }
public final class FunctionADDMONTH: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ADDMONTH"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionADDMONTH") }}

    // MARK: - Protocol ExpressionFunction
    
    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionADDMONTH.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue, strictTypes: [.datetime]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameMonth, strictTypes: [.int]),
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
                                                       paramName: ExpressionFunctionParameter.nameMonth,
                                                       value: p2.asStringForError())
        }
        guard let result: Date = context.calendar.date(byAdding: DateComponents(month: p2.asInteger()!), to: p1.asDateTime()!) else {
            throw ExpressionError.invalidParameterValue(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameMonth,
                                                       value: p2.asStringForError())
        }
        return ExpressionValue.of(result)
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionADDMONTH.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionADDMONTH.symbolFunction
    }

}
