//
//  FunctionUNITVOLUMETests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function UNITVOLUME()")
class FunctionUNITVOLUMETests {

    @Test("solveUnitSymbol of UNITAREA()")
    func solveUnitSymbol() async throws {
        try #require(FunctionUNITVOLUME.solveUnitSymbol("ML")! == .megaliters)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("kL")! == .kiloliters)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("L")! == .liters)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("dL")! == .deciliters)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("cL")! == .centiliters)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("mL")! == .milliliters)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("km³")! == .cubicKilometers)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("m³")! == .cubicMeters)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("dm³")! == .cubicDecimeters)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("cm³")! == .cubicCentimeters)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("mm³")! == .cubicMillimeters)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("in³")! == .cubicInches)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("ft³")! == .cubicFeet)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("yd³")! == .cubicYards)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("mi³")! == .cubicMiles)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("af")! == .acreFeet)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("bsh")! == .bushels)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("tsp")! == .teaspoons)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("tbsp")! == .tablespoons)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("fl oz")! == .fluidOunces)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("cup")! == .cups)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("pt")! == .pints)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("qt")! == .quarts)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("gal")! == .gallons)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("metric cup")! == .metricCups)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("imp.tsp")! == .imperialTeaspoons)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("imp.tbsp")! == .imperialTablespoons)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("imp.fl oz")! == .imperialFluidOunces)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("imp.pt")! == .imperialPints)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("imp.qt")! == .imperialQuarts)
        try #require(FunctionUNITVOLUME.solveUnitSymbol("imp.gal")! == .imperialGallons)
    }

    @Test("Definition of UNITVOLUME()")
    func validateInit() async throws {
        let f: FunctionUNITVOLUME = FunctionUNITVOLUME()
        #expect(f.id == FunctionIdentifier("FunctionUNITVOLUME"))
        #expect(f.symbols == ["UNITVOLUME"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "UNITVOLUME", parameters:[
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
        let f: FunctionUNITVOLUME = FunctionUNITVOLUME()
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
          "UNITVOLUME(10, 'cm³')",
          "UNITVOLUME(var1, 'ft³')",
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
            "UNITVOLUME()",
            "UNITVOLUME(10, 'xx', 20)",
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
            "UNITVOLUME(NULL, 'murks')",
            "UNITVOLUME(20.0, \"murks\")",
            "UNITVOLUME(var1, var1)",
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
        let expression: String = "UNITVOLUME(100.0, \"m³\")"
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
        #expect(evalValue.isUnitVolume)
        #expect(evalValue.asUnitVolume()! == Measurement<UnitVolume>(value: 100.0, unit: .cubicMeters))
    }

}
