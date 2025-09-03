//
//  ExpressionValue.swift
//  MMExpressionSolver
//

import Foundation
import MMEcletic

/// Wrapper-object to save various supported native types.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class ExpressionValue : Hashable {

    // MARK: - Factories
    
    /// Wraps a `nil`-value.
    /// - Returns: wrapped value
    public static func ofNil() -> ExpressionValue {
        return valueOfAny(nil)!
    }

    /// Wraps a `String`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: String) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Int`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Int) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Double`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Double) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Float`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Float) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Decimal`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Decimal) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Bool`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Bool) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Date`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Date) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `ASTNode`-value. Needed for lazy evaluation of ASTs.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: ASTNode) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitArea>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitArea>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitLength>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitLength>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitVolume>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitVolume>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitAngle>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitAngle>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitMass>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitMass>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitPressure>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitPressure>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitAcceleration>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitAcceleration>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitDuration>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitDuration>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitFrequency>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitFrequency>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitSpeed>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitSpeed>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitEnergy>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitEnergy>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitPower>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitPower>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitTemperature>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitTemperature>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitIlluminance>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitIlluminance>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitElectricCharge>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitElectricCharge>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitElectricCurrent>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitElectricCurrent>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitElectricPotentialDifference>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitElectricPotentialDifference>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitElectricResistance>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitElectricResistance>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitConcentrationMass>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitConcentrationMass>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitDispersion>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitDispersion>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitFuelEfficiency>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitFuelEfficiency>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Measurement<UnitInformationStorage>`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Measurement<UnitInformationStorage>) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Array`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: [Any]) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Any`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Any) -> Optional<ExpressionValue> {
        return valueOfAny(value)
    }
    
    /// Internal method to wrap a native value into an expression value.
    /// - Parameter value: value to wrap
    /// - Returns: Wrapper or `nil` if type is unsupported
    static func valueOfAny(_ value: Any?) -> Optional<ExpressionValue> {
        if value == nil {
            return ExpressionValue()
        }
        if value is String {
            return ExpressionValue(value as! String, .string)
        } else if value is Double {
            return ExpressionValue(value as! Double, .double)
        } else if value is Float {
            return ExpressionValue(value as! Float, .float)
        } else if value is Decimal {
            return ExpressionValue(value as! Decimal, .decimal)
        } else if value is Int {
            return ExpressionValue(value as! Int, .int)
        } else if value is Bool {
            return ExpressionValue(value as! Bool, .boolean)
        } else if value is Date {
            return ExpressionValue(value as! Date, .datetime)
        } else if value is ASTNode {
            return ExpressionValue(value as! ASTNode, .nodeAST)
        } else if value is Measurement<UnitArea> {
            return ExpressionValue(value as! Measurement<UnitArea>, .measurement(unit: .unitArea))
        } else if value is Measurement<UnitLength> {
            return ExpressionValue(value as! Measurement<UnitLength>, .measurement(unit: .unitLength))
        } else if value is Measurement<UnitVolume> {
            return ExpressionValue(value as! Measurement<UnitVolume>, .measurement(unit: .unitVolume))
        } else if value is Measurement<UnitAngle> {
            return ExpressionValue(value as! Measurement<UnitAngle>, .measurement(unit: .unitAngle))
        } else if value is Measurement<UnitMass> {
            return ExpressionValue(value as! Measurement<UnitMass>, .measurement(unit: .unitMass))
        } else if value is Measurement<UnitPressure> {
            return ExpressionValue(value as! Measurement<UnitPressure>, .measurement(unit: .unitPressure))
        } else if value is Measurement<UnitAcceleration> {
            return ExpressionValue(value as! Measurement<UnitAcceleration>, .measurement(unit: .unitAcceleration))
        } else if value is Measurement<UnitDuration> {
            return ExpressionValue(value as! Measurement<UnitDuration>, .measurement(unit: .unitDuration))
        } else if value is Measurement<UnitFrequency> {
            return ExpressionValue(value as! Measurement<UnitFrequency>, .measurement(unit: .unitFrequency))
        } else if value is Measurement<UnitSpeed> {
            return ExpressionValue(value as! Measurement<UnitSpeed>, .measurement(unit: .unitSpeed))
        } else if value is Measurement<UnitEnergy> {
            return ExpressionValue(value as! Measurement<UnitEnergy>, .measurement(unit: .unitEnergy))
        } else if value is Measurement<UnitPower> {
            return ExpressionValue(value as! Measurement<UnitPower>, .measurement(unit: .unitPower))
        } else if value is Measurement<UnitTemperature> {
            return ExpressionValue(value as! Measurement<UnitTemperature>, .measurement(unit: .unitTemperature))
        } else if value is Measurement<UnitIlluminance> {
            return ExpressionValue(value as! Measurement<UnitIlluminance>, .measurement(unit: .unitIlluminance))
        } else if value is Measurement<UnitElectricCharge> {
            return ExpressionValue(value as! Measurement<UnitElectricCharge>, .measurement(unit: .unitElectricCharge))
        } else if value is Measurement<UnitElectricCurrent> {
            return ExpressionValue(value as! Measurement<UnitElectricCurrent>, .measurement(unit: .unitElectricCurrent))
        } else if value is Measurement<UnitElectricPotentialDifference> {
            return ExpressionValue(value as! Measurement<UnitElectricPotentialDifference>, .measurement(unit: .unitElectricPotentialDifference))
        } else if value is Measurement<UnitElectricResistance> {
            return ExpressionValue(value as! Measurement<UnitElectricResistance>, .measurement(unit: .unitElectricalResistance))
        } else if value is Measurement<UnitConcentrationMass> {
            return ExpressionValue(value as! Measurement<UnitConcentrationMass>, .measurement(unit: .unitConcentrationMass))
        } else if value is Measurement<UnitDispersion> {
            return ExpressionValue(value as! Measurement<UnitDispersion>, .measurement(unit: .unitDispersion))
        } else if value is Measurement<UnitFuelEfficiency> {
            return ExpressionValue(value as! Measurement<UnitFuelEfficiency>, .measurement(unit: .unitFuelEfficiency))
        } else if value is Measurement<UnitInformationStorage> {
            return ExpressionValue(value as! Measurement<UnitInformationStorage>, .measurement(unit: .unitInformationStorage))
        } else if Mirror(reflecting: value!).displayStyle == .class {
            return ExpressionValue(value, .objClass)
        } else if Mirror(reflecting: value!).displayStyle == .struct {
            return ExpressionValue(value, .objStruct)
        } else if Mirror(reflecting: value!).displayStyle == .collection {
            return ExpressionValue(value, .array)
        } else if Mirror(reflecting: value!).displayStyle == .tuple {
            return ExpressionValue(value, .tupel)
        } else {
            return nil
        }
    }

    // MARK: - Properties

    /// Type of value
    public let type: ExpressionValueType
    /// Internal value
    let value: Any?

    /// Indicator if expression-value is of type `String`.
    public var isStringValue: Bool {
        switch self.type {
        case .string:
            return true
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Decimal`.
    public var isDecimalValue: Bool {
        switch self.type {
        case .decimal:
            return true
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Double`.
    public var isDoubleValue: Bool {
        switch self.type {
        case .double:
            return true
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Float`.
    public var isFloatValue: Bool {
        switch self.type {
        case .float:
            return true
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Int`.
    public var isIntegerValue: Bool {
        switch self.type {
        case .int:
            return true
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Bool`.
    public var isBooleanValue: Bool {
        switch self.type {
        case .boolean:
            return true
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Date`.
    public var isDateTime: Bool {
        switch self.type {
        case .datetime:
            return true
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `nil`.
    public var isNullValue: Bool {
        switch self.type {
        case .null:
            return true
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Decimal`, `Double`, `Float`or `Int`.
    public var isNumericValue: Bool { return self.isDoubleValue || self.isFloatValue || self.isIntegerValue || self.isDecimalValue }

    /// Indicator if expression-value is of type `Array`.
    public var isArrayValue: Bool {
        switch self.type {
        case .array:
            return true
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Class` or `Struct`.
    public var isStructureValue: Bool {
        switch self.type {
        case .objClass, .objStruct:
            return true
        default:
            return false
        }
    }


    /// Indicator if expression-value is of type `Tupel`.
    public var isTupel: Bool {
        switch self.type {
        case .tupel:
            return true
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `AST-node`.
    public var isAST: Bool {
        switch self.type {
        case .nodeAST:
            return true
        default:
            return false
        }
    }


    /// Indicator if expression-value is of type `Measurement/UnitArea`.
    public var isUnitArea: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitArea
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitLength`.
    public var isUnitLength: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitLength
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitVolumne`.
    public var isUnitVolume: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitVolume
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitAngle`.
    public var isUnitAngle: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitAngle
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `unitArea`, `unitAngle`, `unitLength`or `unitVolume`.
    public var isUnitDimension: Bool { return self.isUnitArea || self.isUnitAngle || self.isUnitLength || self.isUnitVolume }

    /// Indicator if expression-value is of type `Measurement/UnitMass`.
    public var isUnitMass: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitMass
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitPressure`.
    public var isUnitPressure: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitPressure
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `unitMass`, `unitPressure`.
    public var isUnitMassWeightForce : Bool { return self.isUnitMass || self.isUnitPressure }

    /// Indicator if expression-value is of type `Measurement/UnitAcceleration`.
    public var isUnitAcceleration: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitAcceleration
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitDuration`.
    public var isUnitDuration: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitDuration
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitFrequency`.
    public var isUnitFrequency: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitFrequency
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitSpped`.
    public var isUnitSpeed: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitSpeed
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `unitAcceleration`, `unitDuration`, `unitFrequency` and `unitSpeed`.
    public var isUnitTimeMotion : Bool { return self.isUnitAcceleration || self.isUnitDuration || self.isUnitFrequency || self.isUnitSpeed }

    /// Indicator if expression-value is of type `Measurement/UnitEnergy`.
    public var isUnitEnergy: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitEnergy
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitPower`.
    public var isUnitPower: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitPower
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitTemperature`.
    public var isUnitTemperatur: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitTemperature
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitIlluminance`.
    public var isUnitIlluminance: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitIlluminance
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `unitEnergy`, `unitPower`, `unitTemperature` and `unitIlluminance`.
    public var isUnitEnergyHeatLight : Bool { return self.isUnitEnergy || self.isUnitPower || self.isUnitTemperatur || self.isUnitIlluminance }

    /// Indicator if expression-value is of type `Measurement/UnitElectricCharge`.
    public var isUnitElectricCharge: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitElectricCharge
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitElectricCurrent`.
    public var isUnitElectricCurrent: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitElectricCurrent
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitElectricPotentialDifference`.
    public var isUnitElectricPotentialDifference: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitElectricPotentialDifference
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitElectricResistance`.
    public var isUnitElectricResistance : Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitElectricalResistance
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `unitElectricCharge`, `unitElectricCurrent`, `unitElectricPotentialDifference` and `unitElectricalResistance`.
    public var isUnitElectricity : Bool { return self.isUnitElectricCharge
            || self.isUnitElectricCurrent
            || self.isUnitElectricPotentialDifference
            || self.isUnitElectricResistance }

    /// Indicator if expression-value is of type `Measurement/UnitConcentrationMass`.
    public var isUnitConcentrationMass: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitConcentrationMass
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitDispersion`.
    public var isUnitDispersion: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitDispersion
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitFuelEfficiency`.
    public var isUnitFuelEfficiency: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitFuelEfficiency
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `Measurement/UnitInformationStorage`.
    public var isUnitInformationStorage: Bool {
        switch self.type {
        case let .measurement(unit):
            return unit == .unitInformationStorage
        default:
            return false
        }
    }

    /// Indicator if expression-value is of type `unitConcentrationMass`, `unitDispersion`, `unitFuelEfficiency` and `unitInformationStorage`.
    public var isUnitMiscellaneous : Bool { return self.isUnitConcentrationMass
            || self.isUnitDispersion
            || self.isUnitFuelEfficiency
            || self.isUnitInformationStorage }


    /// Indicator if expression-value of type `Measurement`.
    public var isMeasurement: Bool { return self.isUnitDimension
        || self.isUnitMassWeightForce
        || self.isUnitTimeMotion
        || self.isUnitEnergyHeatLight
        || self.isUnitElectricity
        || self.isUnitMiscellaneous}

    // MARK: - Initialization
    
    /// Initialization of this object.
    private init() {
        self.value = nil
        self.type = .null
    }

    /// Initialization of this object
    /// - Parameters:
    ///   - value: value
    ///   - type: type
    private init(_ value: Any?, _ type: ExpressionValueType) {
        self.value = value
        self.type = type
    }

    // MARK: - Protocol Hashable

    public static func == (lhs: ExpressionValue, rhs: ExpressionValue) -> Bool {
        if lhs.isNullValue && rhs.isNullValue {
            return true
        } else if lhs.isNumericValue && rhs.isNumericValue {
            return lhs.asConvertedDecimalNumber()! == rhs.asConvertedDecimalNumber()!
        } else if lhs.isStringValue && rhs.isStringValue {
            return lhs.asString()! == rhs.asString()!
        } else if lhs.isBooleanValue && rhs.isBooleanValue {
            return lhs.asBoolean()! == rhs.asBoolean()!
        } else if lhs.isDateTime && rhs.isDateTime {
            return lhs.asDateTime()! == rhs.asDateTime()!
        } else if lhs.isUnitArea && rhs.isUnitArea {
            return lhs.asUnitArea()! == rhs.asUnitArea()!
        } else if lhs.isUnitLength && rhs.isUnitLength {
            return lhs.asUnitLength()! == rhs.asUnitLength()!
        } else if lhs.isUnitVolume && rhs.isUnitVolume {
            return  lhs.asUnitVolume()! == rhs.asUnitVolume()!
        } else if lhs.isUnitAngle && rhs.isUnitAngle {
            return lhs.asUnitAngle()! == rhs.asUnitAngle()!
        } else if lhs.isUnitMass && rhs.isUnitMass {
            return lhs.asUnitMass()! == rhs.asUnitMass()!
        } else if lhs.isUnitPressure && rhs.isUnitPressure {
            return lhs.asUnitPressure()! == rhs.asUnitPressure()!
        } else if lhs.isUnitAcceleration && rhs.isUnitAcceleration {
            return lhs.asUnitAcceleration()! == rhs.asUnitAcceleration()!
        } else if lhs.isUnitDuration && rhs.isUnitDuration {
            return lhs.asUnitDuration()! == rhs.asUnitDuration()!
        } else if lhs.isUnitFrequency && rhs.isUnitFrequency {
            return lhs.asUnitFrequency()! == rhs.asUnitFrequency()!
        } else if lhs.isUnitSpeed && rhs.isUnitSpeed {
            return lhs.asUnitSpeed()! == rhs.asUnitSpeed()!
        } else if lhs.isUnitEnergy && rhs.isUnitEnergy {
            return lhs.asUnitEnergy()! == rhs.asUnitEnergy()!
        } else if lhs.isUnitPower && rhs.isUnitPower {
            return lhs.asUnitPower()! == rhs.asUnitPower()!
        } else if lhs.isUnitTemperatur && rhs.isUnitTemperatur {
            return lhs.asUnitTemperature()! == rhs.asUnitTemperature()!
        } else if lhs.isUnitIlluminance && rhs.isUnitIlluminance {
            return lhs.asUnitIlluminance()! == rhs.asUnitIlluminance()!
        } else if lhs.isUnitElectricCharge && rhs.isUnitElectricCharge {
            return lhs.asUnitElectricCharge()! == rhs.asUnitElectricCharge()!
        } else if lhs.isUnitElectricCurrent && rhs.isUnitElectricCurrent {
            return lhs.asUnitElectricCurrent()! == rhs.asUnitElectricCurrent()!
        } else if lhs.isUnitElectricPotentialDifference && rhs.isUnitElectricPotentialDifference {
            return lhs.asUnitElectricPotentialDifference()! == rhs.asUnitElectricPotentialDifference()!
        } else if lhs.isUnitElectricResistance && rhs.isUnitElectricResistance {
            return lhs.asUnitElectricResistence()! == rhs.asUnitElectricResistence()!
        } else if lhs.isUnitConcentrationMass && rhs.isUnitConcentrationMass {
            return lhs.asUnitConcentrationMass()! == rhs.asUnitConcentrationMass()!
        } else if lhs.isUnitDispersion && rhs.isUnitDispersion {
            return lhs.asUnitDispersion()! == rhs.asUnitDispersion()!
        } else if lhs.isUnitFuelEfficiency && rhs.isUnitFuelEfficiency {
            return lhs.asUnitFuelEfficiency()! == rhs.asUnitFuelEfficiency()!
        } else if lhs.isUnitInformationStorage && rhs.isUnitInformationStorage {
            return lhs.asUnitInformationStorage()! == rhs.asUnitInformationStorage()!
        } else if lhs.type == rhs.type {
            if let lhsHash = lhs.value as? (any Hashable), let rhsHash = rhs.value as? (any Hashable) {
                return lhsHash.hashValue == rhsHash.hashValue
            }
        }
        return false
    }
    
    /// This function calculates an hash-value.
    /// - Parameter hasher: hasher-object
    public func hash(into hasher: inout Hasher) {
        switch self.type {
        case .int:
            hasher.combine(self.value as! Int)
        case .decimal:
            hasher.combine(self.value as! Decimal)
        case .double:
            hasher.combine(self.value as! Double)
        case .float:
            hasher.combine(self.value as! Float)
        case .boolean:
            hasher.combine(self.value as! Bool)
        case .string:
            hasher.combine(self.value as! String)
        case .datetime:
            hasher.combine(self.value as! Date)
        case .nodeAST:
            hasher.combine(self.value as! ASTNode)
        case .null:
            hasher.combine(0)
        case .tupel, .objStruct, .objClass, .array:
            if let conformHash = self.value as? (any Hashable) {
                hasher.combine(conformHash)
            } else {
                // Not sure what is best approach here, ensure unique
                hasher.combine(UUID())
            }
        case .measurement(unit: let unit):
            hasher.combine(unit.rawValue)
        }
    }

}

extension ExpressionValue: CustomStringConvertible, CustomDebugStringConvertible {
    
    /// Return object-value as string for messages.
    /// - Returns: object-description for messages.
    public func asStandardString() -> String {
        switch self.type {
        case .int:
            return "\(self.value!)"
        case .double:
            return "\(self.value!)"
        case .float:
            return "\(self.value!)"
        case .decimal:
            return "\(self.value!)"
        case .boolean:
            return "\(self.value!)"
        case .string:
            return "\(self.value!)"
        case .datetime:
            let df: DateFormatter = DateFormatter()
            df.dateFormat = DateFormatter.standardDateFormatPattern
            let now: String = df.string(from: self.asDateTime()!)
            return "\(now)"
        case .nodeAST:
            return "\(self.value!)"
        case .null:
            return "null"
        case .array:
            return "\(self.value!)"
        case .objClass:
            return "\(self.value!)"
        case .objStruct:
            return "\(self.value!)"
        case .tupel:
            return "\(self.value!)"
        case let .measurement(unit):
            return "\(unit)"
        }
    }
    
    /// Return object-value as string for error-messages.
    /// - Returns: object-description for error-messages.
    public func asStringForError() -> String {
        switch self.type {
        case .int:
            return "\(self.value!)"
        case .double:
            return "\(self.value!)"
        case .float:
            return "\(self.value!)"
        case .decimal:
            return "\(self.value!)"
        case .boolean:
            return "\(self.value!)"
        case .string:
            return "\"\(self.value!)\""
        case .datetime:
            let df: DateFormatter = DateFormatter()
            df.dateFormat = DateFormatter.standardDateFormatPattern
            let now: String = df.string(from: self.asDateTime()!)
            return "\"\(now)\""
        case .nodeAST:
            return "\(self.value!)"
        case .null:
            return "null"
        case .array:
            return "\(self.value!)"
        case .objClass:
            return "\(self.value!)"
        case .objStruct:
            return "\(self.value!)"
        case .tupel:
            return "\(self.value!)"
        case let .measurement(unit):
            return "\(unit)"
        }
    }
    
    // MARK: - Protocol CustomStringConvertible
    
    public var description: String {
        switch self.type {
        case .int:
            return "\(self.type): \(self.value!)"
        case .double:
            return "\(self.type): \(self.value!)"
        case .float:
            return "\(self.type): \(self.value!)"
        case .decimal:
            return "\(self.type): \(self.value!)"
        case .boolean:
            return "\(self.type): \(self.value!)"
        case .string:
            return "\(self.type): \"\(self.value!)\""
        case .datetime:
            let df: DateFormatter = DateFormatter()
            df.dateFormat = DateFormatter.standardDateFormatPattern
            let now: String = df.string(from: self.asDateTime()!)
            return "\(self.type): \(now)"
        case .nodeAST:
            return "\(self.value!)"
        case .null:
            return "\(self.type): null"
        case .array:
            return "\(self.type): \(self.value!)"
        case .objClass:
            return "\(self.type): \(self.value!)"
        case .objStruct:
            return "\(self.type): \(self.value!)"
        case .tupel:
            return "\(self.type): \(self.value!)"
        case let .measurement(unit):
            return "\(unit)"
        }
    }
    
    // MARK: - Protocol CustomDebugStringConvertible
    
    public var debugDescription: String {
        switch self.type {
        case .int, .double, .float, .decimal, .boolean, .string:
            return "ExpressionValue(type: \(self.type), value: '\(self.value!)')"
        case .datetime:
            let df: DateFormatter = DateFormatter()
            df.dateFormat = DateFormatter.standardDateFormatPattern
            let now: String = df.string(from: self.asDateTime()!)
            return "\(self.type): \"\(now)\""
        case .nodeAST:
            return "ExpressionValue(type: \(self.type), value: '\(self.value!)')"
        case .null:
            return "ExpressionValue(type: \(self.type), value: null)"
        case .array, .objClass, .objStruct, .tupel:
            return "ExpressionValue(type: \(self.type), value: '\(self.value.debugDescription)')"
        case let .measurement(unit):
            return "ExpressionValue(type: \(self.type), value: '\(unit)')"
        }
    }
    
}

extension ExpressionValue {

    /// Check if value has a component (value.component)
    /// - Parameter name: component name
    /// - Returns: true if component is available
    public func hasComponent(_ name: String) -> Bool {
        if self.isStructureValue || self.isTupel {
            return Mirror(reflecting: self.value!).children.contains { $0.label == name }
        }
        return false
    }
    
    /// Return component-value
    /// - Parameter name: component name
    /// - Returns: component-value if available
    public func getComponent(_ name: String) -> Optional<ExpressionValue> {
        var optValue: Optional<ExpressionValue> = Optional.none
        Mirror(reflecting: self.value!).children.forEach { child in
            if child.label == name && !optValue.isPresent {
                optValue = ExpressionValue.of(child.value)
            }
        }
        return optValue
    }

}

extension ExpressionValue {

    /// Operator `EvalValue != EvalValue`.
    /// - Parameters:
    ///   - lhs: left-side value
    ///   - rhs: right-side value
    /// - Returns: `true` if `lhs != rhs`
    public static func != (lhs: ExpressionValue, rhs: ExpressionValue) -> Bool {
        //return !(lhs == rhs)
        if lhs.isNullValue && !rhs.isNullValue {
            return true
        } else if !lhs.isNullValue && rhs.isNullValue {
            return true
        } else if lhs.isNullValue && rhs.isNullValue {
            return false
        } else if lhs.isNumericValue && rhs.isNumericValue {
            return lhs.asConvertedDecimalNumber()! != rhs.asConvertedDecimalNumber()!
        } else if lhs.isStringValue && rhs.isStringValue {
            return lhs.asString()! != rhs.asString()!
        } else if lhs.isBooleanValue && rhs.isBooleanValue {
            return lhs.asBoolean()! != rhs.asBoolean()!
        } else if lhs.isDateTime && rhs.isDateTime {
            return lhs.asDateTime()! != rhs.asDateTime()!
        } else if lhs.isUnitArea && rhs.isUnitArea {
            return lhs.asUnitArea()! != rhs.asUnitArea()!
        } else if lhs.isUnitLength && rhs.isUnitLength {
            return lhs.asUnitLength()! != rhs.asUnitLength()!
        } else if lhs.isUnitVolume && rhs.isUnitVolume {
            return lhs.asUnitVolume()! != rhs.asUnitVolume()!
        } else if lhs.isUnitAngle && rhs.isUnitAngle {
            return lhs.asUnitAngle()! != rhs.asUnitAngle()!
        } else if lhs.isUnitMass && rhs.isUnitMass {
            return lhs.asUnitMass()! != rhs.asUnitMass()!
        } else if lhs.isUnitPressure && rhs.isUnitPressure {
            return lhs.asUnitPressure()! != rhs.asUnitPressure()!
        } else if lhs.isUnitAcceleration && rhs.isUnitAcceleration {
            return lhs.asUnitAcceleration()! != rhs.asUnitAcceleration()!
        } else if lhs.isUnitDuration && rhs.isUnitDuration {
            return lhs.asUnitDuration()! != rhs.asUnitDuration()!
        } else if lhs.isUnitFrequency && rhs.isUnitFrequency {
            return lhs.asUnitFrequency()! != rhs.asUnitFrequency()!
        } else if lhs.isUnitSpeed && rhs.isUnitSpeed {
            return lhs.asUnitSpeed()! != rhs.asUnitSpeed()!
        } else if lhs.isUnitEnergy && rhs.isUnitEnergy {
            return lhs.asUnitEnergy()! != rhs.asUnitEnergy()!
        } else if lhs.isUnitPower && rhs.isUnitPower {
            return lhs.asUnitPower()! != rhs.asUnitPower()!
        } else if lhs.isUnitTemperatur && rhs.isUnitTemperatur {
            return lhs.asUnitTemperature()! != rhs.asUnitTemperature()!
        } else if lhs.isUnitIlluminance && rhs.isUnitIlluminance {
            return lhs.asUnitIlluminance()! != rhs.asUnitIlluminance()!
        } else if lhs.isUnitElectricCharge && rhs.isUnitElectricCharge {
            return lhs.asUnitElectricCharge()! != rhs.asUnitElectricCharge()!
        } else if lhs.isUnitElectricCurrent && rhs.isUnitElectricCurrent {
            return lhs.asUnitElectricCurrent()! != rhs.asUnitElectricCurrent()!
        } else if lhs.isUnitElectricPotentialDifference && rhs.isUnitElectricPotentialDifference {
            return lhs.asUnitElectricPotentialDifference()! != rhs.asUnitElectricPotentialDifference()!
        } else if lhs.isUnitElectricResistance && rhs.isUnitElectricResistance {
            return lhs.asUnitElectricResistence()! != rhs.asUnitElectricResistence()!
        } else if lhs.isUnitConcentrationMass && rhs.isUnitConcentrationMass {
            return lhs.asUnitConcentrationMass()! != rhs.asUnitConcentrationMass()!
        } else if lhs.isUnitDispersion && rhs.isUnitDispersion {
            return lhs.asUnitDispersion()! != rhs.asUnitDispersion()!
        } else if lhs.isUnitFuelEfficiency && rhs.isUnitFuelEfficiency {
            return lhs.asUnitFuelEfficiency()! != rhs.asUnitFuelEfficiency()!
        } else if lhs.isUnitInformationStorage && rhs.isUnitInformationStorage {
            return lhs.asUnitInformationStorage()! != rhs.asUnitInformationStorage()!
        } else if lhs.type == rhs.type {
            if let lhsHash = lhs.value as? (any Hashable), let rhsHash = rhs.value as? (any Hashable) {
                return lhsHash.hashValue != rhsHash.hashValue
            }
        }
        return true
    }

    /// Operator `EvalValue > EvalValue`.
    /// - Parameters:
    ///   - lhs: left-side value
    ///   - rhs: right-side value
    /// - Returns: `true` if `lhs > rhs`
    public static func > (lhs: ExpressionValue, rhs: ExpressionValue) -> Bool {
        if lhs.isNumericValue && rhs.isNumericValue {
            return lhs.asConvertedDecimalNumber()! > rhs.asConvertedDecimalNumber()!
        } else if lhs.isStringValue && rhs.isStringValue {
            return lhs.asString()! > rhs.asString()!
        } else if lhs.isBooleanValue && rhs.isBooleanValue {
            return (lhs.asBoolean()! ? 1 : 0) > (rhs.asBoolean()! ? 1 : 0)
        } else if lhs.isDateTime && rhs.isDateTime {
            return lhs.asDateTime()! > rhs.asDateTime()!
        } else if lhs.isUnitArea && rhs.isUnitArea {
            return lhs.asUnitArea()! > rhs.asUnitArea()!
        } else if lhs.isUnitLength && rhs.isUnitLength {
            return lhs.asUnitLength()! > rhs.asUnitLength()!
        } else if lhs.isUnitVolume && rhs.isUnitVolume {
            return lhs.asUnitVolume()! > rhs.asUnitVolume()!
        } else if lhs.isUnitAngle && rhs.isUnitAngle {
            return lhs.asUnitAngle()! > rhs.asUnitAngle()!
        } else if lhs.isUnitMass && rhs.isUnitMass {
            return lhs.asUnitMass()! > rhs.asUnitMass()!
        } else if lhs.isUnitPressure && rhs.isUnitPressure {
            return lhs.asUnitPressure()! > rhs.asUnitPressure()!
        } else if lhs.isUnitAcceleration && rhs.isUnitAcceleration {
            return lhs.asUnitAcceleration()! > rhs.asUnitAcceleration()!
        } else if lhs.isUnitDuration && rhs.isUnitDuration {
            return lhs.asUnitDuration()! > rhs.asUnitDuration()!
        } else if lhs.isUnitFrequency && rhs.isUnitFrequency {
            return lhs.asUnitFrequency()! > rhs.asUnitFrequency()!
        } else if lhs.isUnitSpeed && rhs.isUnitSpeed {
            return lhs.asUnitSpeed()! > rhs.asUnitSpeed()!
        } else if lhs.isUnitEnergy && rhs.isUnitEnergy {
            return lhs.asUnitEnergy()! > rhs.asUnitEnergy()!
        } else if lhs.isUnitPower && rhs.isUnitPower {
            return lhs.asUnitPower()! > rhs.asUnitPower()!
        } else if lhs.isUnitTemperatur && rhs.isUnitTemperatur {
            return lhs.asUnitTemperature()! > rhs.asUnitTemperature()!
        } else if lhs.isUnitIlluminance && rhs.isUnitIlluminance {
            return lhs.asUnitIlluminance()! > rhs.asUnitIlluminance()!
        } else if lhs.isUnitElectricCharge && rhs.isUnitElectricCharge {
            return lhs.asUnitElectricCharge()! > rhs.asUnitElectricCharge()!
        } else if lhs.isUnitElectricCurrent && rhs.isUnitElectricCurrent {
            return lhs.asUnitElectricCurrent()! > rhs.asUnitElectricCurrent()!
        } else if lhs.isUnitElectricPotentialDifference && rhs.isUnitElectricPotentialDifference {
            return lhs.asUnitElectricPotentialDifference()! > rhs.asUnitElectricPotentialDifference()!
        } else if lhs.isUnitElectricResistance && rhs.isUnitElectricResistance {
            return lhs.asUnitElectricResistence()! > rhs.asUnitElectricResistence()!
        } else if lhs.isUnitConcentrationMass && rhs.isUnitConcentrationMass {
            return lhs.asUnitConcentrationMass()! > rhs.asUnitConcentrationMass()!
        } else if lhs.isUnitDispersion && rhs.isUnitDispersion {
            return lhs.asUnitDispersion()! > rhs.asUnitDispersion()!
        } else if lhs.isUnitFuelEfficiency && rhs.isUnitFuelEfficiency {
            return lhs.asUnitFuelEfficiency()! > rhs.asUnitFuelEfficiency()!
        } else if lhs.isUnitInformationStorage && rhs.isUnitInformationStorage {
            return lhs.asUnitInformationStorage()! > rhs.asUnitInformationStorage()!
        }
        return false
    }

    /// Operator `EvalValue >= EvalValue`.
    /// - Parameters:
    ///   - lhs: left-side value
    ///   - rhs: right-side value
    /// - Returns: `true` if `lhs >= rhs`
    public static func >= (lhs: ExpressionValue, rhs: ExpressionValue) -> Bool {
        if lhs.isNullValue && rhs.isNullValue {
            return true
        } else if lhs.isNumericValue && rhs.isNumericValue {
            return lhs.asConvertedDecimalNumber()! >= rhs.asConvertedDecimalNumber()!
        } else if lhs.isStringValue && rhs.isStringValue {
            return lhs.asString()! >= rhs.asString()!
        } else if lhs.isBooleanValue && rhs.isBooleanValue {
            return (lhs.asBoolean()! ? 1 : 0) >= (rhs.asBoolean()! ? 1 : 0)
        } else if lhs.isDateTime && rhs.isDateTime {
            return lhs.asDateTime()! >= rhs.asDateTime()!
        } else if lhs.isUnitArea && rhs.isUnitArea {
            return lhs.asUnitArea()! >= rhs.asUnitArea()!
        } else if lhs.isUnitLength && rhs.isUnitLength {
            return lhs.asUnitLength()! >= rhs.asUnitLength()!
        } else if lhs.isUnitVolume && rhs.isUnitVolume {
            return lhs.asUnitVolume()! >= rhs.asUnitVolume()!
        } else if lhs.isUnitAngle && rhs.isUnitAngle {
            return lhs.asUnitAngle()! >= rhs.asUnitAngle()!
        } else if lhs.isUnitMass && rhs.isUnitMass {
            return lhs.asUnitMass()! >= rhs.asUnitMass()!
        } else if lhs.isUnitPressure && rhs.isUnitPressure {
            return lhs.asUnitPressure()! >= rhs.asUnitPressure()!
        } else if lhs.isUnitAcceleration && rhs.isUnitAcceleration {
            return lhs.asUnitAcceleration()! >= rhs.asUnitAcceleration()!
        } else if lhs.isUnitDuration && rhs.isUnitDuration {
            return lhs.asUnitDuration()! >= rhs.asUnitDuration()!
        } else if lhs.isUnitFrequency && rhs.isUnitFrequency {
            return lhs.asUnitFrequency()! >= rhs.asUnitFrequency()!
        } else if lhs.isUnitSpeed && rhs.isUnitSpeed {
            return lhs.asUnitSpeed()! >= rhs.asUnitSpeed()!
        } else if lhs.isUnitEnergy && rhs.isUnitEnergy {
            return lhs.asUnitEnergy()! >= rhs.asUnitEnergy()!
        } else if lhs.isUnitPower && rhs.isUnitPower {
            return lhs.asUnitPower()! >= rhs.asUnitPower()!
        } else if lhs.isUnitTemperatur && rhs.isUnitTemperatur {
            return lhs.asUnitTemperature()! >= rhs.asUnitTemperature()!
        } else if lhs.isUnitIlluminance && rhs.isUnitIlluminance {
            return lhs.asUnitIlluminance()! >= rhs.asUnitIlluminance()!
        } else if lhs.isUnitElectricCharge && rhs.isUnitElectricCharge {
            return lhs.asUnitElectricCharge()! >= rhs.asUnitElectricCharge()!
        } else if lhs.isUnitElectricCurrent && rhs.isUnitElectricCurrent {
            return lhs.asUnitElectricCurrent()! >= rhs.asUnitElectricCurrent()!
        } else if lhs.isUnitElectricPotentialDifference && rhs.isUnitElectricPotentialDifference {
            return lhs.asUnitElectricPotentialDifference()! >= rhs.asUnitElectricPotentialDifference()!
        } else if lhs.isUnitElectricResistance && rhs.isUnitElectricResistance {
            return lhs.asUnitElectricResistence()! >= rhs.asUnitElectricResistence()!
        } else if lhs.isUnitConcentrationMass && rhs.isUnitConcentrationMass {
            return lhs.asUnitConcentrationMass()! >= rhs.asUnitConcentrationMass()!
        } else if lhs.isUnitDispersion && rhs.isUnitDispersion {
            return lhs.asUnitDispersion()! >= rhs.asUnitDispersion()!
        } else if lhs.isUnitFuelEfficiency && rhs.isUnitFuelEfficiency {
            return lhs.asUnitFuelEfficiency()! >= rhs.asUnitFuelEfficiency()!
        } else if lhs.isUnitInformationStorage && rhs.isUnitInformationStorage {
            return lhs.asUnitInformationStorage()! >= rhs.asUnitInformationStorage()!
        } else if lhs.type == rhs.type {
            if let lhsHash = lhs.value as? (any Hashable), let rhsHash = rhs.value as? (any Hashable) {
                return lhsHash.hashValue == rhsHash.hashValue
            }
        }
        return false
    }

    /// Operator `EvalValue < EvalValue`.
    /// - Parameters:
    ///   - lhs: left-side value
    ///   - rhs: right-side value
    /// - Returns: `true` if `lhs < rhs`
    public static func < (lhs: ExpressionValue, rhs: ExpressionValue) -> Bool {
        if lhs.isNumericValue && rhs.isNumericValue {
            return lhs.asConvertedDecimalNumber()! < rhs.asConvertedDecimalNumber()!
        } else if lhs.isStringValue && rhs.isStringValue {
            return lhs.asString()! < rhs.asString()!
        } else if lhs.isBooleanValue && rhs.isBooleanValue {
            return (lhs.asBoolean()! ? 1 : 0) < (rhs.asBoolean()! ? 1 : 0)
        } else if lhs.isDateTime && rhs.isDateTime {
            return lhs.asDateTime()! < rhs.asDateTime()!
        } else if lhs.isUnitArea && rhs.isUnitArea {
            return lhs.asUnitArea()! < rhs.asUnitArea()!
        } else if lhs.isUnitLength && rhs.isUnitLength {
            return lhs.asUnitLength()! < rhs.asUnitLength()!
        } else if lhs.isUnitVolume && rhs.isUnitVolume {
            return lhs.asUnitVolume()! < rhs.asUnitVolume()!
        } else if lhs.isUnitAngle && rhs.isUnitAngle {
            return lhs.asUnitAngle()! < rhs.asUnitAngle()!
        } else if lhs.isUnitMass && rhs.isUnitMass {
            return lhs.asUnitMass()! < rhs.asUnitMass()!
        } else if lhs.isUnitPressure && rhs.isUnitPressure {
            return lhs.asUnitPressure()! < rhs.asUnitPressure()!
        } else if lhs.isUnitAcceleration && rhs.isUnitAcceleration {
            return lhs.asUnitAcceleration()! < rhs.asUnitAcceleration()!
        } else if lhs.isUnitDuration && rhs.isUnitDuration {
            return lhs.asUnitDuration()! < rhs.asUnitDuration()!
        } else if lhs.isUnitFrequency && rhs.isUnitFrequency {
            return lhs.asUnitFrequency()! < rhs.asUnitFrequency()!
        } else if lhs.isUnitSpeed && rhs.isUnitSpeed {
            return lhs.asUnitSpeed()! < rhs.asUnitSpeed()!
        } else if lhs.isUnitEnergy && rhs.isUnitEnergy {
            return lhs.asUnitEnergy()! < rhs.asUnitEnergy()!
        } else if lhs.isUnitPower && rhs.isUnitPower {
            return lhs.asUnitPower()! < rhs.asUnitPower()!
        } else if lhs.isUnitTemperatur && rhs.isUnitTemperatur {
            return lhs.asUnitTemperature()! < rhs.asUnitTemperature()!
        } else if lhs.isUnitIlluminance && rhs.isUnitIlluminance {
            return lhs.asUnitIlluminance()! < rhs.asUnitIlluminance()!
        } else if lhs.isUnitElectricCharge && rhs.isUnitElectricCharge {
            return lhs.asUnitElectricCharge()! < rhs.asUnitElectricCharge()!
        } else if lhs.isUnitElectricCurrent && rhs.isUnitElectricCurrent {
            return lhs.asUnitElectricCurrent()! < rhs.asUnitElectricCurrent()!
        } else if lhs.isUnitElectricPotentialDifference && rhs.isUnitElectricPotentialDifference {
            return lhs.asUnitElectricPotentialDifference()! < rhs.asUnitElectricPotentialDifference()!
        } else if lhs.isUnitElectricResistance && rhs.isUnitElectricResistance {
            return lhs.asUnitElectricResistence()! < rhs.asUnitElectricResistence()!
        } else if lhs.isUnitConcentrationMass && rhs.isUnitConcentrationMass {
            return lhs.asUnitConcentrationMass()! < rhs.asUnitConcentrationMass()!
        } else if lhs.isUnitDispersion && rhs.isUnitDispersion {
            return lhs.asUnitDispersion()! < rhs.asUnitDispersion()!
        } else if lhs.isUnitFuelEfficiency && rhs.isUnitFuelEfficiency {
            return lhs.asUnitFuelEfficiency()! < rhs.asUnitFuelEfficiency()!
        } else if lhs.isUnitInformationStorage && rhs.isUnitInformationStorage {
            return lhs.asUnitInformationStorage()! < rhs.asUnitInformationStorage()!
        }
        return false
    }

    /// Operator `EvalValue <= EvalValue`.
    /// - Parameters:
    ///   - lhs: left-side value
    ///   - rhs: right-side value
    /// - Returns: `true` if `lhs <= rhs`
    public static func <= (lhs: ExpressionValue, rhs: ExpressionValue) -> Bool {
        if lhs.isNullValue && rhs.isNullValue {
            return true
        } else if lhs.isNumericValue && rhs.isNumericValue {
            return lhs.asConvertedDecimalNumber()! <= rhs.asConvertedDecimalNumber()!
        } else if lhs.isStringValue && rhs.isStringValue {
            return lhs.asString()! <= rhs.asString()!
        } else if lhs.isBooleanValue && rhs.isBooleanValue {
            return (lhs.asBoolean()! ? 1 : 0) <= (rhs.asBoolean()! ? 1 : 0)
        } else if lhs.isDateTime && rhs.isDateTime {
            return lhs.asDateTime()! <= rhs.asDateTime()!
        } else if lhs.isUnitArea && rhs.isUnitArea {
            return lhs.asUnitArea()! <= rhs.asUnitArea()!
        } else if lhs.isUnitLength && rhs.isUnitLength {
            return lhs.asUnitLength()! <= rhs.asUnitLength()!
        } else if lhs.isUnitVolume && rhs.isUnitVolume {
            return lhs.asUnitVolume()! <= rhs.asUnitVolume()!
        } else if lhs.isUnitAngle && rhs.isUnitAngle {
            return lhs.asUnitAngle()! <= rhs.asUnitAngle()!
        } else if lhs.isUnitMass && rhs.isUnitMass {
            return lhs.asUnitMass()! <= rhs.asUnitMass()!
        } else if lhs.isUnitPressure && rhs.isUnitPressure {
            return lhs.asUnitPressure()! <= rhs.asUnitPressure()!
        } else if lhs.isUnitAcceleration && rhs.isUnitAcceleration {
            return lhs.asUnitAcceleration()! <= rhs.asUnitAcceleration()!
        } else if lhs.isUnitDuration && rhs.isUnitDuration {
            return lhs.asUnitDuration()! <= rhs.asUnitDuration()!
        } else if lhs.isUnitFrequency && rhs.isUnitFrequency {
            return lhs.asUnitFrequency()! <= rhs.asUnitFrequency()!
        } else if lhs.isUnitSpeed && rhs.isUnitSpeed {
            return lhs.asUnitSpeed()! <= rhs.asUnitSpeed()!
        } else if lhs.isUnitEnergy && rhs.isUnitEnergy {
            return lhs.asUnitEnergy()! <= rhs.asUnitEnergy()!
        } else if lhs.isUnitPower && rhs.isUnitPower {
            return lhs.asUnitPower()! <= rhs.asUnitPower()!
        } else if lhs.isUnitTemperatur && rhs.isUnitTemperatur {
            return lhs.asUnitTemperature()! <= rhs.asUnitTemperature()!
        } else if lhs.isUnitIlluminance && rhs.isUnitIlluminance {
            return lhs.asUnitIlluminance()! <= rhs.asUnitIlluminance()!
        } else if lhs.isUnitElectricCharge && rhs.isUnitElectricCharge {
            return lhs.asUnitElectricCharge()! <= rhs.asUnitElectricCharge()!
        } else if lhs.isUnitElectricCurrent && rhs.isUnitElectricCurrent {
            return lhs.asUnitElectricCurrent()! <= rhs.asUnitElectricCurrent()!
        } else if lhs.isUnitElectricPotentialDifference && rhs.isUnitElectricPotentialDifference {
            return lhs.asUnitElectricPotentialDifference()! <= rhs.asUnitElectricPotentialDifference()!
        } else if lhs.isUnitElectricResistance && rhs.isUnitElectricResistance {
            return lhs.asUnitElectricResistence()! <= rhs.asUnitElectricResistence()!
        } else if lhs.isUnitConcentrationMass && rhs.isUnitConcentrationMass {
            return lhs.asUnitConcentrationMass()! <= rhs.asUnitConcentrationMass()!
        } else if lhs.isUnitDispersion && rhs.isUnitDispersion {
            return lhs.asUnitDispersion()! <= rhs.asUnitDispersion()!
        } else if lhs.isUnitFuelEfficiency && rhs.isUnitFuelEfficiency {
            return lhs.asUnitFuelEfficiency()! <= rhs.asUnitFuelEfficiency()!
        } else if lhs.isUnitInformationStorage && rhs.isUnitInformationStorage {
            return lhs.asUnitInformationStorage()! <= rhs.asUnitInformationStorage()!
        } else if lhs.type == rhs.type {
            if let lhsHash = lhs.value as? (any Hashable), let rhsHash = rhs.value as? (any Hashable) {
                return lhsHash.hashValue == rhsHash.hashValue
            }
        }
        return false
    }

}
