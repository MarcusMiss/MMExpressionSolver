//
//  ExpressionOperatorDefinitionTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionOperatorDefinition")
class ExpressionOperatorDefinitionTests {

    @Test("Validate ExpressionOperatorDefinition Prefix")
    func validatePrefix() async throws {
        let def: ExpressionOperatorDefinition = ExpressionOperatorDefinition(
            type: .prefix,
            precedence: .equality,
            isLeftAssociative: true,
            isLazy: true
        )
        #expect(def.isPrefix == true)
        #expect(def.isInfix == false)
        #expect(def.isPostfix == false)
        #expect(def.precedence == .equality)
        #expect(def.isLeftAssociative == true)
        #expect(def.isLazy == true)
        #expect(def.description == "type: prefix, precedence: equality, isLeftAssociative: true, , isLazy: true")
        #expect(def.debugDescription == "ExpressionOperatorDefinition(type: prefix, precedence: equality, isLeftAssociative: true, , isLazy: true)")
    }

    @Test("Validate ExpressionOperatorDefinition Infix")
    func validatInfix() async throws {
        let def: ExpressionOperatorDefinition = ExpressionOperatorDefinition(
            type: .infix,
            precedence: .equality,
            isLeftAssociative: true,
            isLazy: true
        )
        #expect(def.isPrefix == false)
        #expect(def.isInfix == true)
        #expect(def.isPostfix == false)
        #expect(def.precedence == .equality)
        #expect(def.isLeftAssociative == true)
        #expect(def.isLazy == true)
        #expect(def.description == "type: infix, precedence: equality, isLeftAssociative: true, , isLazy: true")
        #expect(def.debugDescription == "ExpressionOperatorDefinition(type: infix, precedence: equality, isLeftAssociative: true, , isLazy: true)")
    }
    
    @Test("Validate ExpressionOperatorDefinition Postfix")
    func validatepPostfix() async throws {
        let def: ExpressionOperatorDefinition = ExpressionOperatorDefinition(
            type: .postfix,
            precedence: .equality,
            isLeftAssociative: true,
            isLazy: true
        )
        #expect(def.isPrefix == false)
        #expect(def.isInfix == false)
        #expect(def.isPostfix == true)
        #expect(def.precedence == .equality)
        #expect(def.isLeftAssociative == true)
        #expect(def.isLazy == true)
        #expect(def.description == "type: postfix, precedence: equality, isLeftAssociative: true, , isLazy: true")
        #expect(def.debugDescription == "ExpressionOperatorDefinition(type: postfix, precedence: equality, isLeftAssociative: true, , isLazy: true)")
    }

}
