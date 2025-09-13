//
//  FunctionATAN.swift
//  MMExpressionSolver
//

import Foundation

/// Function ATAN()
///
/// Implementation of expression-function `ATAN()`.
///
/// The ATAN() function returns the arc tangent (inverse tangent) of a number.
///
/// ```
/// ATAN(number: numeric value) -> double
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionATAN: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ATAN"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionATAN") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionATAN.symbolFunction,
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
            return ExpressionValue.of(atan(value))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameNumber,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionATAN.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionATAN.symbolFunction
    }

}
