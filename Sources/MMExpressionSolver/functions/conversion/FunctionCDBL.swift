//
//  FunctionCDBL.swift
//  MMExpressionSolver
//

import Foundation

/// Function CDBL()
///
/// Implementation of expression-function `CDBL()`.
///
/// The CDBL) function converts a given value into its `Double` representation.
///
/// ```
/// CDBL(value: any) -> double
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionCDBL: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "CDBL"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionCDBL") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionCDBL.symbolFunction,
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
            return ExpressionValue.of(p1.asConvertedDoubleNumber()!)
        } else if p1.isStringValue {
            if let value: Double = Double(p1.asString()!) {
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
        return FunctionCDBL.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionCDBL.symbolFunction
    }

}
