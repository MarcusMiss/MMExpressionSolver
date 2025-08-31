//
//  FunctionREPLACEFIRSTTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function REPLACEALL()")
class FunctionREPLACEFIRSTTests {

    @Test("Validation of Utility")
    func validateUtility() async throws {
        #expect((FunctionREPLACEFIRST.replaceFirst("Hello World", "o", "X") == "HellX World") == true)
        #expect((FunctionREPLACEFIRST.replaceFirst("Hello World", "x", "X") == "Hello World") == true)
    }

    @Test("Definition of REPLACEALL()")
    func validateInit() async throws {
        let f: FunctionREPLACEFIRST = FunctionREPLACEFIRST()
        #expect(f.id == FunctionIdentifier("FunctionREPLACEFIRST"))
        #expect(f.symbols == ["REPLACEFIRST"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "REPLACEFIRST", parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameText, strictTypes: [.string, .null]),
            ExpressionFunctionParameter(name: "pattern", strictTypes: [.string]),
            ExpressionFunctionParameter(name: "replacement", strictTypes: [.string]),
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
        let f: FunctionREPLACEFIRST = FunctionREPLACEFIRST()
        var result: ExpressionValue = ExpressionValue.ofNil()
        // 01
        result = try f.evaluateFunction(expression: fake.get(),
                                        context: ctxt,
                                        functionToken: mockToken,
                                        arguments: [ExpressionValue.of(""), ExpressionValue.of("o"), ExpressionValue.of("x")])
        print("01:result=\(result)")
        try #require(result.isStringValue == true)
        try #require(result.asString() == "")
        // 02
        result = try f.evaluateFunction(expression: fake.get(),
                                        context: ctxt,
                                        functionToken: mockToken,
                                        arguments: [ExpressionValue.of("Lorem"), ExpressionValue.of("o"), ExpressionValue.of("x")])
        print("02:result=\(result)")
        try #require(result.isStringValue == true)
        try #require(result.asString() == "Lxrem")
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
        let f: FunctionREPLACEFIRST = FunctionREPLACEFIRST()
        // 01
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.of(""), ExpressionValue.ofNil(), ExpressionValue.of("")])
        }
        print("01:error=\(String(describing: error1))")
        // 02
        let error2: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.of(""), ExpressionValue.of(""), ExpressionValue.ofNil()])
        }
        print("02:error=\(String(describing: error2))")
        // 03
        let error3: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.of(10), ExpressionValue.of(""), ExpressionValue.of("")])
        }
        print("03:error=\(String(describing: error3))")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
          "REPLACEFIRST(\"\", \"\", \"\")",
          "REPLACEFIRST(\"Lorem Ipsum\", \"m\", \"x\")",
          "REPLACEFIRST(NULL, \"m\", \"x\")",
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
            "REPLACEFIRST(\"\")",
            "REPLACEFIRST(\"\", 10)",
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
            "REPLACEFIRST(\"\", 10, \"\")",
            "REPLACEFIRST(\"\", \"\", 20)",
            "REPLACEFIRST(30, \"\", \"\")",
            "REPLACEFIRST(var1, \"\", \"\")",
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
        let expression: String = "REPLACEFIRST('Lorem Ipsum', 'm', 'X')"
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
        #expect(evalValue.asString()! == "LoreX Ipsum")
    }

}
