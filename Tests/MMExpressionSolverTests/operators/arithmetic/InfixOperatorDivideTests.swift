//
//  InfixOperatorDivideTests.swift
//  MMExpressionSolver
//

import Testing

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("InfixOperatorDivide")
class InfixOperatorDivideTests {

    @Test("Operator / definition")
    func operatorDefinition() async throws {
        let op: InfixOperatorDivide = InfixOperatorDivide()
        #expect(op.id == OperatorIdentifier("InfixOperatorDivide"))
        #expect(op.symbols == ["/"])
        #expect(op.definition.type == .infix)
        #expect(op.definition.precedence == .multiplicative)
        #expect(op.definition.isLeftAssociative == true)
        #expect(op.definition.isLazy == false)
        #expect(op.description.isEmpty == false)
        #expect(op.debugDescription.isEmpty == false)
    }

    @Test("Operator / evaluation")
    func evaluateOperator() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: InfixOperatorDivide = InfixOperatorDivide()
        var result: ExpressionValue = ExpressionValue.ofNil()
        // 01: nil * 20 = nil (nil/int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.ofNil(), ExpressionValue.of(20)
        ])
        print("01:result=\(result)")
        try #require(result.isNullValue == true)
        // 02: 15 * nil = nil (int/nil)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(15), ExpressionValue.ofNil()
        ])
        print("02:result=\(result)")
        try #require(result.isNullValue == true)
        // 03: 300 / 20 = 15 (int/int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(300), ExpressionValue.of(20)
        ])
        print("03:result=\(result)")
        try #require(result.isIntegerValue == true)
        try #require(result.asInteger() == 15)

        // 04: 300 / 20 = 15 (decimal/decimal)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Decimal(300)), ExpressionValue.of(Decimal(20))
        ])
        print("04:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(15))

        // 05: 300 / 20 = 15 (decimal/int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Decimal(300)), ExpressionValue.of(20)
        ])
        print("05:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(15))
        // 06: 300 / 20 = 15 (int/decimal)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(300), ExpressionValue.of(Decimal(20))
        ])
        print("06:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(15))
        // 07: UnitArea / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitArea>(value: 100.0, unit: .squareCentimeters)),
            ExpressionValue.of(2)
        ])
        print("07:result=\(result)")
        try #require(result.isUnitArea == true)
        try #require(result.asUnitArea() == Measurement<UnitArea>(value: 50.0, unit: .squareCentimeters))
        // 08: UnitLength / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitLength>(value: 100.0, unit: .kilometers)),
            ExpressionValue.of(2)
        ])
        print("08:result=\(result)")
        try #require(result.isUnitLength == true)
        try #require(result.asUnitLength() == Measurement<UnitLength>(value: 50.0, unit: .kilometers))
        // 09: UnitVolume / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitVolume>(value: 100.0, unit: .cubicMeters)),
            ExpressionValue.of(2)
        ])
        print("09:result=\(result)")
        try #require(result.isUnitVolume == true)
        try #require(result.asUnitVolume() == Measurement<UnitVolume>(value: 50.0, unit: .cubicMeters))
        // 10: UnitAngle / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitAngle>(value: 90.0, unit: .degrees)),
            ExpressionValue.of(2)
        ])
        print("10:result=\(result)")
        try #require(result.isUnitAngle == true)
        try #require(result.asUnitAngle() == Measurement<UnitAngle>(value: 45.0, unit: .degrees))
        // 11: scalar / UnitArea
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(200.0),
            ExpressionValue.of(Measurement<UnitArea>(value: 100.0, unit: .squareCentimeters))
        ])
        print("11:result=\(result)")
        try #require(result.isUnitArea == true)
        try #require(result.asUnitArea() == Measurement<UnitArea>(value: 2.0, unit: .squareCentimeters))
        // 12: scalar / UnitLength
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(200.0),
            ExpressionValue.of(Measurement<UnitLength>(value: 100.0, unit: .kilometers))
        ])
        print("12:result=\(result)")
        try #require(result.isUnitLength == true)
        try #require(result.asUnitLength() == Measurement<UnitLength>(value: 2.0, unit: .kilometers))
        // 13: scalar / UnitVolume
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(200.0),
            ExpressionValue.of(Measurement<UnitVolume>(value: 100.0, unit: .cubicMeters))
        ])
        print("13:result=\(result)")
        try #require(result.isUnitVolume == true)
        try #require(result.asUnitVolume() == Measurement<UnitVolume>(value: 2.0, unit: .cubicMeters))
        // 14: scalar / UnitAngle
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitAngle>(value: 90.0, unit: .degrees)),
        ])
        print("14:result=\(result)")
        try #require(result.isUnitAngle == true)
        try #require(result.asUnitAngle() == Measurement<UnitAngle>(value: 2.0, unit: .degrees))
        // 15: UnitMass / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitMass>(value: 180.0, unit: .kilograms)),
            ExpressionValue.of(90.0),
        ])
        print("15:result=\(result)")
        try #require(result.isUnitMass == true)
        try #require(result.asUnitMass() == Measurement<UnitMass>(value: 2.0, unit: .kilograms))
        // 16: scalar / UnitMass
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitMass>(value: 90.0, unit: .kilograms)),
        ])
        print("16:result=\(result)")
        try #require(result.isUnitMass == true)
        try #require(result.asUnitMass() == Measurement<UnitMass>(value: 2.0, unit: .kilograms))
        // 17: UnitPressure / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitPressure>(value: 180.0, unit: .bars)),
            ExpressionValue.of(90.0),
        ])
        print("17:result=\(result)")
        try #require(result.isUnitPressure == true)
        try #require(result.asUnitPressure() == Measurement<UnitPressure>(value: 2.0, unit: .bars))
        // 18: scalar / UnitPressure
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitPressure>(value: 90.0, unit: .bars)),
        ])
        print("18:result=\(result)")
        try #require(result.isUnitPressure == true)
        try #require(result.asUnitPressure() == Measurement<UnitPressure>(value: 2.0, unit: .bars))
        // 19: UnitAcceleration / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitAcceleration>(value: 180.0, unit: .metersPerSecondSquared)),
            ExpressionValue.of(90.0),
        ])
        print("19:result=\(result)")
        try #require(result.isUnitAcceleration == true)
        try #require(result.asUnitAcceleration() == Measurement<UnitAcceleration>(value: 2.0, unit: .metersPerSecondSquared))
        // 20: scalar / UnitAcceleration
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitAcceleration>(value: 90.0, unit: .metersPerSecondSquared)),
        ])
        print("20:result=\(result)")
        try #require(result.isUnitAcceleration == true)
        try #require(result.asUnitAcceleration() == Measurement<UnitAcceleration>(value: 2.0, unit: .metersPerSecondSquared))
        // 21: UnitDuration / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitDuration>(value: 180.0, unit: .seconds)),
            ExpressionValue.of(90.0),
        ])
        print("21:result=\(result)")
        try #require(result.isUnitDuration == true)
        try #require(result.asUnitDuration() == Measurement<UnitDuration>(value: 2.0, unit: .seconds))
        // 22: scalar / UnitDuration
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitDuration>(value: 90.0, unit: .seconds)),
        ])
        print("22:result=\(result)")
        try #require(result.isUnitDuration == true)
        try #require(result.asUnitDuration() == Measurement<UnitDuration>(value: 2.0, unit: .seconds))
        // 23: UnitFrequency / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitFrequency>(value: 180.0, unit: .hertz)),
            ExpressionValue.of(90.0),
        ])
        print("23:result=\(result)")
        try #require(result.isUnitFrequency == true)
        try #require(result.asUnitFrequency() == Measurement<UnitFrequency>(value: 2.0, unit: .hertz))
        // 24: scalar / UnitFrequency
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitFrequency>(value: 90.0, unit: .hertz)),
        ])
        print("24:result=\(result)")
        try #require(result.isUnitFrequency == true)
        try #require(result.asUnitFrequency() == Measurement<UnitFrequency>(value: 2.0, unit: .hertz))
        // 25: UnitSpeed / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitSpeed>(value: 180.0, unit: .knots)),
            ExpressionValue.of(90.0),
        ])
        print("25:result=\(result)")
        try #require(result.isUnitSpeed == true)
        try #require(result.asUnitSpeed() == Measurement<UnitSpeed>(value: 2.0, unit: .knots))
        // 26: scalar / UnitSpeed
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitSpeed>(value: 90.0, unit: .knots)),
        ])
        print("26:result=\(result)")
        try #require(result.isUnitSpeed == true)
        try #require(result.asUnitSpeed() == Measurement<UnitSpeed>(value: 2.0, unit: .knots))
        // 27: UnitEnergy / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitEnergy>(value: 180.0, unit: .kilowattHours)),
            ExpressionValue.of(90.0),
        ])
        print("27:result=\(result)")
        try #require(result.isUnitEnergy == true)
        try #require(result.asUnitEnergy() == Measurement<UnitEnergy>(value: 2.0, unit: .kilowattHours))
        // 28: scalar / UnitEnergy
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitEnergy>(value: 90.0, unit: .kilowattHours)),
        ])
        print("28:result=\(result)")
        try #require(result.isUnitEnergy == true)
        try #require(result.asUnitEnergy() == Measurement<UnitEnergy>(value: 2.0, unit: .kilowattHours))
        // 29: UnitPower / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitPower>(value: 180.0, unit: .watts)),
            ExpressionValue.of(90.0),
        ])
        print("29:result=\(result)")
        try #require(result.isUnitPower == true)
        try #require(result.asUnitPower() == Measurement<UnitPower>(value: 2.0, unit: .watts))
        // 30: scalar / UnitPower
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitPower>(value: 90.0, unit: .watts)),
        ])
        print("30:result=\(result)")
        try #require(result.isUnitPower == true)
        try #require(result.asUnitPower() == Measurement<UnitPower>(value: 2.0, unit: .watts))
        // 31: UnitTemperature / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitTemperature>(value: 180.0, unit: .kelvin)),
            ExpressionValue.of(90.0),
        ])
        print("31:result=\(result)")
        try #require(result.isUnitTemperatur == true)
        try #require(result.asUnitTemperature() == Measurement<UnitTemperature>(value: 2.0, unit: .kelvin))
        // 32: scalar / UnitTemperature
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitTemperature>(value: 90.0, unit: .kelvin)),
        ])
        print("32:result=\(result)")
        try #require(result.isUnitTemperatur == true)
        try #require(result.asUnitTemperature() == Measurement<UnitTemperature>(value: 2.0, unit: .kelvin))
        // 33: UnitIlluminance / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitIlluminance>(value: 180.0, unit: .lux)),
            ExpressionValue.of(90.0),
        ])
        print("33:result=\(result)")
        try #require(result.isUnitIlluminance == true)
        try #require(result.asUnitIlluminance() == Measurement<UnitIlluminance>(value: 2.0, unit: .lux))
        // 34: scalar / UnitIlluminance
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitIlluminance>(value: 90.0, unit: .lux)),
        ])
        print("34:result=\(result)")
        try #require(result.isUnitIlluminance == true)
        try #require(result.asUnitIlluminance() == Measurement<UnitIlluminance>(value: 2.0, unit: .lux))
        // 35: UnitElectricCharge / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitElectricCharge>(value: 180.0, unit: .ampereHours)),
            ExpressionValue.of(90.0),
        ])
        print("35:result=\(result)")
        try #require(result.isUnitElectricCharge == true)
        try #require(result.asUnitElectricCharge() == Measurement<UnitElectricCharge>(value: 2.0, unit: .ampereHours))
        // 36: scalar / UnitElectricCharge
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitElectricCharge>(value: 90.0, unit: .ampereHours)),
        ])
        print("36:result=\(result)")
        try #require(result.isUnitElectricCharge == true)
        try #require(result.asUnitElectricCharge() == Measurement<UnitElectricCharge>(value: 2.0, unit: .ampereHours))
        // 37: UnitElectricCurrent / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitElectricCurrent>(value: 180.0, unit: .amperes)),
            ExpressionValue.of(90.0),
        ])
        print("37:result=\(result)")
        try #require(result.isUnitElectricCurrent == true)
        try #require(result.asUnitElectricCurrent() == Measurement<UnitElectricCurrent>(value: 2.0, unit: .amperes))
        // 38: scalar / UnitElectricCurrent
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitElectricCurrent>(value: 90.0, unit: .amperes)),
        ])
        print("38:result=\(result)")
        try #require(result.isUnitElectricCurrent == true)
        try #require(result.asUnitElectricCurrent() == Measurement<UnitElectricCurrent>(value: 2.0, unit: .amperes))
        // 39: UnitElectricPotentialDifference / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitElectricPotentialDifference>(value: 180.0, unit: .kilovolts)),
            ExpressionValue.of(90.0),
        ])
        print("39:result=\(result)")
        try #require(result.isUnitElectricPotentialDifference == true)
        try #require(result.asUnitElectricPotentialDifference() == Measurement<UnitElectricPotentialDifference>(value: 2.0, unit: .kilovolts))
        // 40: scalar / UnitElectricPotentialDifference
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitElectricPotentialDifference>(value: 90.0, unit: .kilovolts)),
        ])
        print("40:result=\(result)")
        try #require(result.isUnitElectricPotentialDifference == true)
        try #require(result.asUnitElectricPotentialDifference() == Measurement<UnitElectricPotentialDifference>(value: 2.0, unit: .kilovolts))
        // 41: UnitElectricResistance / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitElectricResistance>(value: 180.0, unit: .kiloohms)),
            ExpressionValue.of(90.0),
        ])
        print("41:result=\(result)")
        try #require(result.isUnitElectricResistance == true)
        try #require(result.asUnitElectricResistence() == Measurement<UnitElectricResistance>(value: 2.0, unit: .kiloohms))
        // 42: scalar / UnitElectricResistance
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitElectricResistance>(value: 90.0, unit: .kiloohms)),
        ])
        print("42:result=\(result)")
        try #require(result.isUnitElectricResistance == true)
        try #require(result.asUnitElectricResistence() == Measurement<UnitElectricResistance>(value: 2.0, unit: .kiloohms))
        // 43: UnitConcentrationMass / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitConcentrationMass>(value: 180.0, unit: .gramsPerLiter)),
            ExpressionValue.of(90.0),
        ])
        print("43:result=\(result)")
        try #require(result.isUnitConcentrationMass == true)
        try #require(result.asUnitConcentrationMass() == Measurement<UnitConcentrationMass>(value: 2.0, unit: .gramsPerLiter))
        // 44: scalar / UnitConcentrationMass
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitConcentrationMass>(value: 90.0, unit: .gramsPerLiter)),
        ])
        print("44:result=\(result)")
        try #require(result.isUnitConcentrationMass == true)
        try #require(result.asUnitConcentrationMass() == Measurement<UnitConcentrationMass>(value: 2.0, unit: .gramsPerLiter))
        // 45: UnitDispersion / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitDispersion>(value: 180.0, unit: .partsPerMillion)),
            ExpressionValue.of(90.0),
        ])
        print("45:result=\(result)")
        try #require(result.isUnitDispersion == true)
        try #require(result.asUnitDispersion() == Measurement<UnitDispersion>(value: 2.0, unit: .partsPerMillion))
        // 46: scalar / UnitDispersion
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitDispersion>(value: 90.0, unit: .partsPerMillion)),
        ])
        print("46:result=\(result)")
        try #require(result.isUnitDispersion == true)
        try #require(result.asUnitDispersion() == Measurement<UnitDispersion>(value: 2.0, unit: .partsPerMillion))
        // 47: UnitFuelEfficiency / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitFuelEfficiency>(value: 180.0, unit: .litersPer100Kilometers)),
            ExpressionValue.of(90.0),
        ])
        print("47:result=\(result)")
        try #require(result.isUnitFuelEfficiency == true)
        try #require(result.asUnitFuelEfficiency() == Measurement<UnitFuelEfficiency>(value: 2.0, unit: .litersPer100Kilometers))
        // 48: scalar / UnitFuelEfficiency
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitFuelEfficiency>(value: 90.0, unit: .litersPer100Kilometers)),
        ])
        print("48:result=\(result)")
        try #require(result.isUnitFuelEfficiency == true)
        try #require(result.asUnitFuelEfficiency() == Measurement<UnitFuelEfficiency>(value: 2.0, unit: .litersPer100Kilometers))
        // 49: UnitInformationStorage / scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitInformationStorage>(value: 180.0, unit: .bits)),
            ExpressionValue.of(90.0),
        ])
        print("49:result=\(result)")
        try #require(result.isUnitInformationStorage == true)
        try #require(result.asUnitInformationStorage() == Measurement<UnitInformationStorage>(value: 2.0, unit: .bits))
        // 50: scalar / UnitInformationStorage
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(180.0),
            ExpressionValue.of(Measurement<UnitInformationStorage>(value: 90.0, unit: .bits)),
        ])
        print("50:result=\(result)")
        try #require(result.isUnitInformationStorage == true)
        try #require(result.asUnitInformationStorage() == Measurement<UnitInformationStorage>(value: 2.0, unit: .bits))
    }

    @Test("Operator 7 evaluation to fail")
    func evaluateOperatorToFail() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: InfixOperatorDivide = InfixOperatorDivide()
        // 01: Left operator is invalid
        let error1: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [ExpressionValue.of(true), ExpressionValue.of(200)])
        }
        print("01:error=\(String(describing: error1))")
        // 02: right operator is invalid
        let error2: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [ExpressionValue.of(100), ExpressionValue.of(true)])
        }
        print("02:error=\(String(describing: error2))")
        // 03: right operator is invalid (division zero)
        let error3: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [ExpressionValue.of(200), ExpressionValue.of(0)])
        }
        print("03:error=\(String(describing: error3))")
        // 04: right operator is invalid (division zero)
        let error4: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [ExpressionValue.of(200), ExpressionValue.of(Decimal(0))])
        }
        print("04:error=\(String(describing: error4))")
        // 05: right operator is invalid (division zero)
        let error5: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
                ExpressionValue.of(Measurement<UnitArea>(value: 100.0, unit: .squareCentimeters)),
                ExpressionValue.of(Decimal(0))
            ])
        }
        print("05:error=\(String(describing: error5))")
        // 06: right operator is invalid (division zero)
        let error6: ExpressionError? = try #require(throws: ExpressionError.self) {
            try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
                ExpressionValue.of(Decimal(100)),
                ExpressionValue.of(Measurement<UnitArea>(value: 0.0, unit: .squareCentimeters)),
            ])
        }
        print("06:error=\(String(describing: error6))")
    }

}
