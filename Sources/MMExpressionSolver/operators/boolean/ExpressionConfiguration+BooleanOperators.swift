//
//  ExpressionConfiguration+BooleanOperators.swift
//  MMExpressionSolver
//

import Foundation

public extension ExpressionConfiguration {

    static func setupBooleanOperators() -> [any ExpressionOperator] {
        return [
            // Infix-boolean-operators
            InfixOperatorAnd(),
            InfixOperatorOr(),
            InfixOperatorXor(),
            InfixOperatorEqual(),
            InfixOperatorEqualGreat(),
            InfixOperatorEqualLess(),
            InfixOperatorGreat(),
            InfixOperatorLess(),
            InfixOperatorNotEqual(),
            // Prefix-boolean-operators
            PrefixOperatorNot()
        ]
    }

}
