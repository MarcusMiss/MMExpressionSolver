//
//  FunctionCFLT.swift
//  MMExpressionSolver
//

import Foundation

/// Function CFLT()
///
/// Implementation of expression-function `CFLT()`.
///
/// The CFLT() function converts a given value into its `Float` representation.
///
/// ```
/// CFLT(value: any) -> float
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionCFLT: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "CFLT"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionCFLT") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionCFLT.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue, allowNull: true)
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.isNumericValue {
            return ExpressionValue.of(p1.asConvertedFloatNumber()!)
        } else if p1.isStringValue {
            if let value: Float = Float(p1.asString()!) {
                return ExpressionValue.of(value)
            }
        }
        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                    funcName: FunctionCDBL.symbolFunction,
                                                    paramName: ExpressionFunctionParameter.nameValue,
                                                    value: p1.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionCFLT.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionCFLT.symbolFunction
    }

}
