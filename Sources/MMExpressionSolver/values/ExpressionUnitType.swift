//
//  ExpressionUnitType.swift
//  MMExpressionSolver
//

import Foundation

/// Enumaration of all unit-types.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public enum ExpressionUnitType: String, Codable, CaseIterable, Sendable, Hashable {

    case unitArea
    case unitLength
    case unitVolume
    case unitAngle
    case unitMass
    case unitPressure
    case unitAcceleration
    case unitDuration
    case unitFrequency
    case unitSpeed
    case unitEnergy
    case unitPower
    case unitTemperature
    case unitIlluminance
    case unitElectricCharge
    case unitElectricCurrent
    case unitElectricPotentialDifference
    case unitElectricalResistance
    case unitConcentrationMass
    case unitDispersion
    case unitFuelEfficiency
    case unitInformationStorage

    /// Return name of unit.
    /// - Returns: unitname
    public func getUnitName() -> String {
        switch self {
        case .unitArea:
            return "Area"
        case .unitLength:
            return "Length"
        case .unitVolume:
            return "Volume"
        case .unitAngle:
            return "Angle"
        case .unitMass:
            return "Mass"
        case .unitPressure:
            return "Pressure"
        case .unitAcceleration:
            return "Acceleration"
        case .unitDuration:
            return "Duration"
        case .unitFrequency:
            return "Frequency"
        case .unitSpeed:
            return "Speed"
        case .unitEnergy:
            return "Energy"
        case .unitPower:
            return "Power"
        case .unitTemperature:
            return "Temperature"
        case .unitIlluminance:
            return "Illuminance"
        case .unitElectricCharge:
            return "ElectricCharge"
        case .unitElectricCurrent:
            return "ElectricCurrent"
        case .unitElectricPotentialDifference:
            return "ElectricPotentialDifference"
        case .unitElectricalResistance:
            return "ElectricResistence"
        case .unitConcentrationMass:
            return "ConcentrationMass"
        case .unitDispersion:
            return "Dispersion"
        case .unitFuelEfficiency:
            return "FuelEfficiency"
        case .unitInformationStorage:
            return "InformationStorage"
        }
    }

}
