//
//  ExpressionConfiguration+BooleanOperatorsTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionConfiguration Boolean operators")
class ExpressionConfigurationBooleanOperatorsTests {

    @Test("Validation of ExpressionConfiguration.setupBooleanOperators")
    func setupBooleanOperators() async throws {
        let funcs: [any ExpressionOperator] = ExpressionConfiguration.setupBooleanOperators()
        #expect(funcs.count == 10)
    }

}
