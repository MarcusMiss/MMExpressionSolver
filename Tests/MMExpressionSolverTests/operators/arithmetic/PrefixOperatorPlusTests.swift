//
//  PrefixOperatorPlusTests.swift
//  MMExpressionSolver
//

import Testing

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("PrefixOperatorPlus")
class PrefixOperatorPlusTests {

    @Test("Operator + definition")
    func operatorDefinition() async throws {
        let op: PrefixOperatorPlus = PrefixOperatorPlus()
        #expect(op.id == OperatorIdentifier("PrefixOperatorPlus"))
        #expect(op.symbols == ["+"])
        #expect(op.definition.type == .prefix)
        #expect(op.definition.precedence == .unary)
        #expect(op.definition.isLeftAssociative == false)
        #expect(op.definition.isLazy == false)
        #expect(op.description.isEmpty == false)
        #expect(op.debugDescription.isEmpty == false)
    }

    @Test("Operator + evaluation")
    func evaluateOperator() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: PrefixOperatorPlus = PrefixOperatorPlus()
        var result: ExpressionValue = ExpressionValue.ofNil()
        // 01: +nil = nil
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.ofNil()
        ])
        print("01:result=\(result)")
        try #require(result.isNullValue == true)
        // 02: +(+200) = 200 (int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(200)
        ])
        print("02:result=\(result)")
        try #require(result.isIntegerValue == true)
        try #require(result.asInteger() == 200)
        // 03: +(-200) = 200 (int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(-200)
        ])
        print("03:result=\(result)")
        try #require(result.isIntegerValue == true)
        try #require(result.asInteger() == 200)
        // 04: +(-200) = 200 (float)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Float(-200))
        ])
        print("04:result=\(result)")
        try #require(result.isFloatValue == true)
        try #require(result.asFloat() == Float(200))
        // 05: +(-200) = 200 (double)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Double(-200))
        ])
        print("05:result=\(result)")
        try #require(result.isDoubleValue == true)
        try #require(result.asDouble() == Double(200))
        // 06: +(-200) = 200 (decimnal)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Decimal(-200))
        ])
        print("06:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(200))
    }

    @Test("Operator + evaluation to fail")
    func evaluateOperatorToFail() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: PrefixOperatorPlus = PrefixOperatorPlus()
        // 01: operator is invalid
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments:
                [ExpressionValue.of(true)])
        }
        print("01:error=\(String(describing: error1))")
    }

}
