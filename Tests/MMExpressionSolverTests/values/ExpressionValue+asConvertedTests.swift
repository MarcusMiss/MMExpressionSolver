//
//  ExpressionValue+asConvertedTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionValue asConverted Tests")
class ExpressionValueAsConvertedTests {
    
    @Test("Validate asConvertedIntegerNumber")
    func asConvertedIntegerNumber() async throws {
        #expect(ExpressionValue.of(Int(100)).asConvertedIntegerNumber() == Int(100))
        #expect(ExpressionValue.of(Float(100.0)).asConvertedIntegerNumber() == Int(100))
        #expect(ExpressionValue.of(Double(100.0)).asConvertedIntegerNumber() == Int(100))
        #expect(ExpressionValue.of(Decimal(100.0)).asConvertedIntegerNumber() == Int(100))
        #expect(ExpressionValue.of("Foo").asConvertedIntegerNumber().isPresent == false)
    }

    @Test("Validate asConvertedDoubleNumber")
    func asConvertedDoubleNumber() async throws {
        #expect(ExpressionValue.of(Int(100)).asConvertedDoubleNumber() == Double(100))
        #expect(ExpressionValue.of(Float(100.0)).asConvertedDoubleNumber() == Double(100))
        #expect(ExpressionValue.of(Double(100.0)).asConvertedDoubleNumber() == Double(100))
        #expect(ExpressionValue.of(Decimal(100.0)).asConvertedDoubleNumber() == Double(100))
        #expect(ExpressionValue.of("Foo").asConvertedDoubleNumber().isPresent == false)
    }

    @Test("Validate asConvertedFloatNumber")
    func asConvertedFloatNumber() async throws {
        #expect(ExpressionValue.of(Int(100)).asConvertedFloatNumber() == Float(100))
        #expect(ExpressionValue.of(Float(100.0)).asConvertedFloatNumber() == Float(100))
        #expect(ExpressionValue.of(Double(100.0)).asConvertedFloatNumber() == Float(100))
        #expect(ExpressionValue.of(Decimal(100.0)).asConvertedFloatNumber() == Float(100))
        #expect(ExpressionValue.of("Foo").asConvertedFloatNumber().isPresent == false)
    }

    @Test("Validate asConvertedDecimalNumber")
    func asConvertedDecimalNumber() async throws {
        #expect(ExpressionValue.of(Int(100)).asConvertedDecimalNumber() == Decimal(100))
        #expect(ExpressionValue.of(Float(100.0)).asConvertedDecimalNumber() == Decimal(100))
        #expect(ExpressionValue.of(Double(100.0)).asConvertedDecimalNumber() == Decimal(100))
        #expect(ExpressionValue.of(Decimal(100.0)).asConvertedDecimalNumber() == Decimal(100))
        #expect(ExpressionValue.of("Foo").asConvertedDecimalNumber().isPresent == false)
    }

}
