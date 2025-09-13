//
//  FunctionUNITLENGTH.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITLENGTH()
///
/// Implementation of expression-function `UNITLENGTH()`.
///
/// The UNITLENGTH() function returns a `Measurement` of type `UnitLength`.
///
/// ```
/// UNITLENGTH(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITLENGTH(100.0, "m")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `Mm`, `kM`, `hm`, `dam`, `m`, `dm`, `cm`, `mm`, `µm`, `nm`, `pm`
/// - `in`, `ft`, `yd`, `mi`, `smi`, `ly`
/// - `NM`, `fur`, `ua`, `pc`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITLENGTH: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITLENGTH"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITLENGTH") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITLENGTH.symbolFunction,
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
            let unit: Optional<UnitLength> = FunctionUNITLENGTH.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitLength> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITLENGTH.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITLENGTH.symbolFunction
    }

    /// Convers a symbol into an `UnitLengt`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitLength` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitLength> {
        if sym == "Mm" {
            return Optional.some(UnitLength.megameters)
        } else if sym == "kM" {
            return Optional.some(UnitLength.kilometers)
        } else if sym == "hm" {
            return Optional.some(UnitLength.hectometers)
        } else if sym == "dam" {
            return Optional.some(UnitLength.decameters)
        } else if sym == "m" {
            return Optional.some(UnitLength.meters)
        } else if sym == "dm" {
            return Optional.some(UnitLength.decimeters)
        } else if sym == "cm" {
            return Optional.some(UnitLength.centimeters)
        } else if sym == "mm" {
            return Optional.some(UnitLength.millimeters)
        } else if sym == "µm" {
            return Optional.some(UnitLength.micrometers)
        } else if sym == "nm" {
            return Optional.some(UnitLength.nanometers)
        } else if sym == "pm" {
            return Optional.some(UnitLength.picometers)
        } else if sym == "in" {
            return Optional.some(UnitLength.inches)
        } else if sym == "ft" {
            return Optional.some(UnitLength.feet)
        } else if sym == "yd" {
            return Optional.some(UnitLength.yards)
        } else if sym == "mi" {
            return Optional.some(UnitLength.miles)
        } else if sym == "smi" {
            return Optional.some(UnitLength.scandinavianMiles)
        } else if sym == "ly" {
            return Optional.some(UnitLength.lightyears)
        } else if sym == "NM" {
            return Optional.some(UnitLength.nauticalMiles)
        } else if sym == "ftm" {
            return Optional.some(UnitLength.fathoms)
        } else if sym == "fur" {
            return Optional.some(UnitLength.furlongs)
        } else if sym == "ua" {
            return Optional.some(UnitLength.astronomicalUnits)
        } else if sym == "pc" {
            return Optional.some(UnitLength.parsecs)
        }
        return Optional.none
    }

}
