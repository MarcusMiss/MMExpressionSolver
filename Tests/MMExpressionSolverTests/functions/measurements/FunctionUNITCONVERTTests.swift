//
//  FunctionUNITCONVERTTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("Function UNITCONVERT()")
class FunctionUNITCONVERTTests {

    @Test("Definition of UNITANGLE()")
    func validateInit() async throws {
        let f: FunctionUNITCONVERT = FunctionUNITCONVERT()
        #expect(f.id == FunctionIdentifier("FunctionUNITCONVERT"))
        #expect(f.symbols == ["UNITCONVERT"])
        #expect(f.definition == ExpressionFunctionDefinition(name: "UNITCONVERT", parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [
                                            .measurement(unit: .unitAcceleration),
                                            .measurement(unit: .unitAngle),
                                            .measurement(unit: .unitArea),
                                            .measurement(unit: .unitConcentrationMass),
                                            .measurement(unit: .unitDispersion),
                                            .measurement(unit: .unitDuration),
                                            .measurement(unit: .unitElectricCharge),
                                            .measurement(unit: .unitElectricCurrent),
                                            .measurement(unit: .unitElectricPotentialDifference),
                                            .measurement(unit: .unitElectricalResistance),
                                            .measurement(unit: .unitEnergy),
                                            .measurement(unit: .unitFrequency),
                                            .measurement(unit: .unitFuelEfficiency),
                                            .measurement(unit: .unitIlluminance),
                                            .measurement(unit: .unitInformationStorage),
                                            .measurement(unit: .unitLength),
                                            .measurement(unit: .unitMass),
                                            .measurement(unit: .unitPower),
                                            .measurement(unit: .unitPressure),
                                            .measurement(unit: .unitSpeed),
                                            .measurement(unit: .unitTemperature),
                                            .measurement(unit: .unitVolume),
                                        ]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameUnit,
                                        strictTypes: [.string],)
        ]))
        print("description: \"\(f.description)\"")
        print("debugDescription: \"\(f.debugDescription)\"")
        #expect(f.description.isEmpty == false)
        #expect(f.debugDescription.isEmpty == false)
    }

    @Test("Function evaluation in expression-context",
        arguments: [
            "UNITCONVERT( UNITANGLE(100.0, 'rad'), '°')",
            "UNITCONVERT( UNITENERGY(100.0, 'kCal'), 'kWh')",
            "UNITCONVERT( UNITACCELERATION(100.0, 'm/s²'), 'm/s²')",
            "UNITCONVERT( UNITAREA(100.0, 'km²'), 'm²')",
            "UNITCONVERT( UNITCONCENTRATIONMASS(100.0, 'g/L'), 'mg/dL')",
            "UNITCONVERT( UNITDISPERSION(100.0, 'ppm'), 'ppm')",
            "UNITCONVERT( UNITDURATION(100.0, 'sec'), 'min')",
            "UNITCONVERT( UNITELECTRICCHARGE(100.0, 'MAh'), 'kAh')",
            "UNITCONVERT( UNITELECTRICCURRENT(100.0, 'A'), 'kA')",
            "UNITCONVERT( UNITELECTRICPOTENTIALDIFFERENCE(100.0, 'V'), 'kV')",
            "UNITCONVERT( UNITELECTRICRESISTENCE(100.0, 'kΩ'), 'Ω')",
            "UNITCONVERT( UNITFREQUENCY(100.0, 'kHz'), 'Hz')",
            "UNITCONVERT( UNITFUELEFFICIENCY(100.0, 'mpg'), 'L/100km')",
            "UNITCONVERT( UNITILLUMINANCE(100.0, 'lx'), 'lx')",
            "UNITCONVERT( UNITINFORMATIONSTORAGE(100.0, 'bytes'), 'bits')",
            "UNITCONVERT( UNITLENGTH(100.0, 'cm'), 'mm')",
            "UNITCONVERT( UNITMASS(100.0, 'kg'), 'g')",
            "UNITCONVERT( UNITPOWER(100.0, 'W'), 'mW')",
            "UNITCONVERT( UNITPRESSURE(100.0, 'kPa'), 'bar')",
            "UNITCONVERT( UNITSPEED(100.0, 'm/s'), 'km/h')",
            "UNITCONVERT( UNITTEMPERATURE(100.0, '°C'), '°F')",
            "UNITCONVERT( UNITVOLUME(100.0, 'm³'), 'cm³')",
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
            "UNITCONVERT()",
            "UNITCONVERT(10, 'xx', 20)",
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
            "UNITCONVERT( UNITANGLE(100.0, 'rad'), 'murks')",
            "UNITCONVERT( UNITENERGY(100.0, 'kCal'), 'murks')",
            "UNITCONVERT( UNITACCELERATION(100.0, 'm/s²'), 'murks')",
            "UNITCONVERT( UNITAREA(100.0, 'km²'), 'murks')",
            "UNITCONVERT( UNITCONCENTRATIONMASS(100.0, 'g/L'), 'murks')",
            "UNITCONVERT( UNITDISPERSION(100.0, 'ppm'), 'murks')",
            "UNITCONVERT( UNITDURATION(100.0, 'sec'), 'murks')",
            "UNITCONVERT( UNITELECTRICCHARGE(100.0, 'MAh'), 'murks')",
            "UNITCONVERT( UNITELECTRICCURRENT(100.0, 'A'), 'murks')",
            "UNITCONVERT( UNITELECTRICPOTENTIALDIFFERENCE(100.0, 'V'), 'murks')",
            "UNITCONVERT( UNITELECTRICRESISTENCE(100.0, 'kΩ'), 'murks')",
            "UNITCONVERT( UNITFREQUENCY(100.0, 'kHz'), 'murks')",
            "UNITCONVERT( UNITFUELEFFICIENCY(100.0, 'mpg'), 'murks')",
            "UNITCONVERT( UNITILLUMINANCE(100.0, 'lx'), 'murks')",
            "UNITCONVERT( UNITINFORMATIONSTORAGE(100.0, 'bytes'), 'murks')",
            "UNITCONVERT( UNITLENGTH(100.0, 'cm'), 'murks')",
            "UNITCONVERT( UNITMASS(100.0, 'kg'), 'murks')",
            "UNITCONVERT( UNITPOWER(100.0, 'W'), 'murks')",
            "UNITCONVERT( UNITPRESSURE(100.0, 'kPa'), 'murks')",
            "UNITCONVERT( UNITSPEED(100.0, 'm/s'), 'murks')",
            "UNITCONVERT( UNITTEMPERATURE(100.0, '°C'), 'murks')",
            "UNITCONVERT( UNITVOLUME(100.0, 'm³'), 'murks')",
            "UNITCONVERT( UNITVOLUME(100.0, 'm³'), var1)",
            "UNITCONVERT( 'murks', 'murks')",
        ]
    )
    func evaluateInExpressionWithFailure2(expressionSource: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        context.variables.storeVariable(identifier: "var1", value: ExpressionValue.ofNil())
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
        let f: FunctionUNITCONVERT = FunctionUNITCONVERT()
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

}
