//
//  ExpressionSyntaxTreeBuilderTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionSyntaxTreeBuilder")
class ExpressionSyntaxTreeBuilderTests {

    @Test("Minimal test")
    func validate() async throws {
        let builder: ExpressionSyntaxTreeBuilder = ExpressionSyntaxTreeBuilder(
            expression: "100",
            configuration: ExpressionConfiguration.createDefault(),
            expressionTokens: [
                Token.of(position: 1, value: "100", type: .literalNumber)
            ]
        )
        let result: Result<ASTNode, ExpressionError>  = builder.buildSyntaxTree()
        print("\(result)")
        #expect(result.isSuccess)
    }

    @Test("Invalid arrayOpen '['")
    func arrayOpen() async throws {
        let builder: ExpressionSyntaxTreeBuilder = ExpressionSyntaxTreeBuilder(
            expression: "[",
            configuration: ExpressionConfiguration.createDefault(),
            expressionTokens: [
                Token.of(position: 1, value: "[", type: .arrayOpen)
            ]
        )
        let result: Result<ASTNode, ExpressionError>  = builder.buildSyntaxTree()
        print("\(result)")
        #expect(result.isFailure)
        // ExpressionError.missingOperandForOperator(token: Token(type:arrayOpen, value:'[', position:1))
    }

    @Test("Invalid arrayClose ']'")
    func arrayClose() async throws {
        let builder: ExpressionSyntaxTreeBuilder = ExpressionSyntaxTreeBuilder(
            expression: "]",
            configuration: ExpressionConfiguration.createDefault(),
            expressionTokens: [
                Token.of(position: 1, value: "]", type: .arrayOpen)
            ]
        )
        let result: Result<ASTNode, ExpressionError>  = builder.buildSyntaxTree()
        print("\(result)")
        #expect(result.isFailure)
        // ExpressionError.missingOperandForOperator(token: Token(type:arrayOpen, value:']', position:1))
    }

    @Test("Invalid array '[]'")
    func array() async throws {
        let builder: ExpressionSyntaxTreeBuilder = ExpressionSyntaxTreeBuilder(
            expression: "[]",
            configuration: ExpressionConfiguration.createDefault(),
            expressionTokens: [
                Token.of(position: 1, value: "[]", type: .arrayOpen)
            ]
        )
        let result: Result<ASTNode, ExpressionError>  = builder.buildSyntaxTree()
        print("\(result)")
        #expect(result.isFailure)
        // ExpressionError.missingOperandForOperator(token: Token(type:arrayOpen, value:'[]', position:1)))
    }

    @Test("Invalid braceOpen")
    func braceOpen() async throws {
        let builder: ExpressionSyntaxTreeBuilder = ExpressionSyntaxTreeBuilder(
            expression: "(",
            configuration: ExpressionConfiguration.createDefault(),
            expressionTokens: [
                Token.of(position: 1, value: "(", type: .braceOpen)
            ]
        )
        let result: Result<ASTNode, ExpressionError> = builder.buildSyntaxTree()
        print("\(result)")
        #expect(result.isFailure)
    }

    @Test("Invalid braceOpen (2)")
    func braceOpen2() async throws {
        let builder: ExpressionSyntaxTreeBuilder = ExpressionSyntaxTreeBuilder(
            expression: "(100",
            configuration: ExpressionConfiguration.createDefault(),
            expressionTokens: [
                Token.of(position: 1, value: "(", type: .braceOpen),
                Token.of(position: 2, value: "100", type: .literalNumber)
            ]
        )
        let result: Result<ASTNode, ExpressionError> = builder.buildSyntaxTree()
        print("\(result)")
        #expect(result.isFailure)
    }

    @Test("Valid braceOpen,braceClose")
    func braceOpenClose() async throws {
        let builder: ExpressionSyntaxTreeBuilder = ExpressionSyntaxTreeBuilder(
            expression: "(100)",
            configuration: ExpressionConfiguration.createDefault(),
            expressionTokens: [
                Token.of(position: 1, value: "(", type: .braceOpen),
                Token.of(position: 2, value: "100", type: .literalNumber),
                Token.of(position: 3, value: ")", type: .braceClose)
            ]
        )
        let result: Result<ASTNode, ExpressionError> = builder.buildSyntaxTree()
        print("\(result)")
        #expect(result.isSuccess)
    }

    @Test("Validate createOperatorNode(..)")
    func createOperatorNode() async throws {
        let builder: ExpressionSyntaxTreeBuilder = ExpressionSyntaxTreeBuilder(
            expression: "",
            configuration: ExpressionConfiguration.createDefault(),
            expressionTokens: []
        )
        let error: ExpressionError? = #expect(throws: ExpressionError.self) {
            try builder.createOperatorNode(Token.of(position: 1, value: "1", type: .literalNumber))
        }
        print("\(String(describing: error))")
        // #expect(error == ExpressionError.missingOperandForOperator(token: Token(type:literalNumber, value:'1', position:1)))
    }

    @Test("Validate createOperatorNode(operatorPrefix)")
    func createOperatorNode2() async throws {
        let builder: ExpressionSyntaxTreeBuilder = ExpressionSyntaxTreeBuilder(
            expression: "1 +",
            configuration: ExpressionConfiguration.createDefault(),
            expressionTokens: []
        )
        let error: ExpressionError? = #expect(throws: ExpressionError.self) {
            try builder.createOperatorNode(Token.of(position: 1, value: "1", type: .literalNumber))
        }
        print("\(String(describing: error))")
        // #expect(error == missingOperandForOperator(token: Token(type:literalNumber, value:'1', position:1)))
    }

    /*
     if self.operandStack.isEmpty {
         throw ExpressionError.missingOperandForOperator(token: token)
     }
     let operand1: Optional<ASTNode> = self.operandStack.popLast()
     if token.type == .operatorPrefix || token.type == .operatorPostfix {
         self.operandStack.append(ASTNode(token, parameters: [operand1!]))
     } else {
         if operandStack.isEmpty {
             throw ExpressionError.missingSecondOperandForOperator(token: token)
         }
         let operand2: Optional<ASTNode> = self.operandStack.popLast()
         self.operandStack.append(ASTNode(token, parameters: [operand2!, operand1!]))
     }

     */
    
    @Test("Validate isNextOperatorOfHigherPrecedence(..)")
    func isNextOperatorOfHigherPrecedence() async throws {
        let builder: ExpressionSyntaxTreeBuilder = ExpressionSyntaxTreeBuilder(
            expression: "",
            configuration: ExpressionConfiguration.createDefault(),
            expressionTokens: []
        )
        // e.g unary (prefix) > additive (infix)
        let opDefAddInfix: ExpressionOperatorDefinition = InfixOperatorPlus().definition
        let opDefAddPrefix: ExpressionOperatorDefinition = PrefixOperatorPlus().definition

        let opDefAssocL: ExpressionOperatorDefinition = ExpressionOperatorDefinition(type: .prefix,
                                                                                     precedence: .additive,
                                                                                     isLeftAssociative: true,
                                                                                     isLazy: false)
        let opDefAssocR: ExpressionOperatorDefinition = ExpressionOperatorDefinition(type: .prefix,
                                                                                     precedence: .unary,
                                                                                     isLeftAssociative: false,
                                                                                     isLazy: false)
        #expect(builder.isNextOperatorOfHigherPrecedence(opDefAddInfix, Optional.some(opDefAddPrefix)) == true)
        #expect(builder.isNextOperatorOfHigherPrecedence(opDefAddPrefix, Optional.some(opDefAddInfix)) == false)
        #expect(builder.isNextOperatorOfHigherPrecedence(opDefAddPrefix, Optional.none) == true)
        
        #expect(builder.isNextOperatorOfHigherPrecedence(opDefAssocL, Optional.some(opDefAssocR)) == true)
        #expect(builder.isNextOperatorOfHigherPrecedence(opDefAssocL, Optional.some(opDefAssocL)) == true)
        #expect(builder.isNextOperatorOfHigherPrecedence(opDefAssocR, Optional.some(opDefAssocR)) == false)
        #expect(builder.isNextOperatorOfHigherPrecedence(opDefAssocR, Optional.some(opDefAssocL)) == false)
    }

    @Test("Validate isOperator(..)")
    func isOperator() async throws {
        let builder: ExpressionSyntaxTreeBuilder = ExpressionSyntaxTreeBuilder(
            expression: "",
            configuration: ExpressionConfiguration.createDefault(),
            expressionTokens: []
        )
        #expect(builder.isOperator(.operatorInfix) == true)
        #expect(builder.isOperator(.operatorPrefix) == true)
        #expect(builder.isOperator(.operatorPostfix) == true)
        #expect(builder.isOperator(.separatorStructure) == true)
        #expect(builder.isOperator(Token.of(position: 1, value: "(", type: .braceOpen)) == false)
    }

}

