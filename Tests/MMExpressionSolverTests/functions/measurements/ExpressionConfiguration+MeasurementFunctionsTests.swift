//
//  ExpressionConfiguration+MeasurementFunctionsTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionConfiguration Measurements functions")
class ExpressionConfigurationMeasurementFunctionsTests {

    @Test("Validation of ExpressionConfiguration.setupMeasurementFunctions")
    func setupMeasurementFunctions() async throws {
        let funcs: [any ExpressionFunction] = ExpressionConfiguration.setupMeasurementFunctions()
        #expect(funcs.count == 23)
    }

}
