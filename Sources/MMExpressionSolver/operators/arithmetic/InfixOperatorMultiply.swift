//
//  InfixOperatorMultiply.swift
//  MMExpressionSolver
//

import Foundation

/// Infix-operator _Multiplication_
///
/// Calculates `value1 * value2`.
///
/// This left-assiciative operator performs multiplication-operation for numeric types.
///
/// When at least one of operands has `nil`-value the result will be `nil`.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class InfixOperatorMultiply: ExpressionOperator {

    /// Symbol of this operator
    static let symbolOperator: String = "*"

    // MARK: - Protocol ExpressionOperator

    public static let operatorId = OperatorIdentifier("InfixOperatorMultiply")

    public var id: OperatorIdentifier { get { InfixOperatorMultiply.operatorId } }

    public var definition: ExpressionOperatorDefinition {
        get {
            return ExpressionOperatorDefinition(type: .infix, precedence: .multiplicative, isLeftAssociative: true, isLazy: false)
        }
    }

    public var symbols: [String] { get { [InfixOperatorMultiply.symbolOperator] } }

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
        if p1.isNumericValue && p2.isNumericValue {
            if p1.isIntegerValue && p2.isIntegerValue {
                return ExpressionValue.of(Int(p1.asInteger()! * p2.asInteger()!))
            } else {
                return ExpressionValue.of(p1.asConvertedDecimalNumber()! * p2.asConvertedDecimalNumber()!)
            }
        }
        if !p1.isNumericValue {
            throw ExpressionError.nonMatchingOperandLeft(token: operatorToken, value: p1.asStringForError())
        }
        throw ExpressionError.nonMatchingOperandLeft(token: operatorToken, value: p2.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return InfixOperatorMultiply.symbolOperator
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "InfixOperatorMultiply()"
    }

}
