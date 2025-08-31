//
//  OperatorIdentifierTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("OperatorIdentifier")
class OperatorIdentifierTests {

    @Test("OperatorIdentifier")
    func validateInitialiation() async throws {
        let oid: OperatorIdentifier = OperatorIdentifier("foo")
        #expect(oid.id == "foo")
        print("\(oid.description)")
        print("\(oid.debugDescription)")
        #expect(oid.description == "id:'foo'")
        #expect(oid.debugDescription == "OperatorIdentifier(id:'foo')")
        
        #expect(oid == OperatorIdentifier("foo"))
    }

}
