//
//  InfixOperatorPlus.swift
//  MMExpressionSolver
//

import Foundation

/// Infix-operator _Addition_
///
/// Calculates `value1 + value2`.
///
/// This left-assiciative operator performs Plus-operation for numeric types.
/// In case of String-types a string-concatination will be done.
///
/// When at least one of operands has `nil`-value the result will be `nil`.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class InfixOperatorPlus: ExpressionOperator {

    /// Symbol of this operator
    static let symbolOperator: String = "+"

    // MARK: - Protocol ExpressionOperator

    public var id: OperatorIdentifier { get { OperatorIdentifier("InfixOperatorPlus") } }

    public var definition: ExpressionOperatorDefinition {
        get {
            return ExpressionOperatorDefinition(type: .infix, precedence: .additive, isLeftAssociative: true, isLazy: false)
        }
    }

    public var symbols: [String] { get { [InfixOperatorPlus.symbolOperator] } }

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
                return ExpressionValue.of(Int(p1.asInteger()! + p2.asInteger()!))
            } else {
                return ExpressionValue.of(p1.asConvertedDecimalNumber()! + p2.asConvertedDecimalNumber()!)
            }
        } else if p1.isStringValue && p2.isStringValue {
            return ExpressionValue.of(p1.asString()! + p2.asString()!)
        }
        if !(p1.isNumericValue || p1.isStringValue) {
            throw ExpressionError.nonMatchingOperandLeft(token: operatorToken, value: p1.asStringForError())
        }
        throw ExpressionError.nonMatchingOperandLeft(token: operatorToken, value: p2.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return InfixOperatorPlus.symbolOperator
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "InfixOperatorPlus()"
    }

}
