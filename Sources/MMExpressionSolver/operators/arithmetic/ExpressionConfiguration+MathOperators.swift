//
//  ExpressionConfiguration+MathOperators.swift
//  MMExpressionSolver
//

import Foundation

public extension ExpressionConfiguration {

    static func setupArithmeticOperators() -> [any ExpressionOperator] {
        return [
            // Infix-math-operators
            InfixOperatorMultiply(),
            InfixOperatorDivide(),
            InfixOperatorPlus(),
            InfixOperatorMinus(),
            // Prefix-math-operators
            PrefixOperatorPlus(),
            PrefixOperatorMinus()
        ]
    }

}
