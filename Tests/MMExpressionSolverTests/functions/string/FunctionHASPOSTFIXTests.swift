//
//  FunctionHASPOSTFIXTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function HASPOSTFIX()")
class FunctionHASPOSTFIXTests {

    @Test("Definition of HASPOSTFIX()")
    func validateInit() async throws {
        let f: FunctionHASPOSTFIX = FunctionHASPOSTFIX()
        #expect(f.id == FunctionIdentifier("FunctionHASPOSTFIX"))
        #expect(f.symbols == ["HASPOSTFIX"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "HASPOSTFIX", parameters:[
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
        let f: FunctionHASPOSTFIX = FunctionHASPOSTFIX()
        var result: ExpressionValue = ExpressionValue.ofNil()
        // 01
        result = try f.evaluateFunction(expression: fake.get(),
                                        context: ctxt,
                                        functionToken: mockToken,
                                        arguments: [ExpressionValue.ofNil(), ExpressionValue.of(3)])
        print("01:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == false)
        // 02
        result = try f.evaluateFunction(expression: fake.get(),
                                        context: ctxt,
                                        functionToken: mockToken,
                                        arguments: [ExpressionValue.of("Lorem"), ExpressionValue.of("rem")])
        print("02:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == true)
        // 03
        result = try f.evaluateFunction(expression: fake.get(),
                                        context: ctxt,
                                        functionToken: mockToken,
                                        arguments: [ExpressionValue.of("Lorem")!, ExpressionValue.of("XX")])
        print("03:result=\(result)")
        try #require(result.isBooleanValue == true)
        try #require(result.asBoolean() == false)
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
        let f: FunctionHASPOSTFIX = FunctionHASPOSTFIX()
        // 01
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.of("")!, ExpressionValue.of(true)!])
        }
        print("01:error=\(String(describing: error1))")
        // 02
        let error2: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.of(true)!, ExpressionValue.of("")!])
        }
        print("02:error=\(String(describing: error2))")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
          "HASPOSTFIX(\"  \", '')",
          "HASPOSTFIX(NULL, 'x')",
          "HASPOSTFIX(\"  \", var1)",
          "HASPOSTFIX(\"Ipsum\", 'sum')",
          "HASPOSTFIX(var1, var1)",
        ]
    )
    func evaluateInExpression(expressionSource: String) async throws {
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
        let solveResult: Result<ExpressionValue, ExpressionError> = try result.get().evaluate(context: context)
        try #require(solveResult.isSuccess)
        print("'\(expressionSource)' > \(solveResult)")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
            "HASPOSTFIX()",
            "HASPOSTFIX(\"Lorem\", \"Ipsum\", 20 )",
            "HASPOSTFIX(var1)"
        ]
    )
    func evaluateInExpressionWithFailure(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of(100)!)
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expressionSource,
            configuration: config
        )
        try #require(result.isFailure)
        print("Error: \(String(describing: result)) for '\(expressionSource)'")
    }

    
    @Test("Function evaluation in expression-context",
        arguments: [
            "HASPOSTFIX(\"Lorem\", 10)",
            "HASPOSTFIX(10, 10)",
        ]
    )
    func evaluateInExpressionWithFailure2(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of(100)!)
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
        let expression: String = "HASPOSTFIX('Lorem Ipsum', 'Ipsum')"
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
        #expect(evalValue.isBooleanValue)
        #expect(evalValue.asBoolean()! == true)
    }

}
