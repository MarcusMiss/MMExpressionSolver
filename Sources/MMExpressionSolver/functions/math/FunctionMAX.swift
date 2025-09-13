//
//  FunctionMAX.swift
//  MMExpressionSolver
//

import Foundation

/// Function MIN()
///
/// Implementation of expression-function `MAX()`.
///
/// The MAX() function returns the maximum value of given values.
///
/// ```
/// MAX(value: numeric, ...: numeric) -> numeric
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionMAX: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "MAX"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionMAX") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionMAX.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [.double, .float, .decimal, .int], isVarArg: true)
        ]
    )

    public var symbols: [String] { get { [definition.name] } }

    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        var value: ExpressionValue = ExpressionValue.ofNil()
        for loop in 0..<arguments.count {
            let loopVar: ExpressionValue = arguments[loop]
            if !loopVar.isNumericValue {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: FunctionMAX.symbolFunction,
                                                            paramName: "\(ExpressionFunctionParameter.nameValue).\(loop + 1)",
                                                            value: loopVar.asStringForError())
            }
            if loop == 0 {
                value = loopVar
            } else {
                if loopVar > value {
                    value = loopVar
                }
            }
        }
        return value
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionMAX.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionMAX.symbolFunction
    }

}
