//
//  FunctionUNITELECTRICPOTENTIALDIFFERENCETests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function UNITELECTRICCHARGE()")
class FunctionUNITELECTRICPOTENTIALDIFFERENCETests {

    @Test("solveUnitSymbol of UNITELECTRICRESISTENCE()")
    func solveUnitSymbol() async throws {
        try #require(FunctionUNITELECTRICPOTENTIALDIFFERENCE.solveUnitSymbol("MV")! == .megavolts)
        try #require(FunctionUNITELECTRICPOTENTIALDIFFERENCE.solveUnitSymbol("kV")! == .kilovolts)
        try #require(FunctionUNITELECTRICPOTENTIALDIFFERENCE.solveUnitSymbol("V")! == .volts)
        try #require(FunctionUNITELECTRICPOTENTIALDIFFERENCE.solveUnitSymbol("mV")! == .millivolts)
        try #require(FunctionUNITELECTRICPOTENTIALDIFFERENCE.solveUnitSymbol("µV")! == .microvolts)
    }

    @Test("Definition of UNITELECTRICRESISTENCE()")
    func validateInit() async throws {
        let f: FunctionUNITELECTRICPOTENTIALDIFFERENCE = FunctionUNITELECTRICPOTENTIALDIFFERENCE()
        #expect(f.id == FunctionIdentifier("FunctionUNITELECTRICPOTENTIALDIFFERENCE"))
        #expect(f.symbols == ["UNITELECTRICPOTENTIALDIFFERENCE"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "UNITELECTRICPOTENTIALDIFFERENCE", parameters:[
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
        let f: FunctionUNITELECTRICPOTENTIALDIFFERENCE = FunctionUNITELECTRICPOTENTIALDIFFERENCE()
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
          "UNITELECTRICPOTENTIALDIFFERENCE(10, 'MV')",
          "UNITELECTRICPOTENTIALDIFFERENCE(var1, 'kV')",
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
            "UNITELECTRICPOTENTIALDIFFERENCE()",
            "UNITELECTRICPOTENTIALDIFFERENCE(10, 'xx', 20)",
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
            "UNITELECTRICPOTENTIALDIFFERENCE(NULL, 'murks')",
            "UNITELECTRICPOTENTIALDIFFERENCE(20.0, \"murks\")",
            "UNITELECTRICPOTENTIALDIFFERENCE(var1, var1)",
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
        let expression: String = "UNITELECTRICPOTENTIALDIFFERENCE(100.0, \"V\")"
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
        #expect(evalValue.isUnitElectricPotentialDifference)
        #expect(evalValue.asUnitElectricPotentialDifference()! == Measurement<UnitElectricPotentialDifference>(value: 100.0, unit: .volts))
    }

}
