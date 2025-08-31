//
//  InfixOperatorAndTests.swift
//  MMExpressionSolver
//

import Testing

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("InfixOperator && (AND)")
class InfixOperatorAndTestsTests {

    @Test("Operator && definition")
    func operatorDefinition() async throws {
        let op: InfixOperatorAnd = InfixOperatorAnd()
        #expect(op.id == OperatorIdentifier("InfixOperatorAnd"))
        #expect(op.symbols == ["&&", "AND"])
        #expect(op.definition.type == .infix)
        #expect(op.definition.precedence == .additive)
        #expect(op.definition.isLeftAssociative == true)
        #expect(op.definition.isLazy == false)
        #expect(op.description.isEmpty == false)
        #expect(op.debugDescription.isEmpty == false)
    }

    @Test("Operator && evaluation")
    func evaluateOperator() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: InfixOperatorAnd = InfixOperatorAnd()
        var result: ExpressionValue = ExpressionValue.ofNil()
        // 01: nil && true = nil (nil/bool)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.ofNil(), ExpressionValue.of(true)
        ])
        print("01:result=\(result)")
        try #require(result.isNullValue == true)
        // 02: true && nil = nil (bool/nil)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(true), ExpressionValue.ofNil()
        ])
        print("02:result=\(result)")
        try #require(result.isNullValue == true)
        // 03: true && true = true (bool/bool)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(true), ExpressionValue.of(true)
        ])
        print("03:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == true)
        // 04: true && false = false (bool/bool)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(true), ExpressionValue.of(false)
        ])
        print("04:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == false)
        // 05: false && true = false (bool/bool)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(false), ExpressionValue.of(true)
        ])
        print("05:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == false)
        // 06: false && false = false (bool/bool)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(false), ExpressionValue.of(false)
        ])
        print("06:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == false)
    }

    @Test("Operator && evaluation to fail")
    func evaluateOperatorToFail() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: InfixOperatorAnd = InfixOperatorAnd()
        // 01: Left operator is invalid
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [ExpressionValue.of(""), ExpressionValue.of(true)])
        }
        print("01:error=\(String(describing: error1))")
        // 02: right operator is invalid
        let error2: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [ExpressionValue.of(false), ExpressionValue.of("")])
            
        }
        print("02:error=\(String(describing: error2))")
    }

}
