//
//  ExpressionValueTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionValue Tests")
class ExpressionValueTests {

    @Test("Validate nil-value")
    func validateNil() async throws {
        let v = ExpressionValue.ofNil()
        #expect(v.type == .null)
        #expect(v.isNumericValue == false)
        #expect(v.isNullValue == true)
        print(v.description)
        print(v.debugDescription)
        print(v.asStringForError())
        #expect((v == ExpressionValue.ofNil()) == true)
        #expect((v != ExpressionValue.ofNil()) == false)
        #expect((v != ExpressionValue.of(1)) == true)
        #expect((v.hashValue != 0) == true)
    }

    @Test("Validate String-value")
    func validateString() async throws {
        let v = ExpressionValue.of("Hello")
        #expect(v.type == .string)
        #expect(v.isNumericValue == false)
        #expect(v.isStringValue == true)
        #expect(v.asString()! == "Hello")
        #expect(v.asInteger().isPresent == false)
        #expect(v.asBoolean().isPresent == false)
        print(v.description)
        print(v.debugDescription)
        print(v.asStringForError())
        #expect((v == ExpressionValue.of("Hello")) == true)
        #expect((v != ExpressionValue.of("Lorem")) == true)
        #expect((v != ExpressionValue.of(1)) == true)
        #expect((v != ExpressionValue.ofNil()) == true)
        #expect((v == ExpressionValue.ofNil()) == false)
        #expect((v.hashValue != 0) == true)
    }

    @Test("Validate Int-value")
    func validateInt() async throws {
        let v = ExpressionValue.of(100)
        #expect(v.type == .int)
        #expect(v.isNumericValue == true)
        #expect(v.isIntegerValue ==  true)
        #expect(v.asInteger()! == 100)
        #expect(v.asDouble().isPresent == false)
        #expect(v.asString().isPresent == false)
        print(v.description)
        print(v.debugDescription)
        print(v.asStringForError())
        #expect((v == ExpressionValue.of(100)) == true)
        #expect((v != ExpressionValue.of(101)) == true)
        #expect((v != ExpressionValue.of(true)) == true)
        #expect((v != ExpressionValue.ofNil()) == true)
        #expect((v == ExpressionValue.ofNil()) == false)
        #expect((v.hashValue != 0) == true)
    }

    @Test("Validate Double-value")
    func validateDouble() async throws {
        let v = ExpressionValue.of(Double(100.0))
        #expect(v.type == .double)
        #expect(v.isNumericValue == true)
        #expect(v.isDoubleValue == true)
        #expect(v.asDouble()! == 100.0)
        #expect(v.asFloat().isPresent == false)
        print(v.description)
        print(v.debugDescription)
        print(v.asStringForError())
        #expect((v == ExpressionValue.of(Double(100))) == true)
        #expect((v != ExpressionValue.of(Double(101))) == true)
        #expect((v != ExpressionValue.of(true)) == true)
        #expect((v.hashValue != 0) == true)
    }

    @Test("Validate Float-value")
    func validateFloat() async throws {
        let v = ExpressionValue.of(Float(100.0))
        #expect(v.type == .float)
        #expect(v.isNumericValue == true)
        #expect(v.isFloatValue == true)
        #expect(v.asFloat()! == 100.0)
        #expect(v.asDecimal().isPresent == false)
        print(v.description)
        print(v.debugDescription)
        print(v.asStringForError())
        #expect((v == ExpressionValue.of(Float(100))) == true)
        #expect((v != ExpressionValue.of(Float(101))) == true)
        #expect((v != ExpressionValue.of(true)) == true)
        #expect((v.hashValue != 0) == true)
    }

    @Test("Validate Bool-value")
    func validateBool() async throws {
        let v = ExpressionValue.of(true)
        #expect(v.type == .boolean)
        #expect(v.isNumericValue == false)
        #expect(v.isBooleanValue == true)
        #expect(v.asBoolean()! == true)
        #expect(v.asArray().isPresent == false)
        print(v.description)
        print(v.debugDescription)
        print(v.asStringForError())
        #expect((v == ExpressionValue.of(true)) == true)
        #expect((v != ExpressionValue.of(false)) == true)
        #expect((v != ExpressionValue.of(Float(100))) == true)
        #expect((v.hashValue != 0) == true)
    }

    @Test("Validate DateTime-value")
    func validateDateTime() async throws {
        let v = ExpressionValue.of(Date.init(timeIntervalSince1970: 0.0))
        #expect(v.type == .datetime)
        #expect(v.isNumericValue == false)
        #expect(v.isDateTime == true)
        #expect(v.asDateTime()! == Date.init(timeIntervalSince1970: 0.0))
        #expect(v.asNode().isPresent == false)
        print(v.description)
        print(v.debugDescription)
        print(v.asStringForError())
        #expect((v == ExpressionValue.of(Date.init(timeIntervalSince1970: 0.0))) == true)
        #expect((v != ExpressionValue.of(Date())) == true)
        #expect((v != ExpressionValue.of(Float(101))) == true)
        #expect((v.hashValue != 0) == true)
    }

    @Test("Validate Decimal-value")
    func validateDecimal() async throws {
        let v = ExpressionValue.of(Decimal(100.0))
        #expect(v.type == .decimal)
        #expect(v.isNumericValue == true)
        #expect(v.isDecimalValue == true)
        #expect(v.asDecimal()! == 100.0)
        #expect(v.asTupel().isPresent == false)
        #expect(v.asDateTime().isPresent == false)
        print(v.description)
        print(v.debugDescription)
        print(v.asStringForError())
        #expect((v == ExpressionValue.of(Decimal(100))) == true)
        #expect((v != ExpressionValue.of(Decimal(101))) == true)
        #expect((v != ExpressionValue.of(true)) == true)
        #expect((v.hashValue != 0) == true)
    }

    @Test("Validate Class-value")
    func validateClass() async throws {
        let v = ExpressionValue.of(FooClazz())!
        #expect(v.type == .objClass)
        #expect(v.isStructureValue == true)
        #expect(v.asObject().isPresent == true)
        #expect(v.asStruct().isPresent == false)
        print(v.description)
        print(v.debugDescription)
        print(v.asStringForError())
        //#expect(v == ExpressionValue.of(FooClazz()))
        #expect((v != ExpressionValue.of("Lorem")) == true)
        #expect((v != ExpressionValue.of(Float(100))) == true)
        #expect((v.hashValue != 0) == true)
    }

    @Test("Validate Struct-value")
    func validateStruct() async throws {
        let v = ExpressionValue.of(FooStruct())!
        #expect(v.type == .objStruct)
        #expect(v.isStructureValue == true)
        #expect(v.asStruct().isPresent == true)
        #expect(v.asObject().isPresent == false)
        print(v.description)
        print(v.debugDescription)
        print(v.asStringForError())
        //#expect(v == ExpressionValue.of(FooStruct()))
        #expect((v != ExpressionValue.of("Lorem")) == true)
        #expect((v != ExpressionValue.of(Float(100))) == true)
        #expect((v.hashValue != 0) == true)
    }

    @Test("Validate Array-value")
    func validateArray() async throws {
        let v = ExpressionValue.of([])
        #expect(v.type == .array)
        #expect(v.isArrayValue == true)
        #expect(v.asArray().isPresent == true)
        #expect(v.asObject().isPresent == false)
        print(v.description)
        print(v.debugDescription)
        print(v.asStringForError())
        //#expect(v == ExpressionValue.of([])
        #expect((v != ExpressionValue.of("Lorem")) == true)
        #expect((v != ExpressionValue.of(Float(100))) == true)
        #expect((v.hashValue != 0) == true)
    }

    @Test("Validate Tupel-value")
    func validateTupel() async throws {
        let v: ExpressionValue = ExpressionValue.of(())!
        #expect(v.type == .tupel)
        #expect(v.isTupel == true)
        #expect(v.asTupel()! == ())
        #expect(v.asStruct().isPresent == false)
        print(v.description)
        print(v.debugDescription)
        print(v.asStringForError())
        //#expect(v == ExpressionValue.of(())
        #expect((v != ExpressionValue.of("Lorem")) == true)
        #expect((v != ExpressionValue.of(Float(100))) == true)
        #expect((v.hashValue != 0) == true)
    }

    @Test("Validate AST-value")
    func validateAST() async throws {
        let v: ExpressionValue = ExpressionValue.of(ASTNode(Token.of(position: 1, value: "1", type: .literalNumber)))
        #expect(v.type == .nodeAST)
        #expect(v.isAST == true)
        #expect(v.asNode().isPresent == true)
        #expect(v.asStruct().isPresent == false)
        print(v.description)
        print(v.debugDescription)
        print(v.asStringForError())
        //#expect(v == ExpressionValue.of(ASTNode(Token.of(position: 1, value: "1", type: .literalNumber)))
        #expect((v != ExpressionValue.of("Lorem")) == true)
        #expect((v != ExpressionValue.of(Float(100))) == true)
        #expect((v.hashValue != 0) == true)
    }

    @Test("Validate component-access class")
    func validateComponentAccessClass() async throws {
        let v: ExpressionValue = ExpressionValue.of(FooClazz(attribute1: "Hello", attribute2: 1))!
        #expect(v.type == .objClass)
        print(v.hasComponent("attribute1") == true)
        print(v.hasComponent("attributeX") == false)
        print(v.getComponent("attribute1").isPresent == true)
        print(v.getComponent("attributeX").isPresent == false)
        
        let v2: ExpressionValue = ExpressionValue.of("Murks")
        print(v2.hasComponent("attribute") == false)
        print(v2.getComponent("attribute").isPresent == false)
    }

    @Test("Validate component-access struct")
    func validateComponentAccessStruct() async throws {
        let v: ExpressionValue = ExpressionValue.of(FooStruct(attribute1: "Hello", attribute2: 1))!
        #expect(v.type == .objStruct)
        print(v.hasComponent("attribute1") == true)
        print(v.hasComponent("attributeX") == false)
        print(v.getComponent("attribute1").isPresent == true)
        print(v.getComponent("attributeX").isPresent == false)

        let v2: ExpressionValue = ExpressionValue.of("Murks")
        print(v2.hasComponent("attribute") == false)
        print(v2.getComponent("attribute").isPresent == false)
    }

    @Test("Validate component-access tupel")
    func validateComponentAccessTupel() async throws {
        let v: ExpressionValue = ExpressionValue.of(("Hello", "World"))!
        #expect(v.type == .tupel)
        print(v.hasComponent("_0") == true)
        print(v.hasComponent("_X") == false)
        print(v.getComponent("_0").isPresent == true)
        print(v.getComponent("_X").isPresent == false)
    }

}
