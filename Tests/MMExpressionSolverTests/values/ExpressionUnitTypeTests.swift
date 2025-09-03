//
//  ExpressionUnitTypeTests.swift
//  MMExpressionSolver
//


import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionUnitType Tests")
class ExpressionUnitTypeTests {
    
    @Test func validateEnums() async throws {
        #expect(ExpressionUnitType.unitArea.getUnitName() == "Area")
        #expect(ExpressionUnitType.unitLength.getUnitName() == "Length")
        #expect(ExpressionUnitType.unitVolume.getUnitName() == "Volume")
        #expect(ExpressionUnitType.unitAngle.getUnitName() == "Angle")
        #expect(ExpressionUnitType.unitMass.getUnitName() == "Mass")
        #expect(ExpressionUnitType.unitPressure.getUnitName() == "Pressure")
        #expect(ExpressionUnitType.unitAcceleration.getUnitName() == "Acceleration")
        #expect(ExpressionUnitType.unitDuration.getUnitName() == "Duration")
        #expect(ExpressionUnitType.unitFrequency.getUnitName() == "Frequency")
        #expect(ExpressionUnitType.unitSpeed.getUnitName() == "Speed")
        #expect(ExpressionUnitType.unitEnergy.getUnitName() == "Energy")
        #expect(ExpressionUnitType.unitPower.getUnitName() == "Power")
        #expect(ExpressionUnitType.unitTemperature.getUnitName() == "Temperature")
        #expect(ExpressionUnitType.unitIlluminance.getUnitName() == "Illuminance")
        #expect(ExpressionUnitType.unitElectricCharge.getUnitName() == "ElectricCharge")
        #expect(ExpressionUnitType.unitElectricCurrent.getUnitName() == "ElectricCurrent")
        #expect(ExpressionUnitType.unitElectricPotentialDifference.getUnitName() == "ElectricPotentialDifference")
        #expect(ExpressionUnitType.unitElectricalResistance.getUnitName() == "ElectricResistence")
        #expect(ExpressionUnitType.unitConcentrationMass.getUnitName() == "ConcentrationMass")
        #expect(ExpressionUnitType.unitDispersion.getUnitName() == "Dispersion")
        #expect(ExpressionUnitType.unitFuelEfficiency.getUnitName() == "FuelEfficiency")
        #expect(ExpressionUnitType.unitInformationStorage.getUnitName() == "InformationStorage")
    }

}
