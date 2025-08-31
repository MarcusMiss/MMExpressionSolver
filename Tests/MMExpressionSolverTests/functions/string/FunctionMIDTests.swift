//
//  FunctionMIDTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function MID()")
class FunctionMIDTests {

    @Test("Validation of Utility")
    func validateUtility() async throws {
        #expect((FunctionMID.MID("", 10, 10) == "") == true)
        #expect((FunctionMID.MID("Lorem", 1, 10) == "Lorem") == true)
        #expect((FunctionMID.MID("Lorem", 1, 5) == "Lorem") == true)
        #expect((FunctionMID.MID("Lorem", 1, 3) == "Lor") == true)
        #expect((FunctionMID.MID("Lorem", 1, 2) == "Lo") == true)
        #expect((FunctionMID.MID("Lorem", 1, 1) == "L") == true)
        #expect((FunctionMID.MID("Lorem", 5, 1) == "m") == true)
        #expect((FunctionMID.MID("Lorem", 6, 1) == "") == true)
    }

    @Test("Definition of LEFT()")
    func validateInit() async throws {
        let f: FunctionMID = FunctionMID()
        #expect(f.id == FunctionIdentifier("FunctionMID"))
        #expect(f.symbols == ["MID"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "MID", parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameText,
                                        strictTypes: [.string, .null]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameStart,
                                        strictTypes: [.int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameLength,
                                        strictTypes: [.int])
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
        let f: FunctionMID = FunctionMID()
        var result: ExpressionValue = ExpressionValue.ofNil()
        // 01
        result = try f.evaluateFunction(expression: fake.get(),
                                        context: ctxt,
                                        functionToken: mockToken,
                                        arguments: [ExpressionValue.ofNil(), ExpressionValue.of(3), ExpressionValue.ofNil(),])
        print("01:result=\(result)")
        try #require(result.isNullValue == true)
        // 02
        result = try f.evaluateFunction(expression: fake.get(),
                                        context: ctxt,
                                        functionToken: mockToken,
                                        arguments: [ExpressionValue.of("Lorem"), ExpressionValue.ofNil(), ExpressionValue.of(3)])
        print("02:result=\(result)")
        try #require(result.isNullValue == true)
        // 03
        result = try f.evaluateFunction(expression: fake.get(),
                                        context: ctxt,
                                        functionToken: mockToken,
                                        arguments: [ExpressionValue.of("Lorem")!, ExpressionValue.of(1)!, ExpressionValue.of(5)!])
        print("03:result=\(result)")
        try #require(result.isStringValue == true)
        try #require(result.asString() == "Lorem")
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
        let f: FunctionMID = FunctionMID()
        // 01
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.of("")!, ExpressionValue.of(true)!, ExpressionValue.of(-5)!])
        }
        print("01:error=\(String(describing: error1))")
        // 02
        let error2: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.of(true)!, ExpressionValue.of("")!, ExpressionValue.of(5)!])
        }
        print("02:error=\(String(describing: error2))")
        // 03
        let error3: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.of("")!, ExpressionValue.of(2)!, ExpressionValue.of(true)!])
        }
        print("03:error=\(String(describing: error3))")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
          "MID(\"  \", 1, 200)",
          "MID(NULL, 2, 200)",
          "MID(\"  \", 1, 1)",
          "MID(\"  Ipsum  \", 3, 5)",
          "MID(var1, 5, 2)",
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
            "MID()",
            "MID(\"Lorem\", \"Ipsum\", 5, 20)",
            "MID(10, 10)",
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
            "MID(\"Lorem\", \"Ipsum\", 5)",
            "MID(10, 10, 20)",
            "MID(var1, var1, var1)"
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
        let expression: String = "MID('Lorem Ipsum', 5, 3)"
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
        #expect(evalValue.asString()! == "m I")
    }

}
