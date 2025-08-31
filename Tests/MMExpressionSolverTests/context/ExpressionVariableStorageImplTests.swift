//
//  ExpressionVariableStorageImplTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionVariableStorageImpl")
class ExpressionVariableStorageImplTests {

    @Test("Validation of ExpressionVariableStorageImpl")
    func validate() async throws {
        let storage = ExpressionVariableStorageImpl()
        #expect(storage.count == 0)
        storage.storeVariable(identifier: "foo1", value: ExpressionValue.of("Hello"))
        #expect(storage.count == 1)
        storage.storeVariable(identifier: "foo2", value: ExpressionValue.of("World"))
        #expect(storage.count == 2)
        storage.storeVariable(identifier: "foo2", value: ExpressionValue.of("World!"))
        #expect(storage.count == 2)

        #expect(storage.getVariable(identifier: "foo1").isPresent == true)
        #expect(storage.getVariable(identifier: "foo2").isPresent == true)
        #expect(storage.getVariable(identifier: "foo3").isPresent == false)

        #expect(storage.getVariableNames().count == 2)
    }

}
