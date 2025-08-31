//
//  InfixOperatorDivideTests.swift
//  MMExpressionSolver
//

import Testing

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("InfixOperatorDivide")
class InfixOperatorDivideTests {

    @Test("Operator / definition")
    func operatorDefinition() async throws {
        let op: InfixOperatorDivide = InfixOperatorDivide()
        #expect(op.id == OperatorIdentifier("InfixOperatorDivide"))
        #expect(op.symbols == ["/"])
        #expect(op.definition.type == .infix)
        #expect(op.definition.precedence == .multiplicative)
        #expect(op.definition.isLeftAssociative == true)
        #expect(op.definition.isLazy == false)
        #expect(op.description.isEmpty == false)
        #expect(op.debugDescription.isEmpty == false)
    }

    @Test("Operator / evaluation")
    func evaluateOperator() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: InfixOperatorDivide = InfixOperatorDivide()
        var result: ExpressionValue = ExpressionValue.ofNil()
        // 01: nil * 20 = nil (nil/int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.ofNil(), ExpressionValue.of(20)
        ])
        print("01:result=\(result)")
        try #require(result.isNullValue == true)
        // 02: 15 * nil = nil (int/nil)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(15), ExpressionValue.ofNil()
        ])
        print("02:result=\(result)")
        try #require(result.isNullValue == true)
        // 03: 300 / 20 = 15 (int/int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(300), ExpressionValue.of(20)
        ])
        print("03:result=\(result)")
        try #require(result.isIntegerValue == true)
        try #require(result.asInteger() == 15)

        // 04: 300 / 20 = 15 (decimal/decimal)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Decimal(300)), ExpressionValue.of(Decimal(20))
        ])
        print("04:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(15))

        // 05: 300 / 20 = 15 (decimal/int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Decimal(300)), ExpressionValue.of(20)
        ])
        print("05:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(15))
        // 06: 300 / 20 = 15 (int/decimal)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(300), ExpressionValue.of(Decimal(20))
        ])
        print("06:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(15))
    }

    @Test("Operator 7 evaluation to fail")
    func evaluateOperatorToFail() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: InfixOperatorDivide = InfixOperatorDivide()
        // 01: Left operator is invalid
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [ExpressionValue.of(true), ExpressionValue.of(200)])
        }
        print("01:error=\(String(describing: error1))")
        // 02: right operator is invalid
        let error2: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [ExpressionValue.of(100), ExpressionValue.of(true)])
        }
        print("02:error=\(String(describing: error2))")
        // 03: right operator is invalid (division zero)
        let error3: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [ExpressionValue.of(200), ExpressionValue.of(0)])
        }
        print("03:error=\(String(describing: error3))")
        // 04: right operator is invalid (division zero)
        let error4: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [ExpressionValue.of(200), ExpressionValue.of(Decimal(0))])
        }
        print("04:error=\(String(describing: error4))")
    }

}
