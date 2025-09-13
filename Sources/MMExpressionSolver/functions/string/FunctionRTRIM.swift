//
//  FunctionRTRIM.swift
//  MMExpressionSolver
//

import Foundation
import MMEcletic

/// Function RTRIM()
///
/// Implementation of expression-function `RTRIM()`.
///
/// The RTRIM() function removes all trailing spaces (or optionally other specified characters, depending on the system) from the right side of a string.
///
/// ```
/// RTRIM(text: string) -> string
///
/// RTRIM(nil) -> nil
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionRTRIM: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "RTRIM"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionRTRIM") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionRTRIM.symbolFunction,
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
            return ExpressionValue.of(FunctionRTRIM.RTRIM(p1.asString()!))
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameText,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionRTRIM.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionRTRIM.symbolFunction
    }

    // MARK: - API

    public static func RTRIM(_ text: String) -> String {
        return  text.trimRight()
    }

}

