//
//  InfixOperatorPlus.swift
//  MMExpressionSolver
//

import Foundation

/// Infix-operator _Addition_
///
/// Calculates `value1 + value2`.
///
/// This left-assiciative operator performs Plus-operation for numeric types.
/// In case of String-types a string-concatination will be done.
///
/// When at least one of operands has `nil`-value the result will be `nil`.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class InfixOperatorPlus: ExpressionOperator {

    /// Symbol of this operator
    static let symbolOperator: String = "+"

    // MARK: - Protocol ExpressionOperator

    public var id: OperatorIdentifier { get { OperatorIdentifier("InfixOperatorPlus") } }

    public var definition: ExpressionOperatorDefinition {
        get {
            return ExpressionOperatorDefinition(type: .infix, precedence: .additive, isLeftAssociative: true, isLazy: false)
        }
    }

    public var symbols: [String] { get { [InfixOperatorPlus.symbolOperator] } }

    public func evaluateOperator(context: any ExpressionEvaluationContext,
                                 operatorToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        // Check arguments
        let p1: ExpressionValue = arguments[0]
        let p2: ExpressionValue = arguments[1]
        if p1.isNullValue || p2.isNullValue {
            return ExpressionValue.ofNil()
        }
        // Process operator
        if p1.isNumericValue && p2.isNumericValue {
            if p1.isIntegerValue && p2.isIntegerValue {
                return ExpressionValue.of(Int(p1.asInteger()! + p2.asInteger()!))
            } else {
                return ExpressionValue.of(p1.asConvertedDecimalNumber()! + p2.asConvertedDecimalNumber()!)
            }
        } else if p1.isStringValue && p2.isStringValue {
            return ExpressionValue.of(p1.asString()! + p2.asString()!)
    // Physical dimension
        } else if p1.isUnitArea && p2.isUnitArea {
            return ExpressionValue.of(p1.asUnitArea()! + p2.asUnitArea()!)
        } else if p1.isUnitLength && p2.isUnitLength {
            return ExpressionValue.of(p1.asUnitLength()! + p2.asUnitLength()!)
        } else if p1.isUnitVolume && p2.isUnitVolume {
            return ExpressionValue.of(p1.asUnitVolume()! + p2.asUnitVolume()!)
        } else if p1.isUnitAngle && p2.isUnitAngle {
            return ExpressionValue.of( p1.asUnitAngle()! + p2.asUnitAngle()!)
    // Mass, Weight, and Force
        } else if p1.isUnitMass && p2.isUnitMass {
            return ExpressionValue.of(p1.asUnitMass()! + p2.asUnitMass()!)
        } else if p1.isUnitPressure && p2.isUnitPressure {
            return ExpressionValue.of(p1.asUnitPressure()! + p2.asUnitPressure()!)
    // Time and Motion
        } else if p1.isUnitAcceleration && p2.isUnitAcceleration {
            return ExpressionValue.of(p1.asUnitAcceleration()! + p2.asUnitAcceleration()!)
        } else if p1.isUnitDuration && p2.isUnitDuration {
            return ExpressionValue.of(p1.asUnitDuration()! + p2.asUnitDuration()!)
        } else if p1.isUnitFrequency && p2.isUnitFrequency {
            return ExpressionValue.of(p1.asUnitFrequency()! + p2.asUnitFrequency()!)
        } else if p1.isUnitSpeed && p2.isUnitSpeed {
            return ExpressionValue.of(p1.asUnitSpeed()! + p2.asUnitSpeed()!)
    // Energy, Heat and Light
        } else if p1.isUnitEnergy && p2.isUnitEnergy {
            return ExpressionValue.of(p1.asUnitEnergy()! + p2.asUnitEnergy()!)
        } else if p1.isUnitPower && p2.isUnitPower {
            return ExpressionValue.of(p1.asUnitPower()! + p2.asUnitPower()!)
        } else if p1.isUnitTemperatur && p2.isUnitTemperatur {
            return ExpressionValue.of(p1.asUnitTemperature()! + p2.asUnitTemperature()!)
        } else if p1.isUnitIlluminance && p2.isUnitIlluminance {
            return ExpressionValue.of(p1.asUnitIlluminance()! + p2.asUnitIlluminance()!)
    // Electricity
        } else if p1.isUnitElectricCharge && p2.isUnitElectricCharge {
            return ExpressionValue.of(p1.asUnitElectricCharge()! + p2.asUnitElectricCharge()!)
        } else if p1.isUnitElectricCurrent && p2.isUnitElectricCurrent {
            return ExpressionValue.of(p1.asUnitElectricCurrent()! + p2.asUnitElectricCurrent()!)
        } else if p1.isUnitElectricPotentialDifference && p2.isUnitElectricPotentialDifference {
            return ExpressionValue.of(p1.asUnitElectricPotentialDifference()! + p2.asUnitElectricPotentialDifference()!)
        } else if p1.isUnitElectricResistance && p2.isUnitElectricResistance {
            return ExpressionValue.of(p1.asUnitElectricResistence()! + p2.asUnitElectricResistence()!)
    // Misc
        } else if p1.isUnitConcentrationMass && p2.isUnitConcentrationMass {
            return ExpressionValue.of(p1.asUnitConcentrationMass()! + p2.asUnitConcentrationMass()!)
        } else if p1.isUnitDispersion && p2.isUnitDispersion {
            return ExpressionValue.of(p1.asUnitDispersion()! + p2.asUnitDispersion()!)
        } else if p1.isUnitFuelEfficiency && p2.isUnitFuelEfficiency {
            return ExpressionValue.of(p1.asUnitFuelEfficiency()! + p2.asUnitFuelEfficiency()!)
        } else if p1.isUnitInformationStorage && p2.isUnitInformationStorage {
            return ExpressionValue.of(p1.asUnitInformationStorage()! + p2.asUnitInformationStorage()!)
        }
        if !(p1.isNumericValue || p1.isStringValue) {
            throw ExpressionError.nonMatchingOperandLeft(token: operatorToken, value: p1.asStringForError())
        }
        throw ExpressionError.nonMatchingOperandLeft(token: operatorToken, value: p2.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return InfixOperatorPlus.symbolOperator
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "InfixOperatorPlus()"
    }

}
