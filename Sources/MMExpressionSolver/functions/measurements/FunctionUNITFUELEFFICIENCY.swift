//
//  FunctionUNITFUELEFFICIENCY.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITFUELEFFICIENCY()
///
/// Implementation of expression-function `UNITFUELEFFICIENCY()`.
///
/// The UNITFUELEFFICIENCY() function returns a `Measurement` of type `UnitFuelEfficiency`.
///
/// ```
/// UNITFUELEFFICIENCY(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITFUELEFFICIENCY(100.0, "L/100km")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `L/100km`, `mpg`, `imp.mpg`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITFUELEFFICIENCY: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITFUELEFFICIENCY"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITFUELEFFICIENCY") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITFUELEFFICIENCY.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [.double, .float, .decimal, .int]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameUnit,
                                        strictTypes: [.string]),
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        let p2: ExpressionValue = arguments[1]
        if p1.isNumericValue && p2.isStringValue {
            let value: Double = p1.asConvertedDoubleNumber()!
            let unit: Optional<UnitFuelEfficiency> = FunctionUNITFUELEFFICIENCY.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitFuelEfficiency> = Measurement(value: value, unit: unit!)
            return ExpressionValue.of(m)
        }
        if !p1.isNumericValue {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: functionToken.value,
                                                       paramName: ExpressionFunctionParameter.nameValue,
                                                       value: p1.asStringForError())
        }
        throw ExpressionError.invalidParameterType(token: functionToken,
                                                   funcName: functionToken.value,
                                                   paramName: ExpressionFunctionParameter.nameUnit,
                                                   value: p2.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionUNITFUELEFFICIENCY.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITFUELEFFICIENCY.symbolFunction
    }

    /// Convers a symbol into an `UnitConcentrationMass`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitConcentrationMass` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitFuelEfficiency> {
        if sym == "L/100km" {
            return Optional.some(UnitFuelEfficiency.litersPer100Kilometers)
        } else if sym == "mpg" {
            return Optional.some(UnitFuelEfficiency.milesPerGallon)
        } else if sym == "imp.mpg" {
            return Optional.some(UnitFuelEfficiency.milesPerImperialGallon)
        }
        return Optional.none
    }

}

