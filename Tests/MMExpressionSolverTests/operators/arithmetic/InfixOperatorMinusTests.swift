//
//  InfixOperatorMinusTests.swift
//  MMExpressionSolver
//

import Testing

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("InfixOperatorMinus")
class InfixOperatorMinusTests {

    @Test("Operator - definition")
    func operatorDefinition() async throws {
        let op: InfixOperatorMinus = InfixOperatorMinus()
        #expect(op.id == OperatorIdentifier("InfixOperatorMinus"))
        #expect(op.symbols == ["-"])
        #expect(op.definition.type == .infix)
        #expect(op.definition.precedence == .additive)
        #expect(op.definition.isLeftAssociative == true)
        #expect(op.definition.isLazy == false)
        #expect(op.description.isEmpty == false)
        #expect(op.debugDescription.isEmpty == false)
    }

    @Test("Operator - evaluation")
    func evaluateOperator() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: InfixOperatorMinus = InfixOperatorMinus()
        var result: ExpressionValue = ExpressionValue.ofNil()
        // 01: nil - 200 = nil (nil/int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.ofNil(), ExpressionValue.of(200)
        ])
        print("01:result=\(result)")
        try #require(result.isNullValue == true)
        // 02: 300 - nil = nil (int/nil)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(300), ExpressionValue.ofNil()
        ])
        print("02:result=\(result)")
        try #require(result.isNullValue == true)
        // 03: 300 - 200 = 100 (int/int)
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(300), ExpressionValue.of(200)
        ])
        print("03:result=\(result)")
        try #require(result.isIntegerValue == true)
        try #require(result.asInteger() == 100)
        // 04: 300 - 200 = 100 (decimal/decimal))
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Decimal(300)), ExpressionValue.of(Decimal(200))
        ])
        print("04:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(100))
        // 05: 300 - 200 = 100 (decimal/int))
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Decimal(300)), ExpressionValue.of(200)
        ])
        print("05:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(100))
        //0 6: 300 - 200 = 100 (int/decimal))
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(300), ExpressionValue.of(Decimal(200))
        ])
        print("06:result=\(result)")
        try #require(result.isDecimalValue == true)
        try #require(result.asDecimal() == Decimal(100))
        // 07: UnitArea - UnitArea
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitArea>(value: 300, unit: .squareCentimeters)),
            ExpressionValue.of(Measurement<UnitArea>(value: 200.0, unit: .squareCentimeters))
        ])
        print("07:result=\(result)")
        try #require(result.isUnitArea == true)
        try #require(result.asUnitArea() == Measurement<UnitArea>(value: 100, unit: .squareCentimeters))
        // 08: UnitLength - UnitLength
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitLength>(value: 300.0, unit: .kilometers)),
            ExpressionValue.of(Measurement<UnitLength>(value: 200.0, unit: .kilometers))
        ])
        print("08:result=\(result)")
        try #require(result.isUnitLength == true)
        try #require(result.asUnitLength() == Measurement<UnitLength>(value: 100.0, unit: .kilometers))
        // 09: UnitVolume - UnitVolume
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitVolume>(value: 300.0, unit: .cubicMeters)),
            ExpressionValue.of(Measurement<UnitVolume>(value: 200.0, unit: .cubicMeters))
        ])
        print("09:result=\(result)")
        try #require(result.isUnitVolume == true)
        try #require(result.asUnitVolume() == Measurement<UnitVolume>(value: 100.0, unit: .cubicMeters))
        // 10: UnitAngle - UnitAngle
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitAngle>(value: 270.0, unit: .degrees)),
            ExpressionValue.of(Measurement<UnitAngle>(value: 180.0, unit: .degrees))
        ])
        print("10:result=\(result)")
        try #require(result.isUnitAngle == true)
        try #require(result.asUnitAngle() == Measurement<UnitAngle>(value: 90.0, unit: .degrees))
        // 11: UnitMass - UnitMass
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitMass>(value: 270.0, unit: .kilograms)),
            ExpressionValue.of(Measurement<UnitMass>(value: 180.0, unit: .kilograms))
        ])
        print("11:result=\(result)")
        try #require(result.isUnitMass == true)
        try #require(result.asUnitMass() == Measurement<UnitMass>(value: 90.0, unit: .kilograms))
        // 12: UnitPressure - UnitPressure
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitPressure>(value: 270.0, unit: .bars)),
            ExpressionValue.of(Measurement<UnitPressure>(value: 180.0, unit: .bars))
        ])
        print("12:result=\(result)")
        try #require(result.isUnitPressure == true)
        try #require(result.asUnitPressure() == Measurement<UnitPressure>(value: 90.0, unit: .bars))
        // 13: UnitAcceleration - UnitAcceleration
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitAcceleration>(value: 270.0, unit: .metersPerSecondSquared)),
            ExpressionValue.of(Measurement<UnitAcceleration>(value: 180.0, unit: .metersPerSecondSquared)),
        ])
        print("13:result=\(result)")
        try #require(result.isUnitAcceleration == true)
        try #require(result.asUnitAcceleration() == Measurement<UnitAcceleration>(value: 90.0, unit: .metersPerSecondSquared))
        // 14: UnitDuration - UnitDuration
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitDuration>(value: 270.0, unit: .seconds)),
            ExpressionValue.of(Measurement<UnitDuration>(value: 180.0, unit: .seconds)),
        ])
        print("14:result=\(result)")
        try #require(result.isUnitDuration == true)
        try #require(result.asUnitDuration() == Measurement<UnitDuration>(value: 90.0, unit: .seconds))
        // 15: UnitFrequency - UnitFrequency
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitFrequency>(value: 270.0, unit: .hertz)),
            ExpressionValue.of(Measurement<UnitFrequency>(value: 180, unit: .hertz)),
        ])
        print("15:result=\(result)")
        try #require(result.isUnitFrequency == true)
        try #require(result.asUnitFrequency() == Measurement<UnitFrequency>(value: 90.0, unit: .hertz))
        // 16: UnitFrequency - UnitFrequency
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitSpeed>(value: 270.0, unit: .knots)),
            ExpressionValue.of(Measurement<UnitSpeed>(value: 180.0, unit: .knots)),
        ])
        print("16:result=\(result)")
        try #require(result.isUnitSpeed == true)
        try #require(result.asUnitSpeed() == Measurement<UnitSpeed>(value: 90.0, unit: .knots))
        // 17: UnitEnergy - UnitEnergy
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitEnergy>(value: 270.0, unit: .kilowattHours)),
            ExpressionValue.of(Measurement<UnitEnergy>(value: 180.0, unit: .kilowattHours)),
        ])
        print("17:result=\(result)")
        try #require(result.isUnitEnergy == true)
        try #require(result.asUnitEnergy() == Measurement<UnitEnergy>(value: 90.0, unit: .kilowattHours))
        // 18: UnitPower - UnitPower
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitPower>(value: 270.0, unit: .watts)),
            ExpressionValue.of(Measurement<UnitPower>(value: 180.0, unit: .watts)),
        ])
        print("18:result=\(result)")
        try #require(result.isUnitPower == true)
        try #require(result.asUnitPower() == Measurement<UnitPower>(value: 90.0, unit: .watts))
        // 19: UnitTemperature - UnitTemperature
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitTemperature>(value: 270.0, unit: .celsius)),
            ExpressionValue.of(Measurement<UnitTemperature>(value: 180.0, unit: .celsius)),
        ])
        print("19:result=\(result)")
        try #require(result.isUnitTemperatur == true)
        try #require(result.asUnitTemperature() == Measurement<UnitTemperature>(value: 90.0, unit: .celsius))
        // 20: UnitIlluminance - UnitIlluminance
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitIlluminance>(value: 270.0, unit: .lux)),
            ExpressionValue.of(Measurement<UnitIlluminance>(value: 180.0, unit: .lux)),
        ])
        print("20:result=\(result)")
        try #require(result.isUnitIlluminance == true)
        try #require(result.asUnitIlluminance() == Measurement<UnitIlluminance>(value: 90.0, unit: .lux))
        // 21: UnitElectricCharge - UnitElectricCharge
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitElectricCharge>(value: 270, unit: .ampereHours)),
            ExpressionValue.of(Measurement<UnitElectricCharge>(value: 180.0, unit: .ampereHours))
        ])
        print("21:result=\(result)")
        try #require(result.isUnitElectricCharge == true)
        try #require(result.asUnitElectricCharge() == Measurement<UnitElectricCharge>(value: 90.0, unit: .ampereHours))
        // 22: UnitElectricCurrent - UnitElectricCurrent
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitElectricCurrent>(value: 270, unit: .amperes)),
            ExpressionValue.of(Measurement<UnitElectricCurrent>(value: 180.0, unit: .amperes))
        ])
        print("22:result=\(result)")
        try #require(result.isUnitElectricCurrent == true)
        try #require(result.asUnitElectricCurrent() == Measurement<UnitElectricCurrent>(value: 90.0, unit: .amperes))
        // 23: UnitElectricPotentialDifference - UnitElectricPotentialDifference
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitElectricPotentialDifference>(value: 270, unit: .volts)),
            ExpressionValue.of(Measurement<UnitElectricPotentialDifference>(value: 180.0, unit: .volts))
        ])
        print("23:result=\(result)")
        try #require(result.isUnitElectricPotentialDifference == true)
        try #require(result.asUnitElectricPotentialDifference() == Measurement<UnitElectricPotentialDifference>(value: 90.0, unit: .volts))
        // 24: UnitElectricResistance - UnitElectricResistance
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitElectricResistance>(value: 270, unit: .ohms)),
            ExpressionValue.of(Measurement<UnitElectricResistance>(value: 180.0, unit: .ohms))
        ])
        print("24:result=\(result)")
        try #require(result.isUnitElectricResistance == true)
        try #require(result.asUnitElectricResistence() == Measurement<UnitElectricResistance>(value: 90.0, unit: .ohms))
        // 25: UnitConcentrationMass - UnitConcentrationMass
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitConcentrationMass>(value: 270, unit: .gramsPerLiter)),
            ExpressionValue.of(Measurement<UnitConcentrationMass>(value: 180.0, unit: .gramsPerLiter))
        ])
        print("25:result=\(result)")
        try #require(result.isUnitConcentrationMass == true)
        try #require(result.asUnitConcentrationMass() == Measurement<UnitConcentrationMass>(value: 90.0, unit: .gramsPerLiter))
        // 26: UnitDispersion - UnitDispersion
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitDispersion>(value: 270, unit: .partsPerMillion)),
            ExpressionValue.of(Measurement<UnitDispersion>(value: 180.0, unit: .partsPerMillion))
        ])
        print("26:result=\(result)")
        try #require(result.isUnitDispersion == true)
        try #require(result.asUnitDispersion() == Measurement<UnitDispersion>(value: 90.0, unit: .partsPerMillion))
        // 27: UnitFuelEfficiency - UnitFuelEfficiency
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitFuelEfficiency>(value: 270, unit: .litersPer100Kilometers)),
            ExpressionValue.of(Measurement<UnitFuelEfficiency>(value: 180.0, unit: .litersPer100Kilometers))
        ])
        print("27:result=\(result)")
        try #require(result.isUnitFuelEfficiency == true)
        try #require(result.asUnitFuelEfficiency() == Measurement<UnitFuelEfficiency>(value: 90.0, unit: .litersPer100Kilometers))
        // 28: UnitInformationStorage - UnitInformationStorage
        result = try op.evaluateOperator(context: ctxt, operatorToken: mockToken, arguments: [
            ExpressionValue.of(Measurement<UnitInformationStorage>(value: 270, unit: .bits)),
            ExpressionValue.of(Measurement<UnitInformationStorage>(value: 180.0, unit: .bits))
        ])
        print("28:result=\(result)")
        try #require(result.isUnitInformationStorage == true)
        try #require(result.asUnitInformationStorage() == Measurement<UnitInformationStorage>(value: 90.0, unit: .bits))
    }

    @Test("Operator - evaluation to fail")
    func evaluateOperatorToFail() async throws {
        let ctxt: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let op: InfixOperatorMinus = InfixOperatorMinus()
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
