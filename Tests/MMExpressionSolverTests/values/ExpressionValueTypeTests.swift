//
//  ExpressionValueTypeTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionValue Tests")
class ExpressionValueTypeTests {
    
    @Test func validateEnums() async throws {
        #expect(ExpressionValueType.allCases.count == 13)

        #expect(ExpressionValueType.string.getTypeName() == "String")
        #expect(ExpressionValueType.double.getTypeName() == "Double")
        #expect(ExpressionValueType.float.getTypeName() == "Float")
        #expect(ExpressionValueType.int.getTypeName() == "Int")
        #expect(ExpressionValueType.decimal.getTypeName() == "Decimal")
        #expect(ExpressionValueType.boolean.getTypeName() == "Bool")
        #expect(ExpressionValueType.datetime.getTypeName() == "Date")
        #expect(ExpressionValueType.array.getTypeName() == "Array")
        #expect(ExpressionValueType.objClass.getTypeName() == "Class")
        #expect(ExpressionValueType.objStruct.getTypeName() == "Struct")
        #expect(ExpressionValueType.tupel.getTypeName() == "Tupel")
        #expect(ExpressionValueType.null.getTypeName() == "Nil")
        #expect(ExpressionValueType.nodeAST.getTypeName() == "AST")
    }
    
}
