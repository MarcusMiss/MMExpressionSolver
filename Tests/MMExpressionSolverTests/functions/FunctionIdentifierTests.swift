//
//  FunctionIdentifierTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("FunctionIdentifier")
class FunctionIdentifierTests {

    @Test("OperatorIdentifier")
    func validateInitialiation() async throws {
        let oid: FunctionIdentifier = FunctionIdentifier("foo")
        #expect(oid.id == "foo")
        print("\(oid.description)")
        print("\(oid.debugDescription)")
        #expect(oid.description == "id:'foo'")
        #expect(oid.debugDescription == "FunctionIdentifier(id:'foo')")
        
        #expect(oid == FunctionIdentifier("foo"))
    }

}
