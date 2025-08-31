//
//  TokenTypeTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("TokenType")
class TokenTypeTests {

    @Test func validateEnums() async throws {
        #expect(TokenType.allCases.count == 15)
    }

}
