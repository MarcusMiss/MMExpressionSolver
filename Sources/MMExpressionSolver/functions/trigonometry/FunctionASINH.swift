//
//  FunctionASINH.swift
//  MMExpressionSolver
//

import Foundation

/// Function ASINH()
///
/// Implementation of expression-function `ASINH()`.
///
/// The ASINH() function returns the inverse hyperbolic sine of a number.
///
/// ```
/// ASINH(number: numeric value) -> double
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionASINH: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ASINH"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionASINH") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionASINH.symbolFunction,
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
            return ExpressionValue.of(try FunctionASINH.asinh(value))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionASINH.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionASINH.symbolFunction
    }

    // MARK: - API

    public static func asinh(_ value: Double) throws(ExpressionError) -> Double {
        return log(value + sqrt(value * value + 1.0))
    }

}
