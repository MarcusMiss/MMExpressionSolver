//
//  ExpressionConfiguration+MathOperatorsTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionConfiguration Math operators")
class ExpressionConfigurationMatOperatorsTests {

    @Test("Validation of ExpressionConfiguration.setupArithmeticOperators")
    func setupArithmeticOperators() async throws {
        let funcs: [any ExpressionOperator] = ExpressionConfiguration.setupArithmeticOperators()
        #expect(funcs.count == 6)
    }

}
