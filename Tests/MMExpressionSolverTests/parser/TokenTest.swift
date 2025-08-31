//
//  TokenTest.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Token")
class TokenTests {

    @Test("Validation Token-initialization")
    func validateInit() async throws {
        let t: Token = Token.of(position: 5, value: "\"Hello\"", type: .literalString)
        #expect(t.position == 5)
        #expect(t.value == "\"Hello\"")
        #expect(t.type == .literalString)
        #expect(t.operatorId.isPresent == false)
        #expect(t.functionId.isPresent == false)
        print(t.description)
        print(t.debugDescription)
        #expect(t.description.isEmpty == false)
        #expect(t.debugDescription.isEmpty == false)
        print("description = '\(t.description)'")
        print("debugDescription = '\(t.debugDescription)'")
        #expect(t == Token.of(position: 5, value: "\"Hello\"", type: .literalString))
    }

    
    @Test("Validation Token-initialization (2)")
    func validateInit2() async throws {
        let t: Token = Token.of(position: 5, value: Character("x"), type: .variable)
        #expect(t.position == 5)
        #expect(t.value == "x")
        #expect(t.type == .variable)
        #expect(t.operatorId.isPresent == false)
        #expect(t.functionId.isPresent == false)
        print(t.description)
        print(t.debugDescription)
        #expect(t.description.isEmpty == false)
        #expect(t.debugDescription.isEmpty == false)
        print("description = '\(t.description)'")
        print("debugDescription = '\(t.debugDescription)'")
        #expect(t == Token.of(position: 5, value: Character("x"), type: .variable))
    }

    @Test("Validation Token-initialization Prefix")
    func validateOperatorPrefix() async throws {
        let t: Token = Token.ofPrefix(position: 5, value: "+", ident: OperatorIdentifier.init("id"))
        #expect(t.position == 5)
        #expect(t.value == "+")
        #expect(t.type == .operatorPrefix)
        #expect(t.operatorId.isPresent == true)
        #expect(t.functionId.isPresent == false)
        #expect(t.description.isEmpty == false)
        #expect(t.debugDescription.isEmpty == false)
        print("description = '\(t.description)'")
        print("debugDescription = '\(t.debugDescription)'")
        #expect(t == Token.ofPrefix(position: 5, value: "+", ident: OperatorIdentifier.init("id")))
    }

    @Test("Validation Token-initialization Infix")
    func validateOperatorInfix() async throws {
        let t: Token = Token.ofInfix(position: 5, value: "+", ident: OperatorIdentifier.init("id"))
        #expect(t.position == 5)
        #expect(t.value == "+")
        #expect(t.type == .operatorInfix)
        #expect(t.operatorId.isPresent == true)
        #expect(t.functionId.isPresent == false)
        #expect(t.description.isEmpty == false)
        #expect(t.debugDescription.isEmpty == false)
        print("description = '\(t.description)'")
        print("debugDescription = '\(t.debugDescription)'")
        #expect(t == Token.ofInfix(position: 5, value: "+", ident: OperatorIdentifier.init("id")))
    }

    @Test("Validation Token-initialization Postfix")
    func validateOperatorPostfix() async throws {
        let t: Token = Token.ofPostfix(position: 5, value: "+", ident: OperatorIdentifier.init("id"))
        #expect(t.position == 5)
        #expect(t.value == "+")
        #expect(t.type == .operatorPostfix)
        #expect(t.operatorId.isPresent == true)
        #expect(t.functionId.isPresent == false)
        #expect(t.description.isEmpty == false)
        #expect(t.debugDescription.isEmpty == false)
        print("description = '\(t.description)'")
        print("debugDescription = '\(t.debugDescription)'")
        #expect(t == Token.ofPostfix(position: 5, value: "+", ident: OperatorIdentifier.init("id")))
    }

    @Test("Validation Token-initialization for Function")
    func validateFunction() async throws {
        let t: Token = Token.of(position: 5, value: "FOO", ident: FunctionIdentifier.init("id"))
        #expect(t.position == 5)
        #expect(t.value == "FOO")
        #expect(t.type == .function)
        #expect(t.operatorId.isPresent == false)
        #expect(t.functionId.isPresent == true)
        #expect(t.description.isEmpty == false)
        #expect(t.debugDescription.isEmpty == false)
        print("description = '\(t.description)'")
        print("debugDescription = '\(t.debugDescription)'")
        #expect(t == Token.of(position: 5, value: "FOO", ident: FunctionIdentifier.init("id")))
    }

}
