//
//  FunctionUNITDISPERSIONTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function UNITDISPERSION()")
class FunctionUNITDISPERSIONTests {

    @Test("solveUnitSymbol of UNITDISPERSION()")
    func solveUnitSymbol() async throws {
        try #require(FunctionUNITDISPERSION.solveUnitSymbol("ppm")! == .partsPerMillion)
    }

    @Test("Definition of UNITDISPERSION()")
    func validateInit() async throws {
        let f: FunctionUNITDISPERSION = FunctionUNITDISPERSION()
        #expect(f.id == FunctionIdentifier("FunctionUNITDISPERSION"))
        #expect(f.symbols == ["UNITDISPERSION"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "UNITDISPERSION", parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [.double, .float, .decimal, .int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameUnit,
                                        strictTypes: [.string]),
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
        let f: FunctionUNITDISPERSION = FunctionUNITDISPERSION()
        // 01: invalid values
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.ofNil(), ExpressionValue.of("")])
        }
        print("01:error=\(String(describing: error1))")
        // 02: invalid values
        let error2: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.of(1.0), ExpressionValue.ofNil()])
        }
        print("02:error=\(String(describing: error2))")
        // 03: invalid values
        let error3: ExpressionError? = try #require(throws: ExpressionError.self) {
            try f.evaluateFunction(expression: fake.get(),
                                   context: ctxt,
                                   functionToken: mockToken,
                                   arguments: [ExpressionValue.of(1.0), ExpressionValue.of("murks")])
        }
        print("03:error=\(String(describing: error3))")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
          "UNITDISPERSION(10, 'ppm')",
          "UNITDISPERSION(var1, 'ppm')",
        ]
    )
    func evaluateInExpression(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(configuration: config)
        context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of((Double(20))))
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
            "UNITDISPERSION()",
            "UNITDISPERSION(10, 'xx', 20)",
        ]
    )
    func evaluateInExpressionWithFailure(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expressionSource,
            configuration: config
        )
        try #require(result.isFailure)
        print("Error: \(String(describing: result)) for '\(expressionSource)'")
    }

    @Test("Function evaluation in expression-context",
        arguments: [
            "UNITDISPERSION(NULL, 'murks')",
            "UNITDISPERSION(20.0, \"murks\")",
            "UNITDISPERSION(var1, var1)",
        ]
    )
    func evaluateInExpressionWithFailure2(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of("lorem")!)
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expressionSource,
            configuration: ExpressionConfiguration.createDefault()
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
        let expression: String = "UNITDISPERSION(100.0, \"ppm\")"
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
        #expect(evalValue.isUnitDispersion)
        #expect(evalValue.asUnitDispersion()! == Measurement<UnitDispersion>(value: 100.0, unit: .partsPerMillion))
    }

}
