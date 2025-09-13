//
//  FunctionADDYEARTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function ADDYEAR()")
class FunctionADDYEARTests {

    @Test("Definition of ADDMONTH()")
    func validateInit() async throws {
        let f: FunctionADDYEAR = FunctionADDYEAR()
        #expect(f.id == FunctionIdentifier("FunctionADDYEAR"))
        #expect(f.symbols == ["ADDYEAR"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "ADDYEAR", parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue, strictTypes: [.datetime]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameYear, strictTypes: [.int]),
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
        let f: FunctionADDYEAR = FunctionADDYEAR()
        // 01: date is in valid
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [
                                    ExpressionValue.of(10),  ExpressionValue.of(9)
                                   ])
        }
        print("01:error=\(String(describing: error1))")
        // 02: delta is in valid
        let error2: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [
                                    ExpressionValue.of(Date()),  ExpressionValue.of("murks")
                                   ])
        }
        print("02:error=\(String(describing: error2))")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
            "ADDYEAR()",
            "ADDYEAR('murks')",
            "ADDYEAR(NOW())",
        ]
    )
    func evaluateInExpressionWithFailure(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression:  expressionSource,
            configuration: config
        )
        print("result = \(result)")
        try #require(result.isFailure)
        print("Error: \(String(describing: result)) for '\(expressionSource)'")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
            "ADDYEAR(NOW(), 'Murks')",
        ]
    )
    func evaluateInExpressionWithFailure2(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(configuration: config)
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expressionSource,
            configuration: config
        )
        try #require(result.isSuccess)
        let evalResult: Result<ExpressionValue, ExpressionError>  = result.valueSuccess!.evaluate(context: context)
        try #require(evalResult.isFailure)
        print("Error: \(String(describing: evalResult)) for '\(expressionSource)'")
    }

    @Test("Validate success.")
    func validateSuccess() async throws {
        let expression: String = "ADDYEAR(DATE(2025, 9, 12, 11, 29, 0), 1)"
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
        #expect(evalValue.isDateTime)
        #expect(evalValue.asDateTime()! == Date.create(year: 2026, month: 9, day: 12, hour: 11, minute: 29, second: 0))
    }


}
