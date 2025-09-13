//
//  FunctionTRIMPOSTFIXTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function FunctionTRIMPOSTFIX()")
class FunctionTRIMPOSTFIXTests {

    @Test("Definition of ()()")
    func validateInit() async throws {
        let f: FunctionTRIMPOSTFIX = FunctionTRIMPOSTFIX()
        #expect(f.id == FunctionIdentifier("FunctionTRIMPOSTFIX"))
        #expect(f.symbols == ["TRIMPOSTFIX"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "FunctionTRIMPOSTFIX", parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameText,
                                        strictTypes: [.string, .null]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.namePattern,
                                        strictTypes: [.string])
        ]))
        print("description: \"\(f.description)\"")
        print("debugDescription: \"\(f.debugDescription)\"")
        #expect(f.description.isEmpty == false)
        #expect(f.debugDescription.isEmpty == false)
    }

    @Test("Function evaluation")
    func evaluateFunction() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let fake: Result<MMExpression, ExpressionError>  = MMExpression.build(
            expression: "fake",
            configuration: ExpressionConfiguration.createDefault()
        )
        let f: FunctionTRIMPOSTFIX = FunctionTRIMPOSTFIX()
        var result: ExpressionValue = ExpressionValue.ofNil()
        // 01: TRIMPOSTFIX(null, int) (null)
        result = try f.evaluateFunction(expression: fake.get(),
                                        context: ctxt,
                                        functionToken: mockToken,
                                        arguments: [ExpressionValue.ofNil(), ExpressionValue.of(3)])
        print("01:result=\(result)")
        try #require(result.isNullValue == true)
        // 02: TRIMPOSTFIX(string, null) (null)
        result = try f.evaluateFunction(expression: fake.get(),
                                        context: ctxt,
                                        functionToken: mockToken,
                                        arguments: [ExpressionValue.ofNil(), ExpressionValue.of("Lorem")])
        print("02:result=\(result)")
        try #require(result.isNullValue == true)
        // 03: TRIMPOSTFIX(string, string) (string)
        result = try f.evaluateFunction(expression: fake.get(),
                                        context: ctxt,
                                        functionToken: mockToken,
                                        arguments: [ExpressionValue.of("Lorem"), ExpressionValue.of("rem")])
        print("03:result=\(result)")
        try #require(result.isStringValue == true)
        try #require(result.asString() == "Lo")
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
        let f: FunctionTRIMPOSTFIX = FunctionTRIMPOSTFIX()
        // 01
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.of(""), ExpressionValue.of(true)])
        }
        print("01:error=\(String(describing: error1))")
        // 02
        let error2: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.of(true), ExpressionValue.of("")])
        }
        print("02:error=\(String(describing: error2))")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
          "TRIMPOSTFIX(\"  \", \" \")",
          "TRIMPOSTFIX(\"  Ipsum  \", \" \")",
          "TRIMPOSTFIX(var1, var1)",
          "TRIMPOSTFIX(NULL, var1)",
          "TRIMPOSTFIX(\"Ipsum\", \"xxx\")",
        ]
    )
    func evaluateInExpression(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of("lorem"))
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expressionSource,
            configuration: config
        )
        try #require(result.isSuccess)
        let solveResult: Result<ExpressionValue, ExpressionError> = try result.get().evaluate(context: context)
        try #require(solveResult.isSuccess)
        print("'\(expressionSource)' > \(solveResult)")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
            "TRIMPOSTFIX()",
            "TRIMPOSTFIX(\"Lorem\", \"Ipsum\", 1)",
            "TRIMPOSTFIX(10, 10, 10)",
            "TRIMPOSTFIX(var1)"
        ]
    )
    func evaluateInExpressionWithFailure(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of(100))
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expressionSource,
            configuration: config
        )
        try #require(result.isFailure)
        print("Error: \(String(describing: result)) for '\(expressionSource)'")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
            "TRIMPOSTFIX(\"Lorem\", 10)",
            "TRIMPOSTFIX(10, 10)",
            "TRIMPOSTFIX(10, \"Lorem\")",
        ]
    )
    func evaluateInExpressionWithFailure2(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of(100))
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

    @Test("Validate success.")
    func validateSuccess() async throws {
        let expression: String = "TRIMPOSTFIX('Lorem Ipsum', 'Ipsum')"
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(configuration: config)
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expression,
            configuration: config
        )
        try #require(result.isSuccess)
        let evalResult: Result<ExpressionValue, ExpressionError>  = result.valueSuccess!.evaluate(context: context)
        try #require(evalResult.isSuccess)
        let evalValue: ExpressionValue = evalResult.valueSuccess!
        print("evalValue: \(evalValue)")
        #expect(evalValue.isStringValue)
        #expect(evalValue.asString()! == "Lorem ")
    }

}
