//
//  ExpressionOperatorRepositoryImplTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionOperatorRepositoryImpl")
class ExpressionOperatorRepositoryImplTests {

    @Test("Validation of operator-specific storage")
    func findOperatorListByType() async throws {
        let repo: ExpressionOperatorRepositoryImpl = ExpressionOperatorRepositoryImpl([])
        #expect(repo.findOperatorListByType(.prefix).type == .prefix)
        #expect(repo.findOperatorListByType(.postfix).type == .postfix)
        #expect(repo.findOperatorListByType(.infix).type == .infix)
    }

    @Test("Validation of empty repository")
    func standardOperatorRepositoryEmpty() async throws {
        let repo: ExpressionOperatorRepositoryImpl = ExpressionOperatorRepositoryImpl([])
        #expect(repo.hasPrefixOperator("foo") == false)
        #expect(repo.hasInfixOperator("foo") == false)
        #expect(repo.hasPostfixOperator("foo") == false)
        #expect(repo.findPrefixOperatorId("foo") == nil)
        #expect(repo.findInfixOperatorId("foo") == nil)
        #expect(repo.findPostfixOperatorId("foo") == nil)
    }

    @Test("Validation of repository (1 op)")
    func standardOperatorRepository1() async throws {
        let repo: ExpressionOperatorRepositoryImpl = ExpressionOperatorRepositoryImpl([
           InfixOperatorPlus()
        ])
        #expect(repo.hasInfixOperator("+") == true)
        #expect(repo.hasInfixOperator("-") == false)
    }

    @Test("Validation of repository (2 op's)")
    func standardOperatorRepository2() async throws {
        let repo: ExpressionOperatorRepositoryImpl = ExpressionOperatorRepositoryImpl([
            InfixOperatorPlus(),
            InfixOperatorMinus()
        ])
        #expect(repo.hasInfixOperator("+") == true)
        #expect(repo.hasInfixOperator("-") == true)
        #expect(repo.hasInfixOperator("/") == false)
        
        let idPlus: Optional<OperatorIdentifier> = repo.findInfixOperatorId("+")
        #expect(idPlus.isPresent)
        print("idPlus=\(String(describing: idPlus))")
        let opPlus: Optional<any ExpressionOperator> = repo.findOperator(idPlus!)
        #expect(opPlus.isPresent)
        print("opPlus=\(String(describing: opPlus))")
    }

    @Test("Validation of findOperatorBySymbol(),findOperatorBySymbol() and findOperator()")
    func findOperators() async throws {
        let repo: ExpressionOperatorRepositoryImpl = ExpressionOperatorRepositoryImpl([
            FakePrefixOperator(),
            FakePostfixOperator(),
            FakeInfixOperator()
        ])
        let op1: Optional<OperatorIdentifier> = repo.findOperatorBySymbol(symbol: "@") // prefix
        #expect(op1.isPresent == true)
        let op2: Optional<OperatorIdentifier> = repo.findOperatorBySymbol(symbol: "#") // postfix
        #expect(op2.isPresent == true)
        let op3: Optional<OperatorIdentifier> = repo.findOperatorBySymbol(symbol: "&") // infix
        #expect(op3.isPresent == true)
        let op4: Optional<OperatorIdentifier> = repo.findOperatorBySymbol(symbol: "+") // unknown
        #expect(op4.isPresent == false)

        #expect(repo.findOperator(OperatorIdentifier("FakePrefixOperator")).isPresent == true)
        #expect(repo.findOperator(OperatorIdentifier("FakePostfixOperator")).isPresent == true)
        #expect(repo.findOperator(OperatorIdentifier("FakeInfixOperator")).isPresent == true)
        #expect(repo.findOperator(OperatorIdentifier("Unkown")).isPresent == false)
        #expect(repo.findOperator(nil).isPresent == false)
        #expect(repo.findOperatorById(ident: OperatorIdentifier("FakePrefixOperator")).isPresent == true)
        #expect(repo.findOperatorById(ident: OperatorIdentifier("FakePostfixOperator")).isPresent == true)
        #expect(repo.findOperatorById(ident: OperatorIdentifier("FakeInfixOperator")).isPresent == true)
        #expect(repo.findOperatorById(ident: OperatorIdentifier("Unkown")).isPresent == false)
    }

}
