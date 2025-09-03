//
//  FunctionUNITLENGTHTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function UNITLENGTH()")
class FunctionUNITLENGTHTests {

    @Test("solveUnitSymbol of UNITLENGTH()")
    func solveUnitSymbol() async throws {
        try #require(FunctionUNITLENGTH.solveUnitSymbol("Mm")! == .megameters)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("kM")! == .kilometers)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("hm")! == .hectometers)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("dam")! == .decameters)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("m")! == .meters)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("dm")! == .decimeters)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("cm")! == .centimeters)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("mm")! == .millimeters)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("µm")! == .micrometers)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("nm")! == .nanometers)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("pm")! == .picometers)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("in")! == .inches)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("ft")! == .feet)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("yd")! == .yards)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("mi")! == .miles)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("smi")! == .scandinavianMiles)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("ly")! == .lightyears)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("NM")! == .nauticalMiles)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("ftm")! == .fathoms)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("fur")! == .furlongs)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("ua")! == .astronomicalUnits)
        try #require(FunctionUNITLENGTH.solveUnitSymbol("pc")! == .parsecs)
    }

    @Test("Definition of UNITAREA()")
    func validateInit() async throws {
        let f: FunctionUNITLENGTH = FunctionUNITLENGTH()
        #expect(f.id == FunctionIdentifier("FunctionUNITLENGTH"))
        #expect(f.symbols == ["UNITLENGTH"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "UNITLENGTH", parameters:[
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
        let f: FunctionUNITLENGTH = FunctionUNITLENGTH()
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
          "UNITLENGTH(10, 'mm')",
          "UNITLENGTH(var1, 'ft')",
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
            "UNITLENGTH()",
            "UNITLENGTH(10, 'xx', 20)",
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
            "UNITLENGTH(NULL, 'murks')",
            "UNITLENGTH(20.0, \"murks\")",
            "UNITLENGTH(var1, var1)",
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
        let expression: String = "UNITLENGTH(100.0, \"mm\")"
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
        #expect(evalValue.isUnitLength)
        #expect(evalValue.asUnitLength()! == Measurement<UnitLength>(value: 100.0, unit: .millimeters))
    }

}
