//
//  FunctionMID.swift
//  MMExpressionSolver
//

import Foundation

/// Function MID()
///
/// Implementation of expression-function `LEFT()`.
///
/// The MID() function returns a substring from a given text, starting at a specified position and continuing for a specified number of characters.
///
/// ```
/// MID(text: string, start: integer, length: integer) -> string
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionMID: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "MID"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionMID") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionMID.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameText,
                                        strictTypes: [.string, .null]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameStart,
                                        strictTypes: [.int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameLength,
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
        let p3: ExpressionValue = arguments[2]
        if p1.type == .null || p2.type == .null || p3.type == .null {
            return ExpressionValue.ofNil()
        } else if p1.type == .string && p2.isIntegerValue && p3.isIntegerValue {
            return ExpressionValue.of(FunctionMID.MID(p1.asString()!, p2.asInteger()!, p3.asInteger()!))
        } else {
            if p1.type != .string {
                throw ExpressionError.invalidParameterType(token: functionToken,
                                                           funcName: definition.name,
                                                           paramName: ExpressionFunctionParameter.nameText,
                                                           value: p1.asStringForError())
            } else if p2.type != .int {
                throw ExpressionError.invalidParameterType(token: functionToken,
                                                           funcName: definition.name,
                                                           paramName: ExpressionFunctionParameter.nameStart,
                                                           value: p2.asStringForError())
            } else {
                throw ExpressionError.invalidParameterType(token: functionToken,
                                                           funcName: definition.name,
                                                           paramName: ExpressionFunctionParameter.nameLength,
                                                           value: p3.asStringForError())
            }
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionMID.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionMID.symbolFunction
    }

    // MARK: - API

    public static func MID(_ text: String, _ start: Int, _ length: Int) -> String {
        if text.count == 0 || start <= 0 || length <= 0 || start > text.count {
            return ""
        }
        if start + length >= text.count {
            return String(text[text.index(text.startIndex, offsetBy: start - 1)..<text.endIndex])
        }
        return String(text[text.index(text.startIndex, offsetBy: start - 1)..<text.index(text.startIndex, offsetBy: (start - 1) + length)])
    }

}
