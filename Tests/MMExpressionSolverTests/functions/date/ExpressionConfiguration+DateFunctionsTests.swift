//
//  ExpressionConfiguration+DateFunctionsTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionConfiguration Date functions")
class ExpressionConfigurationDateFunctionTests {

    @Test("Validation of ExpressionConfiguration.setupDateFunctions")
    func setupStringFunctions() async throws {
        let funcs: [any ExpressionFunction] = ExpressionConfiguration.setupDateFunctions()
        #expect(funcs.count == 1)
    }

}
