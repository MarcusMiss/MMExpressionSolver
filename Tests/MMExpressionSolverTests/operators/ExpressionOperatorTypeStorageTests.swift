//
//  ExpressionOperatorTypeStorageTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionOperatorTypeStorage")
class ExpressionOperatorTypeStorageTests {

    @Test("ExpressionOperatorTypeStorage without operator")
    func operatorTypeStorageEmpt() async throws {
        let repo: ExpressionOperatorTypeStorage = ExpressionOperatorTypeStorage(.infix)
        #expect(repo.findOperatorById(OperatorIdentifier("id")).isPresent == false)
        #expect(repo.findOperatorBySymbol("SYM").isPresent == false)
        #expect(repo.countById == 0)
        #expect(repo.countBySymbol == 0)
    }

    @Test("ExpressionOperatorTypeStorage one operator")
    func operatorTypeStorage1() async throws {
        let repo: ExpressionOperatorTypeStorage = ExpressionOperatorTypeStorage(.infix)
        repo.register(InfixOperatorPlus())
        #expect(repo.findOperatorById(OperatorIdentifier("InfixOperatorPlus")).isPresent == true)
        #expect(repo.findOperatorBySymbol("+").isPresent == true)
        #expect(repo.findOperatorById(OperatorIdentifier("InfixOperatorMinus")).isPresent == false)
        #expect(repo.findOperatorBySymbol("-").isPresent == false)
        #expect(repo.countById == 1)
        #expect(repo.countBySymbol == 1)
    }

    @Test("ExpressionOperatorTypeStorage one operator")
    func operatorTypeStorage2() async throws {
        let repo: ExpressionOperatorTypeStorage = ExpressionOperatorTypeStorage(.infix)
        repo.register(InfixOperatorPlus())
        repo.register(InfixOperatorMinus())
        #expect(repo.findOperatorById(OperatorIdentifier("InfixOperatorMinus")).isPresent == true)
        #expect(repo.findOperatorBySymbol("+").isPresent == true)
        #expect(repo.findOperatorById(OperatorIdentifier("InfixOperatorMinus")).isPresent == true)
        #expect(repo.findOperatorBySymbol("-").isPresent == true)
        #expect(repo.findOperatorById(OperatorIdentifier("InfixOperatorXXX")).isPresent == false)
        #expect(repo.findOperatorBySymbol("/").isPresent == false)
        #expect(repo.countById == 2)
        #expect(repo.countBySymbol == 2)
    }

}
