//
//  FunctionRIGHT.swift
//  MMExpressionSolver
//

import Foundation

/// Function RIGHT()
///
/// Implementation of expression-function `RIGHT()`.
///
/// The RIGHT() function returns a substring consisting of the rightmost characters from a given string, based on a specified length.
///
/// ```
/// RIGHT(text: string, numChars: integer) -> string
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionRIGHT: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "RIGHT"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionRIGHT") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionRIGHT.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameText,
                                        strictTypes: [.string, .null]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameNumChars,
                                        strictTypes: [.int])
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        let p2: ExpressionValue = arguments[1]
        if p1.type == .null || p2.type == .null {
            return ExpressionValue.ofNil()
        } else if p1.type == .string && p2.isIntegerValue {
            return ExpressionValue.of(FunctionRIGHT.RIGHT(p1.asString()!, p2.asInteger()!))
        } else {
            if p1.type != .string {
                throw ExpressionError.invalidParameterType(token: functionToken,
                                                           funcName: definition.name,
                                                           paramName: ExpressionFunctionParameter.nameText,
                                                           value: p1.asStringForError())
            } else {
                throw ExpressionError.invalidParameterType(token: functionToken,
                                                           funcName: definition.name,
                                                           paramName: ExpressionFunctionParameter.nameNumChars,
                                                           value: p2.asStringForError())
            }
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionRIGHT.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionRIGHT.symbolFunction
    }

    // MARK: - API

    public static func RIGHT(_ text: String, _ numChars: Int) -> String {
        if text.count == 0 || numChars <= 0 {
            return ""
        } else if numChars >= text.count {
            return text
        }
        let range: Range = text.index(text.endIndex, offsetBy: -numChars)..<text.index(text.endIndex, offsetBy: 0)
        return String(text[range])
    }

}
