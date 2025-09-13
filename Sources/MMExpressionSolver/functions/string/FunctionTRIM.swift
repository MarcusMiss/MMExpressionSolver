//
//  FunctionTRIM.swift
//  MMExpressionSolver
//

import Foundation
import MMEcletic

/// Function TRIM()
///
/// Implementation of expression-function `TRIM()`.
///
/// The TRIM() function removes leading and trailing spaces (or optionally other specified characters, depending on the system) from a string.
/// It is essentially a combination of LTRIM() and RTRIM().
///
/// ```
/// TRIM(text: string) -> string
///
/// TRIM(nil) -> nil
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionTRIM: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "TRIM"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionTRIM") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionTRIM.symbolFunction,
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
            return ExpressionValue.of(FunctionTRIM.TRIM(p1.asString()!))
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameText,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionTRIM.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionTRIM.symbolFunction
    }

    
    // MARK: - API

    public static func TRIM(_ text: String) -> String {
        return  text.trim()
    }

}
