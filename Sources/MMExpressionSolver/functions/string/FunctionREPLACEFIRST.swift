//
//  FunctionREPLACEFIRST.swift
//  MMExpressionSolver
//

import Foundation

/// Function REPLACEFIRST()
///
/// Implementation of expression-function `REPLACEFIRST()`.
///
/// Replace first occurence of a specific pattern in given text.
///
/// ```
/// REPLACEFIRST(text: string, pattern: string, replacement: string) -> string
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionREPLACEFIRST: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "REPLACEFIRST"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionREPLACEFIRST") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionREPLACEFIRST.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameText, strictTypes: [.string, .null]),
            ExpressionFunctionParameter(name: "pattern", strictTypes: [.string]),
            ExpressionFunctionParameter(name: "replacement", strictTypes: [.string]),
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
        if !p2.isStringValue {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameText,
                                                       value: p2.asStringForError())
        }
        if !p3.isStringValue {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameText,
                                                       value: p3.asStringForError())
        }
        if p1.isNullValue {
            return ExpressionValue.ofNil()
        }
        if !p1.isStringValue {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameText,
                                                       value: p1.asStringForError())
        }
        return ExpressionValue.of(FunctionREPLACEFIRST.replaceFirst(p1.asString()!, p2.asString()!, p3.asString()!))
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionREPLACEFIRST.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionREPLACEFIRST.symbolFunction
    }

    // MARK: - API

    public static func replaceFirst(_ text: String, _ pattern: String, _ replacement: String) -> String {
        return text.replaceFirst(pattern, replacement)
    }

}
