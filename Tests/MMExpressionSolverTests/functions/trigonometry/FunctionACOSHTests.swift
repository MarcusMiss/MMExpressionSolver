//
//  FunctionACOSHTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function ACOSH()")
class FunctionACOSHTests {

    @Test("Definition of ACOS()")
    func validateInit() async throws {
        let f: FunctionACOSH = FunctionACOSH()
        #expect(f.id == FunctionIdentifier("FunctionACOSH"))
        #expect(f.symbols == ["ACOSH"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "ACOSH", parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameNumber, strictTypes: [.double, .float, .decimal, .int])
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
        let f: FunctionACOSH = FunctionACOSH()
        // 01: invalid value
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.ofNil()])
        }
        print("01:error=\(String(describing: error1))")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
            "ACOSH()",
            "ACOSH(1,2)",
        ]
    )
    func evaluateInExpression(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        context.variables.storeVariable(identifier: "var2", value: ExpressionValue.of((Double(1.0))))
        context.variables.storeVariable(identifier: "var3", value: ExpressionValue.of((Float(1.0))))
        context.variables.storeVariable(identifier: "var4", value: ExpressionValue.of((Decimal(1.0))))
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expressionSource,
            configuration: config
        )
        try #require(result.isFailure)
        print("'\(expressionSource)' > \(result)")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
            "ACOSH()",
            "ACOSH(-2, 3)",
        ]
      )
    func evaluateInExpressionWithFailure(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of("lorem"))
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expressionSource,
            configuration: ExpressionConfiguration.createDefault()
        )
        try #require(result.isFailure)
        print("Error: \(String(describing: result)) for '\(expressionSource)'")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
            "ACOSH(NULL)",
            "ACOSH(\"murks\")",
            "ACOSH(var1)",
            "ACOSH(-2)",
            "ACOSH(0)",
        ]
    )
    func evaluateInExpressionWithFailure2(expressionSource: String) async throws {
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
        context.variables.storeVariable(identifier: "var2", value: ExpressionValue.of((Double(1.0))))
        context.variables.storeVariable(identifier: "var3", value: ExpressionValue.of((Float(1.0))))
        context.variables.storeVariable(identifier: "var4", value: ExpressionValue.of((Decimal(1.0))))
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: "ACOSH(1.0)",
            configuration: config
        )
        try #require(result.isSuccess)
        let solver: MMExpression = try result.get()
        let solverResult: ExpressionValue = try solver.evaluateRootNode(context: context)
        print("solverResult: \(String(describing: solverResult)) for '\(solver.expression)'")
        #expect(solverResult == ExpressionValue.of(Double(0.0)))
    }

    @Test("Validate success.")
    func validateSuccess() async throws {
        let expression: String = "ACOSH(1.0)"
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
        #expect(evalValue.isDoubleValue)
        #expect(evalValue.asDouble()! == Double(0.0))
    }

}
