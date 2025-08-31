//
//  ExpressionConfiguration+MathFunctionsTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionConfiguration Math functions")
class ExpressionConfigurationMathFunctionTests {

    @Test("Validation of ExpressionConfiguration.setupMathFunctions")
    func setupStringFunctions() async throws {
        let funcs: [any ExpressionFunction] = ExpressionConfiguration.setupMathFunctions()
        #expect(funcs.count == 12)
    }

}
