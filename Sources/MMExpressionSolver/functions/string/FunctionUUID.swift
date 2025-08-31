//
//  FunctionUUID.swift
//  MMExpressionSolver
//

import Foundation

/// Function UUID()
///
/// Implementation of expression-function `UUID()`.
///
/// The UUID() function create an new UUID and returns it as an string.
///
/// ```
/// UUID() -> string
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionUUID: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UUID"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUUID") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUUID.symbolFunction,
        parameters:[]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        return ExpressionValue.of(UUID.init().uuidString)!
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionUUID.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUUID.symbolFunction
    }

}
