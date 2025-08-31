//
//  InfixOperatorXor.swift
//  MMExpressionSolver
//

import Foundation
import MMEcletic

/// Infix-operator _XOR_
///
/// Calculates `value1 ^ value2`.
///
/// This left-assiciative operator performs XOR-operation for boolean types.
///
/// When at least one of operands has `nil`-value the result will be `nil`.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class InfixOperatorXor: ExpressionOperator {

    /// Symbol of this operator
    static let symbolOperator: String = "^"

    // MARK: - Protocol ExpressionOperator

    public var id: OperatorIdentifier { get { OperatorIdentifier("InfixOperatorXor") } }

    public var definition: ExpressionOperatorDefinition {
        get {
            return ExpressionOperatorDefinition(type: .infix, precedence: .additive, isLeftAssociative: true, isLazy: false)
        }
    }

    public var symbols: [String] { get { [InfixOperatorXor.symbolOperator , "XOR"] } }

    public func evaluateOperator(context: any ExpressionEvaluationContext,
                                 operatorToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        // Check arguments
        let p1: ExpressionValue = arguments[0]
        let p2: ExpressionValue = arguments[1]
        if p1.isNullValue || p2.isNullValue {
            return ExpressionValue.ofNil()
        }
        // Process operator
        if p1.isBooleanValue && p2.isBooleanValue {
            let lhs: Bool = p1.asBoolean()!
            let rhs: Bool = p2.asBoolean()!
            return ExpressionValue.of(lhs ^ rhs)
        }
        if !p1.isBooleanValue {
            throw ExpressionError.nonMatchingOperandLeft(token: operatorToken, value: p1.asStringForError())
        }
        throw ExpressionError.nonMatchingOperandLeft(token: operatorToken, value: p2.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return InfixOperatorOr.symbolOperator
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "InfixOperatorXor()"
    }

}
