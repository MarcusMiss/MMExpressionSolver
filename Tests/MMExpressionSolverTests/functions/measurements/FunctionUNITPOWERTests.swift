//
//  FunctionUNITPOWERTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function UNITPOWER()")
class FunctionUNITPOWERTests {

    @Test("solveUnitSymbol of UNITPOWER()")
    func solveUnitSymbol() async throws {
        try #require(FunctionUNITPOWER.solveUnitSymbol("TW")! == .terawatts)
        try #require(FunctionUNITPOWER.solveUnitSymbol("GW")! == .gigawatts)
        try #require(FunctionUNITPOWER.solveUnitSymbol("MW")! == .megawatts)
        try #require(FunctionUNITPOWER.solveUnitSymbol("kW")! == .kilowatts)
        try #require(FunctionUNITPOWER.solveUnitSymbol("W")! == .watts)
        try #require(FunctionUNITPOWER.solveUnitSymbol("mW")! == .milliwatts)
        try #require(FunctionUNITPOWER.solveUnitSymbol("µW")! == .microwatts)
        try #require(FunctionUNITPOWER.solveUnitSymbol("nW")! == .nanowatts)
        try #require(FunctionUNITPOWER.solveUnitSymbol("pW")! == .picowatts)
        try #require(FunctionUNITPOWER.solveUnitSymbol("fW")! == .femtowatts)
        try #require(FunctionUNITPOWER.solveUnitSymbol("hp")! == .horsepower)
    }

    @Test("Definition of UNITPOWER()")
    func validateInit() async throws {
        let f: FunctionUNITPOWER = FunctionUNITPOWER()
        #expect(f.id == FunctionIdentifier("FunctionUNITPOWER"))
        #expect(f.symbols == ["UNITPOWER"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "UNITPOWER", parameters:[
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
        let f: FunctionUNITPOWER = FunctionUNITPOWER()
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
          "UNITPOWER(10, 'W')",
          "UNITPOWER(var1, 'hp')",
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
            "UNITPOWER()",
            "UNITPOWER(10, 'xx', 20)",
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
            "UNITPOWER(NULL, 'murks')",
            "UNITPOWER(20.0, \"murks\")",
            "UNITPOWER(var1, var1)",
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
        let expression: String = "UNITPOWER(100.0, \"W\")"
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
        #expect(evalValue.isUnitPower)
        #expect(evalValue.asUnitPower()! == Measurement<UnitPower>(value: 100.0, unit: .watts))
    }

}
