//
//  FunctionUPPER.swift
//  MMExpressionSolver
//

import Foundation

/// Function UPPER()
///
/// Implementation of expression-function `LOWER()`.
///
/// The UPPER() function converts all alphabetic characters in a string to their uppercase form.
/// Non-alphabetic characters (digits, symbols, spaces) remain unchanged.
///
/// ```
/// LOWER(text: string) -> string
///
/// LOWER(nil) -> nil
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionUPPER: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UPPER"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUPPER") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUPPER.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [.string, .null])
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.isNullValue {
            return ExpressionValue.ofNil()
        } else if p1.isStringValue {
            return ExpressionValue.of(p1.asString()!.uppercased())
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameText,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionUPPER.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUPPER.symbolFunction
    }

}
