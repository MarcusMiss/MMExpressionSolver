//
//  FunctionDATE.swift
//  MMExpressionSolver
//
//

import Foundation

/// Function DATE()
///
/// Implementation of expression-function `DATE()`.
///
/// Defines a new date.
///
/// ```
/// DATE(year: int, month: int, day: int, hour: int, minute: int, second: int) -> date
/// ```
/// ### Sample
///
/// ```
/// DATE(2025, 9, 5, 14, 8, 00)
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.2.0>. }
public final class FunctionDATE: ExpressionFunction {

    
    /// Symbol of this function
    static let symbolFunction: String = "DATE"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionDATE") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionDATE.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameYear, strictTypes: [.int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameMonth, strictTypes: [.int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameDay, strictTypes: [.int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameHour, strictTypes: [.int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameMinute, strictTypes: [.int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameSecond, strictTypes: [.int]),
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        if arguments.count != 6 {
            throw ExpressionError.argumentCountNotMatching(token: functionToken)
        }
        let components: [Calendar.Component] = [.year, .month, .day, .hour, .minute, .second]
        var values: [Int] = [0, 0, 0, 0, 0, 0]
        for i in 0..<arguments.count {
            if !arguments[i].isIntegerValue {
                throw ExpressionError.invalidParameterType(token: functionToken,
                                                           funcName: definition.name,
                                                           paramName: self.definition.parameters[i].name,
                                                           value: arguments[i].asStringForError())
            }
            values[i] = arguments[i].asInteger()!
            if !Calendar.current.maximumRange(of: components[i])!.contains(values[i]) {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: definition.name,
                                                           paramName: definition.parameters[i].name,
                                                           value: arguments[i].asStringForError())
            }
        }
        return ExpressionValue.of(Date.create(year: values[0],
                                              month: values[1],
                                              day: values[2],
                                              hour: values[3],
                                              minute: values[4],
                                              second: values[5]))
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionDATE.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionDATE.symbolFunction
    }

}
