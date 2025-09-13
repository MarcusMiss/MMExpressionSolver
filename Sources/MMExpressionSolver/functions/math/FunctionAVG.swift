//
//  FunctionAVG.swift
//  MMExpressionSolver
//

import Foundation

/// Function AVG()
///
/// Implementation of expression-function `AVG()`.
///
/// The AVG() function returns the arithmetic mean of a set of numbers.
///
/// ```
/// AVG(value: numeric, ...: numeric) -> numeric
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionAVG: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "AVG"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionAVG") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionAVG.symbolFunction,
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
                                                            funcName: FunctionAVG.symbolFunction,
                                                            paramName: "\(ExpressionFunctionParameter.nameValue).\(loop + 1)",
                                                            value: loopVar.asStringForError())
            }
            value += loopVar.asConvertedDecimalNumber()!
        }
        return ExpressionValue.of(value / Decimal(arguments.count))
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionAVG.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionAVG.symbolFunction
    }

}
