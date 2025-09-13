//
//  FunctionHASPREFIX.swift
//  MMExpressionSolver
//

import Foundation

/// Function HASPREFIX()
///
/// Implementation of expression-function `HASPREFIX()`.
///
/// The HASPREFIX() function checks if text as given prefix.
///
/// ```
/// HASPREFIX(text: string, pattern: text) -> bool
/// ```
///
/// ### Sample
///
/// ```
/// HASPREFIX("Lorem Ipsum", "Lorem")
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionHASPREFIX: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "HASPREFIX"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionHASPREFIX") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionHASPREFIX.symbolFunction,
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
            return ExpressionValue.of(false)
        } else if p1.type == .string && p2.type == .string {
            return ExpressionValue.of(p1.asString()!.hasPrefix(p2.asString()!))
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
        return FunctionHASPREFIX.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionHASPREFIX.symbolFunction
    }

}
