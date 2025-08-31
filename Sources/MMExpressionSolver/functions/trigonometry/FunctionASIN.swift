//
//  FunctionASIN.swift
//  MMExpressionSolver
//


import Foundation

/// Function ASIN()
///
/// Implementation of expression-function `ASIN()`.
///
/// The ASIN() function returns the arc sine (inverse sine) of a number.
///
/// ```
/// ASIN(number: numeric value) -> double
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionASIN: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ASIN"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionASIN") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionASIN.symbolFunction,
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
            if value < -1.0 || value > 1.0 {
                throw ExpressionError.parameterInInvalidRange(token: functionToken,
                                                              funcName: FunctionASIN.symbolFunction,
                                                              paramName: ExpressionFunctionParameter.nameNumber,
                                                              value: p1.asStringForError())
            }
            return ExpressionValue.of(asin(value))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionASIN.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionASIN.symbolFunction
    }

}
