//
//  ExpressionConfiguration+ConversionFunctionsTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionConfiguration Conversion functions")
class ExpressionConfigurationConversionFunctionTests {

    @Test("Validation of ExpressionConfiguration.setupConversionFunctions")
    func setupConversionFunctions() async throws {
        let funcs: [any ExpressionFunction] = ExpressionConfiguration.setupConversionFunctions()
        #expect(funcs.count == 5)
    }

}
