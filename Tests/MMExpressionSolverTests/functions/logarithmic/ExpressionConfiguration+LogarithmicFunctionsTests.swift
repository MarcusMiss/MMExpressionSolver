//
//  ExpressionConfiguration+LogarithmicFunctionsTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionConfiguration Logarithmic functions")
class ExpressionConfigurationLogarithmicFunctionTests {

    @Test("Validation of ExpressionConfiguration.setupLogarithmicFunctions")
    func setupStringFunctions() async throws {
        let funcs: [any ExpressionFunction] = ExpressionConfiguration.setupLogarithmicFunctions()
        #expect(funcs.count == 4)
    }

}
