//
//  FunctionTRIMPOSTFIX.swift
//  MMExpressionSolver
//

import Foundation

/// Function TRIMPOSTFIX()
///
/// Implementation of expression-function `TRIMPOSTFIX()`.
///
/// The TRIMPOSTFIX() function removes a postfix from given text if present.
///
/// ```
/// TRIMPOSTFIX(text: string, pattern: text) -> string
/// ```
///
/// ### Sample
///
/// ```
/// TRIMPOSTFIX("Lorem Ipsum", "Ipsum")
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>.
public final class FunctionTRIMPOSTFIX: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "TRIMPOSTFIX"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionTRIMPOSTFIX") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionTRIMPOSTFIX.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameText,
                                        strictTypes: [.string, .null]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.namePattern,
                                        strictTypes: [.string])
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        let p2: ExpressionValue = arguments[1]
        if p1.type == .null {
            return ExpressionValue.ofNil()
        } else if p1.type == .string && p2.type == .string {
            return ExpressionValue.of(FunctionTRIMPOSTFIX.TRIMPOSTFIX(p1.asString()!, p2.asString()!))
        }
        if !p1.isStringValue {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameText,
                                                       value: p1.asStringForError())
        }
        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                   funcName: definition.name,
                                                   paramName: ExpressionFunctionParameter.namePattern,
                                                   value: p2.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionTRIMPOSTFIX.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionTRIMPOSTFIX.symbolFunction
    }

    // MARK: - API

    public static func TRIMPOSTFIX(_ text: String, _ pattern: String) -> String {
        if !text.hasSuffix(pattern) {
            return text
        }
        let range: Range = text.index(text.startIndex, offsetBy: 0)..<text.index(text.endIndex, offsetBy: -pattern.count)
        return String(text[range])
    }

}
