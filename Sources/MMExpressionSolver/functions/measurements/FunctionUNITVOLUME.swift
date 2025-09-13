//
//  FunctionUNITVOLUME.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITVOLUME()
///
/// Implementation of expression-function `UNITVOLUME()`.
///
/// The UNITVOLUME() function returns a `Measurement` of type `UnitVolume`.
///
/// ```
/// UNITVOLUME(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITVOLUME(100.0, "cm³")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `ML`, `kL`, `L`, `dL`, `cL`, `mL`
/// - `km³`, `m³`, `dm³`, `cm³`, `mm³`
/// - `in³`, `ft³`, `yd³`, `mi³`
/// - `af`, `bsh`, `tsp`, `tbsp`, `fl oz`
/// - `cup`, `pt`, `qt`, `gal`, `metric cup`
/// - `imp.tsp`, `imp.tbsp`, `imp.fl oz`, `imp.pt`, `imp.qt`, `imp.gal`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITVOLUME: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITVOLUME"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITVOLUME") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITVOLUME.symbolFunction,
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
            let unit: Optional<UnitVolume> = FunctionUNITVOLUME.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitVolume> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITVOLUME.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITVOLUME.symbolFunction
    }

    /// Convers a symbol into an `UnitVolume`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitVolume` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitVolume> {
        if sym == "ML" {
            return Optional.some(UnitVolume.megaliters)
        } else if sym == "kL" {
            return Optional.some(UnitVolume.kiloliters)
        } else if sym == "L" {
            return Optional.some(UnitVolume.liters)
        } else if sym == "dL" {
            return Optional.some(UnitVolume.deciliters)
        } else if sym == "cL" {
            return Optional.some(UnitVolume.centiliters)
        } else if sym == "mL" {
            return Optional.some(UnitVolume.milliliters)
        } else if sym == "km³" {
            return Optional.some(UnitVolume.cubicKilometers)
        } else if sym == "m³" {
            return Optional.some(UnitVolume.cubicMeters)
        } else if sym == "dm³" {
            return Optional.some(UnitVolume.cubicDecimeters)
        } else if sym == "cm³" {
            return Optional.some(UnitVolume.cubicCentimeters)
        } else if sym == "mm³" {
            return Optional.some(UnitVolume.cubicMillimeters)
        } else if sym == "in³" {
            return Optional.some(UnitVolume.cubicInches)
        } else if sym == "ft³" {
            return Optional.some(UnitVolume.cubicFeet)
        } else if sym == "yd³" {
            return Optional.some(UnitVolume.cubicYards)
        } else if sym == "mi³" {
            return Optional.some(UnitVolume.cubicMiles)
        } else if sym == "af" {
            return Optional.some(UnitVolume.acreFeet)
        } else if sym == "bsh" {
            return Optional.some(UnitVolume.bushels)
        } else if sym == "tsp" {
            return Optional.some(UnitVolume.teaspoons)
        } else if sym == "tbsp" {
            return Optional.some(UnitVolume.tablespoons)
        } else if sym == "fl oz" {
            return Optional.some(UnitVolume.fluidOunces)
        } else if sym == "cup" {
            return Optional.some(UnitVolume.cups)
        } else if sym == "pt" {
            return Optional.some(UnitVolume.pints)
        } else if sym == "qt" {
            return Optional.some(UnitVolume.quarts)
        } else if sym == "gal" {
            return Optional.some(UnitVolume.gallons)
        } else if sym == "metric cup" {
            return Optional.some(UnitVolume.metricCups)
        } else if sym == "imp.tsp" {
            return Optional.some(UnitVolume.imperialTeaspoons)
        } else if sym == "imp.tbsp" {
            return Optional.some(UnitVolume.imperialTablespoons)
        } else if sym == "imp.fl oz" {
            return Optional.some(UnitVolume.imperialFluidOunces)
        } else if sym == "imp.pt" {
            return Optional.some(UnitVolume.imperialPints)
        } else if sym == "imp.qt" {
            return Optional.some(UnitVolume.imperialQuarts)
        } else if sym == "imp.gal" {
            return Optional.some(UnitVolume.imperialGallons)
        }
        return Optional.none
    }

}
