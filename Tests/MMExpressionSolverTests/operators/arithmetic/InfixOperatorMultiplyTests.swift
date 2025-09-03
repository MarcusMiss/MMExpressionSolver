//
//  InfixOperatorMultiplyTests.swift
//  MMExpressionSolver
//

import Testing

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("InfixOperatorMultiply")
class InfixOperatorMultiplyTests {

    @Test("Operator * definition")
    func operatorDefinition() async throws {
        let op: InfixOperatorMultiply = InfixOperatorMultiply()
        #expect(op.id == OperatorIdentifier("InfixOperatorMultiply"))
        #expect(op.symbols == ["*"])
        #expect(op.definition.type == .infix)
        #expect(op.definition.precedence == .multiplicative)
        #expect(op.definition.isLeftAssociative == true)
        #expect(op.definition.isLazy == false)
        #expect(op.description.isEmpty == false)
        #expect(op.debugDescription.isEmpty == false)
    }

    @Test("Operator * evaluation")
    func evaluateOperator() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: InfixOperatorMultiply = InfixOperatorMultiply()
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
        // 03: 15 * 20 = 300 (int/int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(15), ExpressionValue.of(20)
        ])
        print("03:result=\(result)")
        try #require(result.isIntegerValue == true)
        try #require(result.asInteger() == 300)
        // 04: 15 * 20 = 300 (decimal/decimal)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Decimal(15)), ExpressionValue.of(Decimal(20))
        ])
        print("04:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(300))
        // 05: 15 * 20 = 300 (decimal/int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Decimal(15)), ExpressionValue.of(20)
        ])
        print("05:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(300))
        // 06: 15 * 20 = 300 (int/decimal)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(15), ExpressionValue.of(Decimal(20))
        ])
        print("06:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(300))
        // 07: UnitArea * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitArea>(value: 100.0, unit: .squareCentimeters)),
            ExpressionValue.of(2)
        ])
        print("07:result=\(result)")
        try #require(result.isUnitArea == true)
        try #require(result.asUnitArea() == Measurement<UnitArea>(value: 200.0, unit: .squareCentimeters))
        // 08: UnitLength * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitLength>(value: 100.0, unit: .kilometers)),
            ExpressionValue.of(2)
        ])
        print("08:result=\(result)")
        try #require(result.isUnitLength == true)
        try #require(result.asUnitLength() == Measurement<UnitLength>(value: 200.0, unit: .kilometers))
        // 09: UnitVolume * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitVolume>(value: 100.0, unit: .cubicMeters)),
            ExpressionValue.of(2)
        ])
        print("09:result=\(result)")
        try #require(result.isUnitVolume == true)
        try #require(result.asUnitVolume() == Measurement<UnitVolume>(value: 200.0, unit: .cubicMeters))
        // 10: UnitAngle * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitAngle>(value: 90.0, unit: .degrees)),
            ExpressionValue.of(2)
        ])
        print("10:result=\(result)")
        try #require(result.isUnitAngle == true)
        try #require(result.asUnitAngle() == Measurement<UnitAngle>(value: 180.0, unit: .degrees))
        // 11: scalar * UnitArea
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitArea>(value: 100.0, unit: .squareCentimeters))
        ])
        print("11:result=\(result)")
        try #require(result.isUnitArea == true)
        try #require(result.asUnitArea() == Measurement<UnitArea>(value: 200.0, unit: .squareCentimeters))
        // 12: scalar * UnitLength
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitLength>(value: 100.0, unit: .kilometers))
        ])
        print("12:result=\(result)")
        try #require(result.isUnitLength == true)
        try #require(result.asUnitLength() == Measurement<UnitLength>(value: 200.0, unit: .kilometers))
        // 13: scalar * UnitVolume
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitVolume>(value: 100.0, unit: .cubicMeters))
        ])
        print("13:result=\(result)")
        try #require(result.isUnitVolume == true)
        try #require(result.asUnitVolume() == Measurement<UnitVolume>(value: 200.0, unit: .cubicMeters))
        // 14: scalar * UnitAngle
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitAngle>(value: 90.0, unit: .degrees)),
        ])
        print("14:result=\(result)")
        try #require(result.isUnitAngle == true)
        try #require(result.asUnitAngle() == Measurement<UnitAngle>(value: 180.0, unit: .degrees))
        // 15: scalar * UnitMass
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitMass>(value: 90.0, unit: .kilograms)),
        ])
        print("15:result=\(result)")
        try #require(result.isUnitMass == true)
        try #require(result.asUnitMass() == Measurement<UnitMass>(value: 180.0, unit: .kilograms))
        // 16: UnitMass * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitMass>(value: 90.0, unit: .kilograms)),
            ExpressionValue.of(2),
        ])
        print("16:result=\(result)")
        try #require(result.isUnitMass == true)
        try #require(result.asUnitMass() == Measurement<UnitMass>(value: 180.0, unit: .kilograms))
        // 17: scalar * UnitPressure
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitPressure>(value: 90.0, unit: .bars)),
        ])
        print("17:result=\(result)")
        try #require(result.isUnitPressure == true)
        try #require(result.asUnitPressure() == Measurement<UnitPressure>(value: 180.0, unit: .bars))
        // 18: UnitPressure * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitPressure>(value: 90.0, unit: .bars)),
            ExpressionValue.of(2),
        ])
        print("18:result=\(result)")
        try #require(result.isUnitPressure == true)
        try #require(result.asUnitPressure() == Measurement<UnitPressure>(value: 180.0, unit: .bars))
        // 19: UnitAcceleration * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitAcceleration>(value: 90.0, unit: .metersPerSecondSquared)),
            ExpressionValue.of(2),
        ])
        print("19:result=\(result)")
        try #require(result.isUnitAcceleration == true)
        try #require(result.asUnitAcceleration() == Measurement<UnitAcceleration>(value: 180.0, unit: .metersPerSecondSquared))
        // 20: scalar * UnitAcceleration
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitAcceleration>(value: 90.0, unit: .metersPerSecondSquared)),
        ])
        print("20:result=\(result)")
        try #require(result.isUnitAcceleration == true)
        try #require(result.asUnitAcceleration() == Measurement<UnitAcceleration>(value: 180.0, unit: .metersPerSecondSquared))
        // 21: UnitDuration * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitDuration>(value: 90.0, unit: .seconds)),
            ExpressionValue.of(2),
        ])
        print("21:result=\(result)")
        try #require(result.isUnitDuration == true)
        try #require(result.asUnitDuration() == Measurement<UnitDuration>(value: 180.0, unit: .seconds))
        // 22: scalar * UnitDuration
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitDuration>(value: 90.0, unit: .seconds)),
        ])
        print("22:result=\(result)")
        try #require(result.isUnitDuration == true)
        try #require(result.asUnitDuration() == Measurement<UnitDuration>(value: 180.0, unit: .seconds))
        // 23: UnitFrequency * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitFrequency>(value: 90.0, unit: .hertz)),
            ExpressionValue.of(2),
        ])
        print("23:result=\(result)")
        try #require(result.isUnitFrequency == true)
        try #require(result.asUnitFrequency() == Measurement<UnitFrequency>(value: 180.0, unit: .hertz))
        // 24: scalar * UnitFrequency
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitFrequency>(value: 90.0, unit: .hertz)),
        ])
        print("24:result=\(result)")
        try #require(result.isUnitFrequency == true)
        try #require(result.asUnitFrequency() == Measurement<UnitFrequency>(value: 180.0, unit: .hertz))
        // 25: UnitSpeed * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitSpeed>(value: 90.0, unit: .knots)),
            ExpressionValue.of(2),
        ])
        print("25:result=\(result)")
        try #require(result.isUnitSpeed == true)
        try #require(result.asUnitSpeed() == Measurement<UnitSpeed>(value: 180.0, unit: .knots))
        // 26: scalar * UnitSpeed
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitSpeed>(value: 90.0, unit: .knots)),
        ])
        print("26:result=\(result)")
        try #require(result.isUnitSpeed == true)
        try #require(result.asUnitSpeed() == Measurement<UnitSpeed>(value: 180.0, unit: .knots))
        // 27: UnitEnergy * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitEnergy>(value: 90.0, unit: .kilowattHours)),
            ExpressionValue.of(2),
        ])
        print("27:result=\(result)")
        try #require(result.isUnitEnergy == true)
        try #require(result.asUnitEnergy() == Measurement<UnitEnergy>(value: 180.0, unit: .kilowattHours))
        // 28: scalar * UnitEnergy
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitEnergy>(value: 90.0, unit: .kilowattHours)),
        ])
        print("28:result=\(result)")
        try #require(result.isUnitEnergy == true)
        try #require(result.asUnitEnergy() == Measurement<UnitEnergy>(value: 180.0, unit: .kilowattHours))
        // 29: UnitPower * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitPower>(value: 90.0, unit: .watts)),
            ExpressionValue.of(2),
        ])
        print("29:result=\(result)")
        try #require(result.isUnitPower == true)
        try #require(result.asUnitPower() == Measurement<UnitPower>(value: 180.0, unit: .watts))
        // 30: scalar * UnitPower
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitPower>(value: 90.0, unit: .watts)),
        ])
        print("30:result=\(result)")
        try #require(result.isUnitPower == true)
        try #require(result.asUnitPower() == Measurement<UnitPower>(value: 180.0, unit: .watts))
        // 31: UnitTemperature * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitTemperature>(value: 90.0, unit: .celsius)),
            ExpressionValue.of(2),
        ])
        print("31:result=\(result)")
        try #require(result.isUnitTemperatur == true)
        try #require(result.asUnitTemperature() == Measurement<UnitTemperature>(value: 180.0, unit: .celsius))
        // 32: scalar * UnitTemperature
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitTemperature>(value: 90.0, unit: .celsius)),
        ])
        print("32:result=\(result)")
        try #require(result.isUnitTemperatur == true)
        try #require(result.asUnitTemperature() == Measurement<UnitTemperature>(value: 180.0, unit: .celsius))
        // 33: UnitIlluminance * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitIlluminance>(value: 90.0, unit: .lux)),
            ExpressionValue.of(2),
        ])
        print("33:result=\(result)")
        try #require(result.isUnitIlluminance == true)
        try #require(result.asUnitIlluminance() == Measurement<UnitIlluminance>(value: 180.0, unit: .lux))
        // 34: scalar * UnitIlluminance
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitIlluminance>(value: 90.0, unit: .lux)),
        ])
        print("34:result=\(result)")
        try #require(result.isUnitIlluminance == true)
        try #require(result.asUnitIlluminance() == Measurement<UnitIlluminance>(value: 180.0, unit: .lux))
        // 35: UnitElectricCharge * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitElectricCharge>(value: 90.0, unit: .ampereHours)),
            ExpressionValue.of(2),
        ])
        print("35:result=\(result)")
        try #require(result.isUnitElectricCharge == true)
        try #require(result.asUnitElectricCharge() == Measurement<UnitElectricCharge>(value: 180.0, unit: .ampereHours))
        // 36: scalar * UnitElectricCharge
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitElectricCharge>(value: 90.0, unit: .ampereHours)),
        ])
        print("36:result=\(result)")
        try #require(result.isUnitElectricCharge == true)
        try #require(result.asUnitElectricCharge() == Measurement<UnitElectricCharge>(value: 180.0, unit: .ampereHours))
        // 37: UnitElectricCurrent * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitElectricCurrent>(value: 90.0, unit: .amperes)),
            ExpressionValue.of(2),
        ])
        print("37:result=\(result)")
        try #require(result.isUnitElectricCurrent == true)
        try #require(result.asUnitElectricCurrent() == Measurement<UnitElectricCurrent>(value: 180.0, unit: .amperes))
        // 38: scalar * UnitElectricCurrent
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitElectricCurrent>(value: 90.0, unit: .amperes)),
        ])
        print("38:result=\(result)")
        try #require(result.isUnitElectricCurrent == true)
        try #require(result.asUnitElectricCurrent() == Measurement<UnitElectricCurrent>(value: 180.0, unit: .amperes))
        // 39: UnitElectricCurrent * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitElectricPotentialDifference>(value: 90.0, unit: .volts)),
            ExpressionValue.of(2),
        ])
        print("39:result=\(result)")
        try #require(result.isUnitElectricPotentialDifference == true)
        try #require(result.asUnitElectricPotentialDifference() == Measurement<UnitElectricPotentialDifference>(value: 180.0, unit: .volts))
        // 40: scalar * UnitElectricCurrent
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitElectricPotentialDifference>(value: 90.0, unit: .volts)),
        ])
        print("40:result=\(result)")
        try #require(result.isUnitElectricPotentialDifference == true)
        try #require(result.asUnitElectricPotentialDifference() == Measurement<UnitElectricPotentialDifference>(value: 180.0, unit: .volts))
        // 41: UnitElectricPotentialDifference * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitElectricPotentialDifference>(value: 90.0, unit: .volts)),
            ExpressionValue.of(2),
        ])
        print("41:result=\(result)")
        try #require(result.isUnitElectricPotentialDifference == true)
        try #require(result.asUnitElectricPotentialDifference() == Measurement<UnitElectricPotentialDifference>(value: 180.0, unit: .volts))
        // 42: scalar * UnitElectricPotentialDifference
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitElectricPotentialDifference>(value: 90.0, unit: .volts)),
        ])
        print("42:result=\(result)")
        try #require(result.isUnitElectricPotentialDifference == true)
        try #require(result.asUnitElectricPotentialDifference() == Measurement<UnitElectricPotentialDifference>(value: 180.0, unit: .volts))
        // 43: UnitElectricResistance * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitElectricResistance>(value: 90.0, unit: .ohms)),
            ExpressionValue.of(2),
        ])
        print("43:result=\(result)")
        try #require(result.isUnitElectricResistance == true)
        try #require(result.asUnitElectricResistence() == Measurement<UnitElectricResistance>(value: 180.0, unit: .ohms))
        // 44: scalar * UnitElectricResistance
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitElectricResistance>(value: 90.0, unit: .ohms)),
        ])
        print("44:result=\(result)")
        try #require(result.isUnitElectricResistance == true)
        try #require(result.asUnitElectricResistence() == Measurement<UnitElectricResistance>(value: 180.0, unit: .ohms))
        // 45: UnitConcentrationMass * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitConcentrationMass>(value: 90.0, unit: .gramsPerLiter)),
            ExpressionValue.of(2),
        ])
        print("45:result=\(result)")
        try #require(result.isUnitConcentrationMass == true)
        try #require(result.asUnitConcentrationMass() == Measurement<UnitConcentrationMass>(value: 180.0, unit: .gramsPerLiter))
        // 46: scalar * UnitConcentrationMass
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitConcentrationMass>(value: 90.0, unit: .gramsPerLiter)),
        ])
        print("46:result=\(result)")
        try #require(result.isUnitConcentrationMass == true)
        try #require(result.asUnitConcentrationMass() == Measurement<UnitConcentrationMass>(value: 180.0, unit: .gramsPerLiter))
        // 47: UnitDispersion * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitDispersion>(value: 90.0, unit: .partsPerMillion)),
            ExpressionValue.of(2),
        ])
        print("47:result=\(result)")
        try #require(result.isUnitDispersion == true)
        try #require(result.asUnitDispersion() == Measurement<UnitDispersion>(value: 180.0, unit: .partsPerMillion))
        // 48: scalar * UnitDispersion
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitDispersion>(value: 90.0, unit: .partsPerMillion)),
        ])
        print("48:result=\(result)")
        try #require(result.isUnitDispersion == true)
        try #require(result.asUnitDispersion() == Measurement<UnitDispersion>(value: 180.0, unit: .partsPerMillion))
        // 49: UnitFuelEfficiency * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitFuelEfficiency>(value: 90.0, unit: .litersPer100Kilometers)),
            ExpressionValue.of(2),
        ])
        print("49:result=\(result)")
        try #require(result.isUnitFuelEfficiency == true)
        try #require(result.asUnitFuelEfficiency() == Measurement<UnitFuelEfficiency>(value: 180.0, unit: .litersPer100Kilometers))
        // 50: scalar * UnitFuelEfficiency
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitFuelEfficiency>(value: 90.0, unit: .litersPer100Kilometers)),
        ])
        print("50:result=\(result)")
        try #require(result.isUnitFuelEfficiency == true)
        try #require(result.asUnitFuelEfficiency() == Measurement<UnitFuelEfficiency>(value: 180.0, unit: .litersPer100Kilometers))
        // 51: UnitInformationStorage * scalar
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitInformationStorage>(value: 90.0, unit: .bits)),
            ExpressionValue.of(2),
        ])
        print("51:result=\(result)")
        try #require(result.isUnitInformationStorage == true)
        try #require(result.asUnitInformationStorage() == Measurement<UnitInformationStorage>(value: 180.0, unit: .bits))
        // 52: scalar * UnitInformationStorage
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(2),
            ExpressionValue.of(Measurement<UnitInformationStorage>(value: 90.0, unit: .bits)),
        ])
        print("52:result=\(result)")
        try #require(result.isUnitInformationStorage == true)
        try #require(result.asUnitInformationStorage() == Measurement<UnitInformationStorage>(value: 180.0, unit: .bits))
    }

    @Test("Operator * evaluation to fail")
    func evaluateOperatorToFail() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: InfixOperatorMultiply = InfixOperatorMultiply()
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
    }

}
