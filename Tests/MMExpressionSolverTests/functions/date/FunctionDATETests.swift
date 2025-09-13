//
//  FunctionDATETests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function DATE()")
class FunctionDATETests {

    @Test("Definition of DATE()")
    func validateInit() async throws {
        let f: FunctionDATE = FunctionDATE()
        #expect(f.id == FunctionIdentifier("FunctionDATE"))
        #expect(f.symbols == ["DATE"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "DATE", parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameYear, strictTypes: [.int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameMonth, strictTypes: [.int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameDay, strictTypes: [.int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameHour, strictTypes: [.int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameMinute, strictTypes: [.int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameSecond, strictTypes: [.int]),
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
        let f: FunctionDATE = FunctionDATE()
        // 01: year is invalid
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [
                                    ExpressionValue.of(0),  ExpressionValue.of(9),  ExpressionValue.of(12),
                                    ExpressionValue.of(10),  ExpressionValue.of(11),  ExpressionValue.of(12)
                                   ])
        }
        print("01:error=\(String(describing: error1))")
        // 02: month is invalid
        let error2: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [
                                    ExpressionValue.of(2025),  ExpressionValue.of(0),  ExpressionValue.of(12),
                                    ExpressionValue.of(10),  ExpressionValue.of(11),  ExpressionValue.of(12)
                                   ])
        }
        print("02:error=\(String(describing: error2))")
        // 03: day is invalid
        let error3: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [
                                    ExpressionValue.of(2025),  ExpressionValue.of(9),  ExpressionValue.of(0),
                                    ExpressionValue.of(10),  ExpressionValue.of(11),  ExpressionValue.of(12)
                                   ])
        }
        print("03:error=\(String(describing: error3))")
        // 04: hour is invalid
        let error4: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [
                                    ExpressionValue.of(2025),  ExpressionValue.of(9),  ExpressionValue.of(12),
                                    ExpressionValue.of(99),  ExpressionValue.of(11),  ExpressionValue.of(12)
                                   ])
        }
        print("04:error=\(String(describing: error4))")
        // 05: minute is invalid
        let error5: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [
                                    ExpressionValue.of(2025),  ExpressionValue.of(9),  ExpressionValue.of(12),
                                    ExpressionValue.of(10),  ExpressionValue.of(99),  ExpressionValue.of(12)
                                   ])
        }
        print("05:error=\(String(describing: error5))")
        // 06: minute is invalid
        let error6: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [
                                    ExpressionValue.of(2025),  ExpressionValue.of(9),  ExpressionValue.of(12),
                                    ExpressionValue.of(10),  ExpressionValue.of(11),  ExpressionValue.of(99)
                                   ])
        }
        print("06:error=\(String(describing: error6))")
        // 07: second is invalid
        let error7: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [
                                    ExpressionValue.of(2025),  ExpressionValue.of(9),  ExpressionValue.of(12),
                                    ExpressionValue.of(10),  ExpressionValue.of(11),  ExpressionValue.of("murks")
                                   ])
        }
        print("07:error=\(String(describing: error7))")
        // 08: param count is invalid
        let error8: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [
                                    ExpressionValue.of(2025),  ExpressionValue.of(9),  ExpressionValue.of(12),
                                    ExpressionValue.of(10),  ExpressionValue.of(11),  ExpressionValue.of("murks"),
                                    ExpressionValue.of("murks2")
                                   ])
        }
        print("08:error=\(String(describing: error8))")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
            "DATE()",
            "DATE('murks')",
            "DATE(1, 'murks')",
            "DATE(1, 2, 'murks')",
            "DATE(1, 2, 3, 'murks')",
            "DATE(1, 2, 3, 4, 'murks')",
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

    @Test("Validate success.")
    func validateSuccess() async throws {
        let expression: String = "DATE(2025, 9, 12, 11, 29, 0)"
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
        #expect(evalValue.asDateTime()! <= Date())
    }

}
