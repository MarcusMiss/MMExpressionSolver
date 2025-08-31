//
//  ExpressionFunctionRepositoryImplTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionFunctionRepositoryImpl")
class ExpressionFunctionRepositoryImplTests {

    @Test("Empty function-repository")
    func validateEmptyRepository() async throws {
        let repo: ExpressionFunctionRepositoryImpl = ExpressionFunctionRepositoryImpl([])
        #expect(repo.hasFunction(name: "foo") == false)
        #expect(repo.findFunction(name: "foo").isPresent == false)
        #expect(repo.findFunction(identifier: FunctionIdentifier("foo")).isPresent == false)
        #expect(repo.countBySymbol == 0)
        #expect(repo.countById == 0)
    }

    @Test("Validate function-repository with one function")
    func validateRepository() async throws {
        let repo: ExpressionFunctionRepositoryImpl = ExpressionFunctionRepositoryImpl([
            FunctionABS()
        ])
        #expect(repo.hasFunction(name: "abs") == true)
        #expect(repo.hasFunction(name: "ABS") == true)
        #expect(repo.hasFunction(name: "murks") == false)
        #expect(repo.findFunction(name: "abs").isPresent == true)
        #expect(repo.findFunction(name: "ABS").isPresent == true)
        #expect(repo.findFunction(name: "murks").isPresent == false)
        #expect(repo.findFunction(identifier: FunctionIdentifier("FunctionABS")).isPresent == true)
        #expect(repo.findFunction(identifier: FunctionIdentifier("FunctionMurks")).isPresent == false)
        #expect(repo.findFunction(identifier: Optional.none).isPresent == false)
        #expect(repo.countBySymbol == 1)
        #expect(repo.countById == 1)
    }

}
