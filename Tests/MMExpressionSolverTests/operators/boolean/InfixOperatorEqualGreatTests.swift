//
//  InfixOperatorEqualGreatTests.swift
//  MMExpressionSolver
//

import Testing

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("InfixOperator >=")
class InfixOperatorEqualGreatTests {

    @Test("Operator >= definition")
    func operatorDefinition() async throws {
        let op: InfixOperatorEqualGreat = InfixOperatorEqualGreat()
        #expect(op.id == OperatorIdentifier("InfixOperatorEqualGreat"))
        #expect(op.symbols == [">=", "=>", "≥"])
        #expect(op.definition.type == .infix)
        #expect(op.definition.precedence == .additive)
        #expect(op.definition.isLeftAssociative == true)
        #expect(op.definition.isLazy == false)
        #expect(op.description.isEmpty == false)
        #expect(op.debugDescription.isEmpty == false)
    }

    @Test("Operator >= evaluation")
    func evaluateOperator() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: InfixOperatorEqualGreat = InfixOperatorEqualGreat()
        var result: ExpressionValue = ExpressionValue.ofNil()
        // 01: nil >= nil = true
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.ofNil(), ExpressionValue.ofNil()
        ])
        print("01:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == true)
        // 02: 100 >= nil = false
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(100), ExpressionValue.ofNil()
        ])
        print("02:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == false)
        // 03: nil >= 100 = false
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.ofNil(), ExpressionValue.of(100)
        ])
        print("03:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == false)
        // 04: 200 >= 200 = true (bool)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(200), ExpressionValue.of(200)
        ])
        print("04:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == true)
        // 05: 200 >= 100 = true
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(200), ExpressionValue.of(100)
        ])
        print("05:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == true)
        // 06: 100 >= 200 = false (bool/bool)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(100), ExpressionValue.of(200)
        ])
        print("06:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == false)
    }

}
