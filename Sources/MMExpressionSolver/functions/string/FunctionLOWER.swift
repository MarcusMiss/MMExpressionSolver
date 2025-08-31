//
//  FunctionLOWER.swift
//  MMExpressionSolver
//

import Foundation

/// Function LOWER()
///
/// Implementation of expression-function `LOWER()`.
///
/// The LOWER() function converts all alphabetic characters in a string to their lowercase form.
/// Non-alphabetic characters (digits, symbols, spaces) remain unchanged.
///
/// ```
/// LOWER(text: string) -> string
///
/// LOWER(nil) -> nil
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionLOWER: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "LOWER"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionLOWER") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionLOWER.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameText,
                                        strictTypes: [.string, .null])
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.type == .null {
            return ExpressionValue.ofNil()
        } else if p1.type == .string {
            return ExpressionValue.of(FunctionLOWER.LOWER(p1.asString()!))
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameText,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionLOWER.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionLOWER.symbolFunction
    }

    // MARK: - API

    public static func LOWER(_ text: String) -> String {
        return  text.lowercased()
    }

}
