//
//  FunctionARRAYLENTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function ARRAYLEN()")
class FunctionARRAYLENTests {

    @Test("Definition of ARRAYLEN()")
    func validateInit() async throws {
        let f: FunctionARRAYLEN = FunctionARRAYLEN()
        #expect(f.id == FunctionIdentifier("FunctionARRAYLEN"))
        #expect(f.symbols == ["ARRAYLEN"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "ARRAYLEN", parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue, strictTypes: [.array])
        ]))
        print("description: \"\(f.description)\"")
        print("debugDescription: \"\(f.debugDescription)\"")
        #expect(f.description.isEmpty == false)
        #expect(f.debugDescription.isEmpty == false)
    }

    @Test("Function evaluation to fail")
    func evaluateFunctionToFail() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let fake: Result<MMExpression, ExpressionError>  = MMExpression.build(
            expression: "fake",
            configuration: ExpressionConfiguration.createDefault()
        )
        let f: FunctionARRAYLEN = FunctionARRAYLEN()
        // 01: invalid value
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.ofNil()])
        }
        print("01:error=\(String(describing: error1))")
        // 02: invalid value
        let error2: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.of("murks")])
        }
        print("02:error=\(String(describing: error2))")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
            "ARRAYLEN()",
            "ARRAYLEN(var1, var2)",
            "ARRAYLEN(10,20)",
        ]
    )
    func evaluateInExpression(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of([]))
        context.variables.storeVariable(identifier: "var2", value: ExpressionValue.of([10, 20, 30]))
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expressionSource,
            configuration: config
        )
        try #require(result.isFailure)
        print("'\(expressionSource)' > \(result)")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
            "ARRAYLEN(NULL)",
            "ARRAYLEN(\"murks\")",
            "ARRAYLEN(var1)",
        ]
    )
    func evaluateInExpressionWithFailure(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of("lorem")!)
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expressionSource,
            configuration: config
        )
        try #require(result.isSuccess)
        let solver: MMExpression = try result.get()
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try solver.evaluateRootNode(context: context)
        }
        print("Error: \(String(describing: error)) for '\(expressionSource)'")
    }

    @Test("Function evaluation in expression-context")
    func evaluateInExpressionDirect() async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        context.variables.storeVariable(identifier: "var2", value: ExpressionValue.of([10, 20, 30]))
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: "ARRAYLEN(var2)",
            configuration: config
        )
        try #require(result.isSuccess)
        let solver: MMExpression = try result.get()
        let solverResult: ExpressionValue = try solver.evaluateRootNode(context: context)
        print("solverResult: \(String(describing: solverResult)) for '\(solver.expression)'")
        #expect(solverResult == ExpressionValue.of(3))
    }

    @Test("Validate success.")
    func validateSuccess() async throws {
        let expression: String = "ARRAYLEN(var1)"
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(configuration: config)
        context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of([10, 20, 30, 40]))
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expression,
            configuration: config
        )
        try #require(result.isSuccess)
        let evalResult: Result<ExpressionValue, ExpressionError>  = result.valueSuccess!.evaluate(context: context)
        try #require(evalResult.isSuccess)
        let evalValue: ExpressionValue = evalResult.valueSuccess!
        print("evalValue: \(evalValue)")
        #expect(evalValue.isIntegerValue)
        #expect(evalValue.asInteger()! == Int(4))
    }

}
