//
//  FunctionUNITAREA.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITAREA()
///
/// Implementation of expression-function `UNITAREA()`.
///
/// The UNITAREA() function returns a `Measurement` of type `UnitArea`.
///
/// ```
/// UNITAREA(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITAREA(100.0, "mm²")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `Mm²`, `km²`, `m²`, `cm²`, `mm²`, `µm²`, `nm²`
/// - `in²`, `ft²`, `yd²`, `mi²`
/// - `ac`, `a`, `ha`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITAREA: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITAREA"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITAREA") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITAREA.symbolFunction,
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
            let unit: Optional<UnitArea> = FunctionUNITAREA.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitArea> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITAREA.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITAREA.symbolFunction
    }

    /// Convers a symbol into an `UnitArea`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitArea` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitArea> {
        if sym == "Mm²" {
            return Optional.some(UnitArea.squareMegameters)
        } else if sym == "km²" {
            return Optional.some(UnitArea.squareKilometers)
        } else if sym == "m²" {
            return Optional.some(UnitArea.squareMeters)
        } else if sym == "cm²" {
            return Optional.some(UnitArea.squareCentimeters)
        } else if sym == "mm²" {
            return Optional.some(UnitArea.squareMillimeters)
        } else if sym == "µm²" {
            return Optional.some(UnitArea.squareMicrometers)
        } else if sym == "nm²" {
            return Optional.some(UnitArea.squareNanometers)
        } else if sym == "in²" {
            return Optional.some(UnitArea.squareInches)
        } else if sym == "ft²" {
            return Optional.some(UnitArea.squareFeet)
        } else if sym == "yd²" {
            return Optional.some(UnitArea.squareYards)
        } else if sym == "mi²" {
            return Optional.some(UnitArea.squareMiles)
        } else if sym == "ac" {
            return Optional.some(UnitArea.acres)
        } else if sym == "a" {
            return Optional.some(UnitArea.ares)
        } else if sym == "ha" {
            return Optional.some(UnitArea.hectares)
        }
        return Optional.none
    }

}
