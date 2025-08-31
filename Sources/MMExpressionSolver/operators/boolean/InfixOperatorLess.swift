//
//  InfixOperatorLess.swift
//  MMExpressionSolver
//

import Foundation

/// Infix-operator _<_
///
/// Calculates `value1 < value2`.
///
/// This left-assiciative operator performs less operation on given values.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class InfixOperatorLess: ExpressionOperator {

    /// Symbol of this operator
    static let symbolOperator: String = "<"

    // MARK: - Protocol ExpressionOperator

    public var id: OperatorIdentifier { get { OperatorIdentifier("InfixOperatorLess") } }

    public var definition: ExpressionOperatorDefinition {
        get {
            return ExpressionOperatorDefinition(type: .infix, precedence: .additive, isLeftAssociative: true, isLazy: false)
        }
    }

    public var symbols: [String] { get { [InfixOperatorLess.symbolOperator] } }

    public func evaluateOperator(context: any ExpressionEvaluationContext,
                                 operatorToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        // Check arguments
        let p1: ExpressionValue = arguments[0]
        let p2: ExpressionValue = arguments[1]
        // Process operator
        return ExpressionValue.of(p1 < p2)!
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return InfixOperatorLess.symbolOperator
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "InfixOperatorLess()"
    }

}
