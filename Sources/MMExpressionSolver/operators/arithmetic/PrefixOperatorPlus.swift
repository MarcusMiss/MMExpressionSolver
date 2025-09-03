//
//  PrefixOperatorPlus.swift
//  MMExpressionSolver
//

import Foundation

/// Prefix-operator _Plus_
///
/// Calculates `+value`.
///
/// This operator magnitude of given value.
///
/// In case of `nil`-value the result will be `nil`.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class PrefixOperatorPlus: ExpressionOperator {

    /// Symbol of this operator
    static let symbolOperator: String = "+"

    // MARK: - Protocol ExpressionOperator

    public var id: OperatorIdentifier { get { OperatorIdentifier("PrefixOperatorPlus") } }

    public var definition: ExpressionOperatorDefinition {
        get {
            return ExpressionOperatorDefinition(type: .prefix, precedence: .unary, isLeftAssociative: false, isLazy: false)
        }
    }

    public var symbols: [String] { get { [PrefixOperatorPlus.symbolOperator] } }

    public func evaluateOperator(context: any ExpressionEvaluationContext,
                                 operatorToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.isNullValue {
            return ExpressionValue.ofNil()
        } else if p1.isDecimalValue {
            return ExpressionValue.of(p1.asDecimal()!.magnitude)
        } else if p1.isDoubleValue {
            return ExpressionValue.of(p1.asDouble()!.magnitude)
        } else if p1.isFloatValue {
            return ExpressionValue.of(p1.asFloat()!.magnitude)
        } else if p1.isIntegerValue {
            return ExpressionValue.of(Int(p1.asInteger()!.magnitude))
        } else {
            throw ExpressionError.nonMatchingOperand(token: operatorToken, value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return PrefixOperatorPlus.symbolOperator
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "PrefixOperatorPlus()"
    }

}
