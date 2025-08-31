//
//  MockOperators.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

class FakePrefixOperator: ExpressionOperator {
    var description: String = "FakePrefixOperator"
    var debugDescription: String = "debugDescription"
    var definition: ExpressionOperatorDefinition = ExpressionOperatorDefinition(type: .prefix,
                                                                                precedence: .additive,
                                                                                isLeftAssociative: true,
                                                                                isLazy: false)
    var symbols: [String] = ["@", "PREFIX"]
    var id: OperatorIdentifier = OperatorIdentifier("FakePrefixOperator")

    func evaluateOperator(context: any ExpressionEvaluationContext,
                          operatorToken: Token,
                          arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        return ExpressionValue.ofNil()
    }
}

class FakePostfixOperator: ExpressionOperator {
    var description: String = "FakePostfixOperator"
    var debugDescription: String = "FakePostfixOperator"
    var definition: ExpressionOperatorDefinition = ExpressionOperatorDefinition(type: .postfix,
                                                                                precedence: .additive,
                                                                                isLeftAssociative: true,
                                                                                isLazy: false)
    var symbols: [String] = ["#", "POSTFIX"]
    var id: OperatorIdentifier = OperatorIdentifier("FakePostfixOperator")

    func evaluateOperator(context: any ExpressionEvaluationContext,
                          operatorToken: Token,
                          arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        return ExpressionValue.ofNil()
    }
}

class FakeInfixOperator: ExpressionOperator {
    var description: String = "FakeInfixOperator"
    var debugDescription: String = "FakeInfixOperator"
    var definition: ExpressionOperatorDefinition = ExpressionOperatorDefinition(type: .infix,
                                                                                precedence: .additive,
                                                                                isLeftAssociative: true,
                                                                                isLazy: false)
    var symbols: [String] = ["&", "INFIX"]
    var id: OperatorIdentifier = OperatorIdentifier("FakeInfixOperator")

    func evaluateOperator(context: any ExpressionEvaluationContext,
                          operatorToken: Token,
                          arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        return ExpressionValue.ofNil()
    }
}

