//
//  FunctionMIN.swift
//  MMExpressionSolver
//

import Foundation

/// Function MIN()
///
/// Implementation of expression-function `MIN()`.
///
/// The MIN() function returns the minimal value of a given values.
///
/// ```
/// MIN(value: numeric, ...: numeric) -> numeric
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionMIN: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "MIN"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionMIN") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionMIN.symbolFunction,
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
                                                            funcName: FunctionMIN.symbolFunction,
                                                            paramName: "\(ExpressionFunctionParameter.nameValue).\(loop + 1)",
                                                            value: loopVar.asStringForError())
            }
            if loop == 0 {
                value = loopVar
            } else {
                if loopVar < value {
                    value = loopVar
                }
            }
        }
        return value
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionMIN.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionMIN.symbolFunction
    }

}
