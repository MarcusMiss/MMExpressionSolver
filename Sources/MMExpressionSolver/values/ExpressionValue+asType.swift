//
//  ExpressionValue+asType.swift
//  MMExpressionSolver
//

import Foundation

public extension ExpressionValue {

    /// Return value as Int-value.
    /// - Returns: Int-value when available
    func asInteger() -> Optional<Int> {
        switch self.type {
        case .int:
            return self.value as? Int
        default:
            return Optional.none
        }
    }

    /// Return value as Decimal-value.
    /// - Returns: Decimal-value when available
    func asDecimal() -> Optional<Decimal> {
        switch self.type {
        case .decimal:
            return self.value as? Decimal
        default:
            return Optional.none
        }
    }

    /// Return value as Double-value.
    /// - Returns: Double-value when available
    func asDouble() -> Optional<Double> {
        switch self.type {
        case .double:
            return self.value as? Double
        default:
            return Optional.none
        }
    }

    /// Return value as Float-value.
    /// - Returns: Float-value when available
    func asFloat() -> Optional<Float> {
        switch self.type {
        case .float:
            return self.value as? Float
        default:
            return Optional.none
        }
    }

    /// Return value as String-value.
    /// - Returns: String-value when available
    func asString() -> Optional<String> {
        switch self.type {
        case .string:
            return self.value as? String
        default:
            return Optional.none
        }
    }

    /// Return value as Bool-value.
    /// - Returns: Bool-value when available
    func asBoolean() -> Optional<Bool> {
        switch self.type {
        case .boolean:
            return self.value as? Bool
        default:
            return Optional.none
        }
    }

    /// Return value as DateTime-value.
    /// - Returns: DateTime-value when available
    func asDateTime() -> Optional<Date> {
        switch self.type {
        case .datetime:
            return self.value as? Date
        default:
            return Optional.none
        }
    }

    /// Return value as AST-node-value.
    /// - Returns: AST-node-value when available
    func asNode() -> Optional<ASTNode> {
        switch self.type {
        case .nodeAST:
            return self.value as? ASTNode
        default:
            return Optional.none
        }
    }

    /// Return value as Array-value.
    /// - Returns: Array-value when available
    func asArray() -> Optional<Array<Any?>> {
        switch self.type {
        case .array:
            return self.value as? Array
        default:
            return Optional.none
        }
    }

    /// Return value as tupel-value.
    /// - Returns:tupel-value when available
    func asTupel() -> Optional<()> {
        switch self.type {
        case .tupel:
            return self.value as? ()
        default:
            return Optional.none
        }
    }

    /// Return value as object-value.
    /// - Returns: object-value when available
    func asObject() -> Optional<Any> {
        switch self.type {
        case .objClass:
            return self.value
        default:
            return Optional.none
        }
    }

    /// Return value as struct-value.
    /// - Returns: struct-value when available
    func asStruct() -> Optional<Any> {
        switch self.type {
        case .objStruct:
            return self.value
        default:
            return Optional.none
        }
    }

    /// Return unit-value as `Double`-value.
    /// - Returns: `Double`-value when available
    func asUnitValue() -> Optional<Double> {
        switch self.type {
        case let .measurement(unit):
            switch unit {
            case .unitArea:
                return asUnitArea()!.value
            case .unitLength:
                return asUnitLength()!.value
            case .unitVolume:
                return asUnitVolume()!.value
            case .unitAngle:
                return asUnitAngle()!.value
            case .unitMass:
                return asUnitMass()!.value
            case .unitPressure:
                return asUnitPressure()!.value
            case .unitAcceleration:
                return asUnitAcceleration()!.value
            case .unitDuration:
                return asUnitDuration()!.value
            case .unitFrequency:
                return asUnitFrequency()!.value
            case .unitSpeed:
                return asUnitSpeed()!.value
            case .unitEnergy:
                return asUnitEnergy()!.value
            case .unitPower:
                return asUnitPower()!.value
            case .unitTemperature:
                return asUnitTemperature()!.value
            case .unitIlluminance:
                return asUnitIlluminance()!.value
            case .unitElectricCharge:
                return asUnitElectricCharge()!.value
            case .unitElectricCurrent:
                return asUnitElectricCurrent()!.value
            case .unitElectricPotentialDifference:
                return asUnitElectricPotentialDifference()!.value
            case .unitElectricalResistance:
                return asUnitElectricResistence()!.value
            case .unitConcentrationMass:
                return asUnitConcentrationMass()!.value
            case .unitDispersion:
                return asUnitDispersion()!.value
            case .unitFuelEfficiency:
                return asUnitFuelEfficiency()!.value
            case .unitInformationStorage:
                return asUnitInformationStorage()!.value
            }
        default:
            return Optional.none
        }
    }

    /// Return value as `Measurement<UnitArea>`-value.
    /// - Returns: `Measurement<UnitArea>`-value when available
    func asUnitArea() -> Optional<Measurement<UnitArea>> {
        return self.value as? Measurement<UnitArea> ?? Optional.none
    }

    /// Return value as `Measurement<UnitLength>`-value.
    /// - Returns: `Measurement<UnitLength>`-value when available
    func asUnitLength() -> Optional<Measurement<UnitLength>> {
        return self.value as? Measurement<UnitLength> ?? Optional.none
    }

    /// Return value as `Measurement<UnitVolume>`-value.
    /// - Returns: `Measurement<UnitVolume>`-value when available
    func asUnitVolume() -> Optional<Measurement<UnitVolume>> {
        return self.value as? Measurement<UnitVolume> ?? Optional.none
    }

    /// Return value as `Measurement<UnitAngle>`-value.
    /// - Returns: `Measurement<UnitAngle>`-value when available
    func asUnitAngle() -> Optional<Measurement<UnitAngle>> {
        return self.value as? Measurement<UnitAngle> ?? Optional.none
    }

    /// Return value as `Measurement<UnitMass>`-value.
    /// - Returns: `Measurement<UnitMass>`-value when available
    func asUnitMass() -> Optional<Measurement<UnitMass>> {
        return self.value as? Measurement<UnitMass> ?? Optional.none
    }

    /// Return value as `Measurement<UnitPressure>`-value.
    /// - Returns: `Measurement<UnitPressure>`-value when available
    func asUnitPressure() -> Optional<Measurement<UnitPressure>> {
        return self.value as? Measurement<UnitPressure> ?? Optional.none
    }

    /// Return value as `Measurement<UnitAcceleration>`-value.
    /// - Returns: `Measurement<UnitAcceleration>`-value when available
    func asUnitAcceleration() -> Optional<Measurement<UnitAcceleration>> {
        return self.value as? Measurement<UnitAcceleration> ?? Optional.none
    }

    /// Return value as `Measurement<UnitDuration>`-value.
    /// - Returns: `Measurement<UnitDuration>`-value when available
    func asUnitDuration() -> Optional<Measurement<UnitDuration>> {
        return self.value as? Measurement<UnitDuration> ?? Optional.none
    }

    /// Return value as `Measurement<UnitFrequency>`-value.
    /// - Returns: `Measurement<UnitFrequency>`-value when available
    func asUnitFrequency() -> Optional<Measurement<UnitFrequency>> {
        return self.value as? Measurement<UnitFrequency> ?? Optional.none
    }

    /// Return value as `Measurement<UnitSpeed>`-value.
    /// - Returns: `Measurement<UnitSpeed>`-value when available
    func asUnitSpeed() -> Optional<Measurement<UnitSpeed>> {
        return self.value as? Measurement<UnitSpeed> ?? Optional.none
    }

    /// Return value as `Measurement<UnitEnergy>`-value.
    /// - Returns: `Measurement<UnitEnergy>`-value when available
    func asUnitEnergy() -> Optional<Measurement<UnitEnergy>> {
        return self.value as? Measurement<UnitEnergy> ?? Optional.none
    }

    /// Return value as `Measurement<UnitPower>`-value.
    /// - Returns: `Measurement<UnitPower>`-value when available
    func asUnitPower() -> Optional<Measurement<UnitPower>> {
        return self.value as? Measurement<UnitPower> ?? Optional.none
    }

    /// Return value as `Measurement<UnitTemperature>`-value.
    /// - Returns: `Measurement<UnitTemperature>`-value when available
    func asUnitTemperature() -> Optional<Measurement<UnitTemperature>> {
        return self.value as? Measurement<UnitTemperature> ?? Optional.none
    }

    /// Return value as `Measurement<UnitIlluminance>`-value.
    /// - Returns: `Measurement<UnitIlluminance>`-value when available
    func asUnitIlluminance() -> Optional<Measurement<UnitIlluminance>> {
        return self.value as? Measurement<UnitIlluminance> ?? Optional.none
    }

    /// Return value as `Measurement<UnitElectricCharge>`-value.
    /// - Returns: `Measurement<UnitElectricCharge>`-value when available
    func asUnitElectricCharge() -> Optional<Measurement<UnitElectricCharge>> {
        return self.value as? Measurement<UnitElectricCharge> ?? Optional.none
    }

    /// Return value as `Measurement<UnitElectricCurrent>`-value.
    /// - Returns: `Measurement<UnitElectricCurrent>`-value when available
    func asUnitElectricCurrent() -> Optional<Measurement<UnitElectricCurrent>> {
        return self.value as? Measurement<UnitElectricCurrent> ?? Optional.none
    }

    /// Return value as `Measurement<UnitElectricPotentialDifference>`-value.
    /// - Returns: `Measurement<UnitElectricPotentialDifference>`-value when available
    func asUnitElectricPotentialDifference() -> Optional<Measurement<UnitElectricPotentialDifference>> {
        return self.value as? Measurement<UnitElectricPotentialDifference> ?? Optional.none
    }

    /// Return value as `Measurement<UnitElectricResistance>`-value.
    /// - Returns: `Measurement<UnitElectricResistance>`-value when available
    func asUnitElectricResistence() -> Optional<Measurement<UnitElectricResistance>> {
        return self.value as? Measurement<UnitElectricResistance> ?? Optional.none
    }

    /// Return value as `Measurement<UnitConcentrationMass>`-value.
    /// - Returns: `Measurement<UnitConcentrationMass>`-value when available
    func asUnitConcentrationMass() -> Optional<Measurement<UnitConcentrationMass>> {
        return self.value as? Measurement<UnitConcentrationMass> ?? Optional.none
    }

    /// Return value as `Measurement<UnitDispersion>`-value.
    /// - Returns: `Measurement<UnitDispersion>`-value when available
    func asUnitDispersion() -> Optional<Measurement<UnitDispersion>> {
        return self.value as? Measurement<UnitDispersion> ?? Optional.none
    }

    /// Return value as `Measurement<UnitFuelEfficiency>`-value.
    /// - Returns: `Measurement<UnitFuelEfficiency>`-value when available
    func asUnitFuelEfficiency() -> Optional<Measurement<UnitFuelEfficiency>> {
        return self.value as? Measurement<UnitFuelEfficiency> ?? Optional.none
    }

    /// Return value as `Measurement<UnitInformationStorage>`-value.
    /// - Returns: `Measurement<UnitInformationStorage>`-value when available
    func asUnitInformationStorage() -> Optional<Measurement<UnitInformationStorage>> {
        return self.value as? Measurement<UnitInformationStorage> ?? Optional.none
    }

}
