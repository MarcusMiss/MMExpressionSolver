//
//  FunctionLTRIM.swift
//  MMExpressionSolver
//

import Foundation
import MMEcletic

/// Function LTRIM()
///
/// Implementation of expression-function `LTRIM()`.
///
/// The LTRIM() function removes all leading spaces (or optionally other specified characters, depending on the system) from the left side of a string.
///
/// ```
/// LTRIM(text: string) -> string
///
/// LTRIM(nil) -> nil
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionLTRIM: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "LTRIM"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionLTRIM") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionLTRIM.symbolFunction,
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
            return ExpressionValue.of(FunctionLTRIM.LTRIM(p1.asString()!))
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameText,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionLTRIM.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionLTRIM.symbolFunction
    }

    // MARK: - API

    public static func LTRIM(_ text: String) -> String {
        return  text.trimLeft()
    }

}
