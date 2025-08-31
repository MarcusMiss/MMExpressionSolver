//
//  FunctionLEFT.swift
//  MMExpressionSolver
//

import Foundation

/// Function LEFT()
///
/// Implementation of expression-function `LEFT()`.
///
/// The LEFT() function returns a substring consisting of the leftmost characters from a given string, based on a specified length.
///
/// ```
/// LEFT(text: string, numChars: integer) -> string
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionLEFT: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "LEFT"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionLEFT") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionLEFT.symbolFunction,
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
            return ExpressionValue.of(FunctionLEFT.LEFT(p1.asString()!, p2.asInteger()!))
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
        return FunctionLEFT.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionLEFT.symbolFunction
    }

    // MARK: - API

    public static func LEFT(_ text: String, _ numChars: Int) -> String {
        if text.count == 0 || numChars <= 0 {
            return ""
        } else if numChars >= text.count {
            return text
        }
        let range: Range = text.index(text.startIndex, offsetBy: 0)..<text.index(text.startIndex, offsetBy: numChars)
        return String(text[range])
    }

}
