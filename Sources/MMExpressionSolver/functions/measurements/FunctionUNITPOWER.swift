//
//  FunctionUNITPOWER.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITPOWER()
///
/// Implementation of expression-function `UNITPOWER()`.
///
/// The UNITPOWER() function returns a `Measurement` of type `UnitPower`.
///
/// ```
/// UNITPOWER(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITPOWER(100.0, "W")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `TW`, `GW`, `MW`, `kW`, `W`, `mW`, `µW`, `nW`, `pW`, `fW`, `hp`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITPOWER: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITPOWER"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITPOWER") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITPOWER.symbolFunction,
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
            let unit: Optional<UnitPower> = FunctionUNITPOWER.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitPower> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITPOWER.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITPOWER.symbolFunction
    }

    /// Convers a symbol into an `UnitPower`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitPower` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitPower> {
        if sym == "TW" {
            return Optional.some(UnitPower.terawatts)
        } else if sym == "GW" {
            return Optional.some(UnitPower.gigawatts)
        } else if sym == "MW" {
            return Optional.some(UnitPower.megawatts)
        } else if sym == "kW" {
            return Optional.some(UnitPower.kilowatts)
        } else if sym == "W" {
            return Optional.some(UnitPower.watts)
        } else if sym == "mW" {
            return Optional.some(UnitPower.milliwatts)
        } else if sym == "µW" {
            return Optional.some(UnitPower.microwatts)
        } else if sym == "nW" {
            return Optional.some(UnitPower.nanowatts)
        } else if sym == "pW" {
            return Optional.some(UnitPower.picowatts)
        } else if sym == "fW" {
            return Optional.some(UnitPower.femtowatts)
        } else if sym == "hp" {
            return Optional.some(UnitPower.horsepower)
        }
        return Optional.none
    }

}
