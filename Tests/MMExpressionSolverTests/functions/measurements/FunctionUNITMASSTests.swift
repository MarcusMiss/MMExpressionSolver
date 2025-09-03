//
//  FunctionUNITMASSTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function UNITMASS()")
class FunctionUNITMASSTests {

    @Test("solveUnitSymbol of UNITAREA()")
    func solveUnitSymbol() async throws {
        try #require(FunctionUNITMASS.solveUnitSymbol("kg")! == .kilograms)
        try #require(FunctionUNITMASS.solveUnitSymbol("g")! == .grams)
        try #require(FunctionUNITMASS.solveUnitSymbol("dg")! == .decigrams)
        try #require(FunctionUNITMASS.solveUnitSymbol("cg")! == .centigrams)
        try #require(FunctionUNITMASS.solveUnitSymbol("mg")! == .milligrams)
        try #require(FunctionUNITMASS.solveUnitSymbol("µg")! == .micrograms)
        try #require(FunctionUNITMASS.solveUnitSymbol("ng")! == .nanograms)
        try #require(FunctionUNITMASS.solveUnitSymbol("pg")! == .picograms)
        try #require(FunctionUNITMASS.solveUnitSymbol("oz")! == .ounces)
        try #require(FunctionUNITMASS.solveUnitSymbol("lb")! == .pounds)
        try #require(FunctionUNITMASS.solveUnitSymbol("st")! == .stones)
        try #require(FunctionUNITMASS.solveUnitSymbol("t")! == .metricTons)
        try #require(FunctionUNITMASS.solveUnitSymbol("ton")! == .shortTons)
        try #require(FunctionUNITMASS.solveUnitSymbol("ct")! == .carats)
        try #require(FunctionUNITMASS.solveUnitSymbol("oz t")! == .ouncesTroy)
        try #require(FunctionUNITMASS.solveUnitSymbol("slug")! == .slugs)
    }

    @Test("Definition of UNITAREA()")
    func validateInit() async throws {
        let f: FunctionUNITMASS = FunctionUNITMASS()
        #expect(f.id == FunctionIdentifier("FunctionUNITMASS"))
        #expect(f.symbols == ["UNITMASS"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "UNITMASS", parameters:[
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
        let f: FunctionUNITMASS = FunctionUNITMASS()
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
          "UNITMASS(10, 'kg')",
          "UNITMASS(var1, 'lb')",
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
            "UNITMASS()",
            "UNITMASS(10, 'xx', 20)",
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
            "UNITMASS(NULL, 'murks')",
            "UNITMASS(20.0, \"murks\")",
            "UNITMASS(var1, var1)",
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
        let expression: String = "UNITMASS(100.0, \"kg\")"
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
        #expect(evalValue.isUnitMass)
        #expect(evalValue.asUnitMass()! == Measurement<UnitMass>(value: 100.0, unit: .kilograms))
    }

}
