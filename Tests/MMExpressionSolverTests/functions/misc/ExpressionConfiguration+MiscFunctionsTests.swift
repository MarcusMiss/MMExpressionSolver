//
//  ExpressionConfiguration+MiscFunctionsTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionConfiguration Misc functions")
class ExpressionConfigurationMiscFunctionTests {

    @Test("Validation of ExpressionConfiguration.setupMiscFunctions")
    func setupStringFunctions() async throws {
        let funcs: [any ExpressionFunction] = ExpressionConfiguration.setupMiscFunctions()
        #expect(funcs.count == 4)
    }

}
