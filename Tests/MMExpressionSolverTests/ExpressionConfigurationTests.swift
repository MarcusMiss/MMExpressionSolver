//
//  ExpressionConfigurationTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionConfiguration")
class ExpressionConfigurationTests {

    @Test("Validate default ExpressionConfiguration")
    func defaultConfigruation() async throws {
        let configuration = ExpressionConfiguration.createDefault()
        #expect(configuration.arraysAllowed == true)
        #expect(configuration.structuresAllowed == true)
        #expect(configuration.functions.count ==
               ExpressionConfiguration.setupMathFunctions().count
                + ExpressionConfiguration.setupTrigonometryFunctions().count
                + ExpressionConfiguration.setupLogarithmicFunctions().count
                + ExpressionConfiguration.setupStringFunctions().count
                + ExpressionConfiguration.setupDateFunctions().count
                + ExpressionConfiguration.setupMiscFunctions().count
                + ExpressionConfiguration.setupConversionFunctions().count)
        print("configuration.functions.count=\(configuration.functions.count)")
    }

}
