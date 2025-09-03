//
//  FunctionUNITINFORMATIONSTORAGETests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function UNITINFORMATIONSTORAGE()")
class FunctionUNITINFORMATIONSTORAGETests {

    @Test("solveUnitSymbol of UNITINFORMATIONSTORAGE()")
    func solveUnitSymbol() async throws {
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("bits")! == .bits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("nibbles")! == .nibbles)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("bytes")! == .bytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("kilobits")! == .kilobits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("megabits")! == .megabits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("gigabits")! == .gigabits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("terabits")! == .terabits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("petabits")! == .petabits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("exabits")! == .exabits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("zettabits")! == .zettabits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("yottabits")! == .yottabits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("kibibits")! == .kibibits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("mebibits")! == .mebibits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("gibibits")! == .gibibits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("tebibits")! == .tebibits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("pebibits")! == .pebibits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("exbibits")! == .exbibits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("zebibits")! == .zebibits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("yobibits")! == .yobibits)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("kilobytes")! == .kilobytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("megabytes")! == .megabytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("gigabytes")! == .gigabytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("terabytes")! == .terabytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("petabytes")! == .petabytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("exabytes")! == .exabytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("zettabytes")! == .zettabytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("yottabytes")! == .yottabytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("kibibytes")! == .kibibytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("mebibytes")! == .mebibytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("mebibytes")! == .mebibytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("gibibytes")! == .gibibytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("tebibytes")! == .tebibytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("pebibytes")! == .pebibytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("exbibytes")! == .exbibytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("zebibytes")! == .zebibytes)
        try #require(FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol("yobibytes")! == .yobibytes)
    }

    @Test("Definition of UNITINFORMATIONSTORAGE()")
    func validateInit() async throws {
        let f: FunctionUNITINFORMATIONSTORAGE = FunctionUNITINFORMATIONSTORAGE()
        #expect(f.id == FunctionIdentifier("FunctionUNITINFORMATIONSTORAGE"))
        #expect(f.symbols == ["UNITINFORMATIONSTORAGE"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "UNITINFORMATIONSTORAGE", parameters:[
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
        let f: FunctionUNITINFORMATIONSTORAGE = FunctionUNITINFORMATIONSTORAGE()
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
          "UNITINFORMATIONSTORAGE(10, 'bits')",
          "UNITINFORMATIONSTORAGE(var1, 'bytes')",
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
            "UNITINFORMATIONSTORAGE()",
            "UNITINFORMATIONSTORAGE(10, 'xx', 20)",
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
            "UNITINFORMATIONSTORAGE(NULL, 'murks')",
            "UNITINFORMATIONSTORAGE(20.0, \"murks\")",
            "UNITINFORMATIONSTORAGE(var1, var1)",
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
        let expression: String = "UNITINFORMATIONSTORAGE(100.0, \"bytes\")"
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
        #expect(evalValue.isUnitInformationStorage)
        #expect(evalValue.asUnitInformationStorage()! == Measurement<UnitInformationStorage>(value: 100.0, unit: .bytes))
    }

}
