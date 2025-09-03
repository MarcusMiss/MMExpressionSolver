//
//  InfixOperatorDivide.swift
//  MMExpressionSolver
//

import Foundation

/// Infix-operator _Division_
///
/// Calculates `value1 / value2`.
///
/// This left-assiciative operator performs division-operation for numeric types.
///
/// When at least one of operands has `nil`-value the result will be `nil`.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class InfixOperatorDivide: ExpressionOperator {

    /// Symbol of this operator
    static let symbolOperator: String = "/"

    // MARK: - Protocol ExpressionOperator

    public var id: OperatorIdentifier { get { OperatorIdentifier("InfixOperatorDivide") } }

    public var definition: ExpressionOperatorDefinition {
        get {
            return ExpressionOperatorDefinition(type: .infix, precedence: .multiplicative, isLeftAssociative: true, isLazy: false)
        }
    }

    public var symbols: [String] { get { [InfixOperatorDivide.symbolOperator] } }

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
                let p2value: Int = p2.asInteger()!
                if p2value.isZero {
                    throw ExpressionError.divisionByZero(token: operatorToken)
                }
                return ExpressionValue.of(Int(p1.asInteger()! / p2value))!
            } else {
                let p2value: Decimal = p2.asConvertedDecimalNumber()!
                if p2value.isZero {
                    throw ExpressionError.divisionByZero(token: operatorToken)
                }
                return ExpressionValue.of(p1.asConvertedDecimalNumber()! / p2value)!
            }
        } else if p1.isNumericValue && p2.isMeasurement {
            let scalar: Double = p1.asConvertedDoubleNumber()!
            if p2.asUnitValue()!.isZero {
                throw ExpressionError.divisionByZero(token: operatorToken)
            }
            if p2.isUnitArea {          // Physical dimension
                return ExpressionValue.of(scalar / p2.asUnitArea()!)
            } else if p2.isUnitLength {
                return ExpressionValue.of(scalar / p2.asUnitLength()!)
            } else if p2.isUnitVolume {
                return ExpressionValue.of(scalar / p2.asUnitVolume()!)
            } else if p2.isUnitAngle {
                return ExpressionValue.of(scalar / p2.asUnitAngle()!)
            } else if p2.isUnitMass {   // Mass, Weight, and Force
                return ExpressionValue.of(scalar / p2.asUnitMass()!)
            } else if p2.isUnitPressure {
                return ExpressionValue.of(scalar / p2.asUnitPressure()!)
            } else if p2.isUnitAcceleration { // Time and Motion
                return ExpressionValue.of(scalar / p2.asUnitAcceleration()!)
            } else if p2.isUnitDuration {
                return ExpressionValue.of(scalar / p2.asUnitDuration()!)
            } else if p2.isUnitFrequency {
                return ExpressionValue.of(scalar / p2.asUnitFrequency()!)
            } else if p2.isUnitSpeed {
                return ExpressionValue.of(scalar / p2.asUnitSpeed()!)
            } else if p2.isUnitEnergy { // Energy, Heat and Light
                return ExpressionValue.of(scalar / p2.asUnitEnergy()!)
            } else if p2.isUnitPower {
                return ExpressionValue.of(scalar / p2.asUnitPower()!)
            } else if p2.isUnitTemperatur {
                return ExpressionValue.of(scalar / p2.asUnitTemperature()!)
            } else if p2.isUnitIlluminance {
                return ExpressionValue.of(scalar / p2.asUnitIlluminance()!)
            } else if p2.isUnitElectricCharge { // Electricity
                return ExpressionValue.of(scalar / p2.asUnitElectricCharge()!)
            } else if p2.isUnitElectricCurrent {
                return ExpressionValue.of(scalar / p2.asUnitElectricCurrent()!)
            } else if p2.isUnitElectricPotentialDifference {
                return ExpressionValue.of(scalar / p2.asUnitElectricPotentialDifference()!)
            } else if p2.isUnitElectricResistance {
                return ExpressionValue.of(scalar / p2.asUnitElectricResistence()!)
            } else if p2.isUnitConcentrationMass { // // Misc
                return ExpressionValue.of(scalar / p2.asUnitConcentrationMass()!)
            } else if p2.isUnitDispersion {
                return ExpressionValue.of(scalar / p2.asUnitDispersion()!)
            } else if p2.isUnitFuelEfficiency {
                return ExpressionValue.of(scalar / p2.asUnitFuelEfficiency()!)
            } else if p2.isUnitInformationStorage {
                return ExpressionValue.of(scalar / p2.asUnitInformationStorage()!)
            }
        } else if p1.isMeasurement && p2.isNumericValue {
            let scalar: Double = p2.asConvertedDoubleNumber()!
            if scalar.isZero {
                throw ExpressionError.divisionByZero(token: operatorToken)
            }
            if p1.isUnitArea {          // Physical dimension
                return ExpressionValue.of(p1.asUnitArea()! / scalar)
            } else if p1.isUnitLength {
                return ExpressionValue.of(p1.asUnitLength()! / scalar)
            } else if p1.isUnitVolume {
                return ExpressionValue.of(p1.asUnitVolume()! / scalar)
            } else if p1.isUnitAngle {
                return ExpressionValue.of(p1.asUnitAngle()! / scalar)
            } else if p1.isUnitMass {   // Mass, Weight, and Force
                return ExpressionValue.of(p1.asUnitMass()! / scalar)
            } else if p1.isUnitPressure {
                return ExpressionValue.of(p1.asUnitPressure()! / scalar)
            } else if p1.isUnitAcceleration { // Time and Motion
                return ExpressionValue.of(p1.asUnitAcceleration()! / scalar)
            } else if p1.isUnitDuration {
                return ExpressionValue.of(p1.asUnitDuration()! / scalar)
            } else if p1.isUnitFrequency {
                return ExpressionValue.of(p1.asUnitFrequency()! / scalar)
            } else if p1.isUnitSpeed {
                return ExpressionValue.of(p1.asUnitSpeed()! / scalar)
            } else if p1.isUnitEnergy {     // Energy, Heat and Light
                return ExpressionValue.of(p1.asUnitEnergy()! / scalar)
            } else if p1.isUnitPower {
                return ExpressionValue.of(p1.asUnitPower()! / scalar)
            } else if p1.isUnitTemperatur {
                return ExpressionValue.of(p1.asUnitTemperature()! / scalar)
            } else if p1.isUnitIlluminance {
                return ExpressionValue.of(p1.asUnitIlluminance()! / scalar)
            } else if p1.isUnitElectricCharge { // Electricity
                return ExpressionValue.of(p1.asUnitElectricCharge()! / scalar)
            } else if p1.isUnitElectricCurrent {
                return ExpressionValue.of(p1.asUnitElectricCurrent()! / scalar)
            } else if p1.isUnitElectricPotentialDifference {
                return ExpressionValue.of(p1.asUnitElectricPotentialDifference()! / scalar)
            } else if p1.isUnitElectricResistance {
                return ExpressionValue.of(p1.asUnitElectricResistence()! / scalar)
            } else if p1.isUnitConcentrationMass { // // Misc
                return ExpressionValue.of(p1.asUnitConcentrationMass()! / scalar)
            } else if p1.isUnitDispersion {
                return ExpressionValue.of(p1.asUnitDispersion()! / scalar)
            } else if p1.isUnitFuelEfficiency {
                return ExpressionValue.of(p1.asUnitFuelEfficiency()! / scalar)
            } else if p1.isUnitInformationStorage {
                return ExpressionValue.of(p1.asUnitInformationStorage()! / scalar)
            }
        }
        if !p1.isNumericValue {
            throw ExpressionError.nonMatchingOperandLeft(token: operatorToken, value: p1.asStringForError())
        }
        throw ExpressionError.nonMatchingOperandLeft(token: operatorToken, value: p2.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return InfixOperatorDivide.symbolOperator
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "InfixOperatorDivide()"
    }

}
