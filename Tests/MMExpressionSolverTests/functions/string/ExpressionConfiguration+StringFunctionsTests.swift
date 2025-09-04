//
//  ExpressionConfigurationTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionConfiguration String functions")
class ExpressionConfigurationStringFunctionTests {

    @Test("Validation of ExpressionConfiguration.setupStringFunctions")
    func setupStringFunctions() async throws {
        let funcs: [any ExpressionFunction] = ExpressionConfiguration.setupStringFunctions()
        #expect(funcs.count == 16)
    }

}
