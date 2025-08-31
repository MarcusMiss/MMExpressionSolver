//
//  FunctionLOG1P.swift
//  MMExpressionSolver
//

import Foundation

/// Function LOG1P()
///
/// Implementation of expression-function `LOG1P()`.
///
/// The LOG1P() function returns the natural logarithm of _1 + x_, computed in a way that is more accurate for values of _x_ close to zero.
///
/// ```
/// LOG1P(number: numeric value) -> double
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionLOG1P: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "LOG1P"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionLOG1P") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionLOG1P.symbolFunction,
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
            if value <= -1 {
                throw ExpressionError.parameterInInvalidRange(token: functionToken,
                                                              funcName: FunctionLOG1P.symbolFunction,
                                                              paramName: ExpressionFunctionParameter.nameNumber,
                                                              value: p1.asStringForError())
            }
            return ExpressionValue.of(log1p(value))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionLOG1P.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionLOG1P.symbolFunction
    }

}
