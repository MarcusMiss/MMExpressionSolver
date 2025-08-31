//
//  PrefixOperatorNot.swift
//  MMExpressionSolver
//

import Foundation

/// Prefix-operator _NOT_
///
/// Calculates `!value`.
///
/// This operator negates vale of given boolean value.
///
/// In case of `nil`-value the result will be `nil`.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class PrefixOperatorNot: ExpressionOperator {

    /// Symbol of this operator
    static let symbolOperator: String = "!"

    // MARK: - Protocol ExpressionOperator

    public var id: OperatorIdentifier { get { OperatorIdentifier("PrefixOperatorNot") } }

    public var definition: ExpressionOperatorDefinition {
        get {
            return ExpressionOperatorDefinition(type: .prefix, precedence: .additive, isLeftAssociative: true, isLazy: false)
        }
    }

    public var symbols: [String] { get { [PrefixOperatorNot.symbolOperator, "NOT"] } }

    public func evaluateOperator(context: any ExpressionEvaluationContext,
                                 operatorToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.type == .null {
            return ExpressionValue.ofNil()
        } else if p1.type == .boolean {
            return ExpressionValue.of(!(p1.asBoolean()!))
        } else {
            throw ExpressionError.nonMatchingOperandLeft(token: operatorToken, value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return PrefixOperatorNot.symbolOperator
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "PrefixOperatorNot()"
    }

}
