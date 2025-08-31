//
//  ASTNodeTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ASTNode")
class ASTNodeClassTests {

    @Test("ASTNode initialization")
    func validateInit() async throws {
        let n: ASTNode = ASTNode(Token.of(position: 1, value: "\"Hello\"", type: .literalString))
        #expect(n.parameters.count == 0)
        #expect(n.description.isEmpty == false)
        #expect(n.debugDescription.isEmpty == false)
        print("description: '\(n.description)'")
        print("debugDescription: '\(n.debugDescription)'")
        #expect(n == ASTNode(Token.of(position: 1, value: "\"Hello\"", type: .literalString)))
    }

    @Test("ASTNode initialization with parameters")
    func validateInit2() async throws {
        let n: ASTNode = ASTNode(Token.ofInfix(position: 2, value: "+", ident: OperatorIdentifier("+")),
                                           parameters:[
                                                ASTNode(Token.of(position: 1, value: "100", type: .literalNumber)),
                                                ASTNode(Token.of(position: 3, value: "100", type: .literalNumber))
                                           ])
        #expect(n.parameters.count == 2)
        #expect(n.description.isEmpty == false)
        #expect(n.debugDescription.isEmpty == false)
        print("description: '\(n.description)'")
        print("debugDescription: '\(n.debugDescription)'")
        #expect(n == ASTNode(Token.ofInfix(position: 2, value: "+", ident: OperatorIdentifier("+")),
                                  parameters:[
                                       ASTNode(Token.of(position: 1, value: "100", type: .literalNumber)),
                                       ASTNode(Token.of(position: 3, value: "100", type: .literalNumber))
                                  ])
        )
    }

}
