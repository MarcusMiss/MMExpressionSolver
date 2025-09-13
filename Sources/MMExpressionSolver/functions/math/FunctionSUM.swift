//
//  FunctionSUM.swift
//  MMExpressionSolver
//

import Foundation

/// Function SUM()
///
/// Implementation of expression-function `SUM()`.
///
/// The SUM() function returns the total sum of a sequence of numbers.
///
/// ```
/// SUM(value: numeric, ...: numeric) -> numeric
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionSUM: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "SUM"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionSUM") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionSUM.symbolFunction,
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
        var value: Decimal = 0
        for loop in 0..<arguments.count {
            let loopVar: ExpressionValue = arguments[loop]
            if !loopVar.isNumericValue {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: FunctionSUM.symbolFunction,
                                                            paramName: "\(ExpressionFunctionParameter.nameValue).\(loop + 1)",
                                                            value: loopVar.asStringForError())
            }
            value += loopVar.asConvertedDecimalNumber()!
        }
        return ExpressionValue.of(value)
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionSUM.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionSUM.symbolFunction
    }

}
