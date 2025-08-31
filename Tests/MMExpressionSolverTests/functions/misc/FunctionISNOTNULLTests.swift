//
//  FunctionISNOTNULLTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function ISNOTNULL()")
class FunctionISNOTNULLTests {

    @Test("Definition of ISNOTNULL()")
    func validateInit() async throws {
        let f: FunctionISNOTNULL = FunctionISNOTNULL()
        #expect(f.id == FunctionIdentifier("FunctionISNOTNULL"))
        #expect(f.symbols == ["ISNOTNULL"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "ISNOTNULL", parameters:[
            ExpressionFunctionParameter(name: "value", allowNull: true)
        ]))
        print("description: \"\(f.description)\"")
        print("debugDescription: \"\(f.debugDescription)\"")
        #expect(f.description.isEmpty == false)
        #expect(f.debugDescription.isEmpty == false)
    }

    @Test("Function evaluation in expression-context",
        arguments: [
          "ISNOTNULL(NULL)",
          "ISNOTNULL(-10)",
          "ISNOTNULL(var1)",
          "ISNOTNULL(var2)",
          "ISNOTNULL(var3)",
          "ISNOTNULL(var4)",
        ]
    )
    func evaluateInExpression(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of(-10)!)
        context.variables.storeVariable(identifier: "var2", value: ExpressionValue.of((Double(-10)))!)
        context.variables.storeVariable(identifier: "var3", value: ExpressionValue.of((Float(-10)))!)
        context.variables.storeVariable(identifier: "var4", value: ExpressionValue.of((Decimal(-10)))!)
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
            "ISNOTNULL()",
            "ISNOTNULL(NULL, var1)",
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
        try #require(result.isFailure)
        print("Error: \(String(describing: result)) for '\(expressionSource)'")
    }

    @Test("Validate success.")
    func validateSuccess() async throws {
        let expression: String = "ISNOTNULL(NULL)"
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
        #expect(evalValue.asBoolean()! == Bool(false))
    }

}
