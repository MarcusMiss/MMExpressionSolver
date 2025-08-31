//
//  InfixOperatorMinusTests.swift
//  MMExpressionSolver
//

import Testing

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("InfixOperatorMinus")
class InfixOperatorMinusTests {

    @Test("Operator - definition")
    func operatorDefinition() async throws {
        let op: InfixOperatorMinus = InfixOperatorMinus()
        #expect(op.id == OperatorIdentifier("InfixOperatorMinus"))
        #expect(op.symbols == ["-"])
        #expect(op.definition.type == .infix)
        #expect(op.definition.precedence == .additive)
        #expect(op.definition.isLeftAssociative == true)
        #expect(op.definition.isLazy == false)
        #expect(op.description.isEmpty == false)
        #expect(op.debugDescription.isEmpty == false)
    }

    @Test("Operator - evaluation")
    func evaluateOperator() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: InfixOperatorMinus = InfixOperatorMinus()
        var result: ExpressionValue = ExpressionValue.ofNil()
        // 01: nil - 200 = nil (nil/int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.ofNil(), ExpressionValue.of(200)
        ])
        print("01:result=\(result)")
        try #require(result.isNullValue == true)
        // 02: 300 - nil = nil (int/nil)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(300), ExpressionValue.ofNil()
        ])
        print("02:result=\(result)")
        try #require(result.isNullValue == true)
        // 03: 300 - 200 = 100 (int/int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(300), ExpressionValue.of(200)
        ])
        print("03:result=\(result)")
        try #require(result.isIntegerValue == true)
        try #require(result.asInteger() == 100)
        // 04: 300 - 200 = 100 (decimal/decimal))
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Decimal(300)), ExpressionValue.of(Decimal(200))
        ])
        print("04:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(100))
        // 05: 300 - 200 = 100 (decimal/int))
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Decimal(300)), ExpressionValue.of(200)
        ])
        print("05:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(100))
        //0 6: 300 - 200 = 100 (int/decimal))
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(300), ExpressionValue.of(Decimal(200))
        ])
        print("06:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(100))
    }

    @Test("Operator - evaluation to fail")
    func evaluateOperatorToFail() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: InfixOperatorMinus = InfixOperatorMinus()
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
    }

}
