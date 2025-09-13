//
//  FunctionADDYEAR.swift
//  MMExpressionSolver
//

import Foundation

/// Function ADDYEAR()
///
/// Implementation of expression-function `ADDYEAR()`.
///
/// Add given years to given date.
///
/// ```
/// ADDYEAR(value: date, year: int) -> date
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.2.0>. }
public final class FunctionADDYEAR: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ADDYEAR"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionADDYEAR") }}

    // MARK: - Protocol ExpressionFunction
    
    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionADDYEAR.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue, strictTypes: [.datetime]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameYear, strictTypes: [.int]),
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
                                                       paramName: ExpressionFunctionParameter.nameYear,
                                                       value: p2.asStringForError())
        }
        guard let result: Date = context.calendar.date(byAdding: DateComponents(year: p2.asInteger()!), to: p1.asDateTime()!) else {
            throw ExpressionError.invalidParameterValue(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameYear,
                                                       value: p2.asStringForError())
        }
        return ExpressionValue.of(result)
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionADDYEAR.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionADDYEAR.symbolFunction
    }

}
