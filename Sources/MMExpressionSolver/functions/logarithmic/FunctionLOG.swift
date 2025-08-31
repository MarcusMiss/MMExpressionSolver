//
//  FunctionLOG.swift
//  MMExpressionSolver
//

import Foundation

/// Function LOG()
///
/// Implementation of expression-function `LOG()`.
///
/// The LOG() function returns the natural logarithm of a positive number.
///
/// ```
/// LOG(number: numeric value) -> double
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionLOG: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "LOG"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionLOG") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionLOG.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameNumber,
                                        strictTypes: [.double, .float, .decimal, .int ])
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.isNumericValue {
            let value: Double = p1.asConvertedDoubleNumber()!
            if value <= 0.0 {
                throw ExpressionError.parameterInInvalidRange(token: functionToken,
                                                              funcName: FunctionLOG.symbolFunction,
                                                              paramName: ExpressionFunctionParameter.nameNumber,
                                                              value: p1.asStringForError())
            }
            return ExpressionValue.of(log(value))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionLOG.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionLOG.symbolFunction
    }

}
