//
//  ExpressionConfiguration+TrigonometryFuntionsTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionConfiguration Trigonometry functions")
class ExpressionConfigurationTrigonometryFunctionTests {

    @Test("Validation of ExpressionConfiguration.setupTrigonometryFunctions")
    func setupStringFunctions() async throws {
        let funcs: [any ExpressionFunction] = ExpressionConfiguration.setupTrigonometryFunctions()
        #expect(funcs.count == 27)
    }

}
