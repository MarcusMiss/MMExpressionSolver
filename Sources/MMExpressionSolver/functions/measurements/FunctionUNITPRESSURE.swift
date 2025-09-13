//
//  FunctionUNITPRESSURE.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITPRESSURE()
///
/// Implementation of expression-function `UNITPRESSURE()`.
///
/// The UNITMASS() function returns a `Measurement` of type `UnitPressure`.
///
/// ```
/// UNITPRESSURE(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITPRESSURE(100.0, "bar")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `N/m²`
/// - `GPa`, `MPa`, `kPa`, `hPa`
/// - `inHg`, `bar`, `mbar`, `mmHg`, `psi`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITPRESSURE: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITPRESSURE"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITPRESSURE") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITPRESSURE.symbolFunction,
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
            let unit: Optional<UnitPressure> = FunctionUNITPRESSURE.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitPressure> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITPRESSURE.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITPRESSURE.symbolFunction
    }

    /// Convers a symbol into an `UnitPressure`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitPressure` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitPressure> {
        if sym == "N/m²" {
            return Optional.some(UnitPressure.newtonsPerMetersSquared)
        } else if sym == "GPa" {
            return Optional.some(UnitPressure.gigapascals)
        } else if sym == "MPa" {
            return Optional.some(UnitPressure.megapascals)
        } else if sym == "kPa" {
            return Optional.some(UnitPressure.kilopascals)
        } else if sym == "hPa" {
            return Optional.some(UnitPressure.hectopascals)
        } else if sym == "inHg" {
            return Optional.some(UnitPressure.inchesOfMercury)
        } else if sym == "bar" {
            return Optional.some(UnitPressure.bars)
        } else if sym == "mbar" {
            return Optional.some(UnitPressure.millibars)
        } else if sym == "mmHg" {
            return Optional.some(UnitPressure.millimetersOfMercury)
        } else if sym == "psi" {
            return Optional.some(UnitPressure.poundsForcePerSquareInch)
        }
        return Optional.none
    }

}
