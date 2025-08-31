//
//  PrefixOperatorNotTests.swift
//  MMExpressionSolver
//

import Testing

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("PrefixOperator NOT")
class PrefixOperatorNOTTests {

    @Test("Operator + definition")
    func operatorDefinition() async throws {
        let op: PrefixOperatorNot = PrefixOperatorNot()
        #expect(op.id == OperatorIdentifier("PrefixOperatorNot"))
        #expect(op.symbols == ["!", "NOT"])
        #expect(op.definition.type == .prefix)
        #expect(op.definition.precedence == .additive)
        #expect(op.definition.isLeftAssociative == true)
        #expect(op.definition.isLazy == false)
        #expect(op.description.isEmpty == false)
        #expect(op.debugDescription.isEmpty == false)
    }

    @Test("Operator ! evaluation")
    func evaluateOperator() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: PrefixOperatorNot = PrefixOperatorNot()
        var result: ExpressionValue = ExpressionValue.ofNil()
        // 01: +nil = nil
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.ofNil()
        ])
        print("01:result=\(result)")
        try #require(result.isNullValue == true)
        // 02: !(true) = false (bool)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(true)
        ])
        print("02:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == false)
        // 03: !(false) = true (bool)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(false)
        ])
        print("03:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == true)
    }

    @Test("Operator ! evaluation to fail")
    func evaluateOperatorToFail() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: PrefixOperatorNot = PrefixOperatorNot()
        // 01: operator is invalid
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments:
                [ExpressionValue.of("X")])
        }
        print("01:error=\(String(describing: error1))")
    }

}
