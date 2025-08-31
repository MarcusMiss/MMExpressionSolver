//
//  ExpressionEvaluationContextImplTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionEvaluationContextImpl")
class ExpressionEvaluationContextImplTests {

    @Test("Validation of ExpressionEvaluationContextImpl")
    func validate() async throws {
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        #expect(context.variables.count == 0)
    }

}
