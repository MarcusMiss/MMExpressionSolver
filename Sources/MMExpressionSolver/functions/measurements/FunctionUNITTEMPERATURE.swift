//
//  FunctionUNITTEMPERATURE.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITTEMPERATURE()
///
/// Implementation of expression-function `UNITTEMPERATURE()`.
///
/// The UNITTEMPERATURE() function returns a `Measurement` of type `UnitPower`.
///
/// ```
/// UNITTEMPERATURE(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITTEMPERATURE(100.0, "°C")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `K`, `°C`, `°F`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITTEMPERATURE: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITTEMPERATURE"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITTEMPERATURE") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITTEMPERATURE.symbolFunction,
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
            let unit: Optional<UnitTemperature> = FunctionUNITTEMPERATURE.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitTemperature> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITTEMPERATURE.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITTEMPERATURE.symbolFunction
    }

    /// Convers a symbol into an `UnitTemperature`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitTemperature` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitTemperature> {
        if sym == "K" {
            return Optional.some(UnitTemperature.kelvin)
        } else if sym == "°C" {
            return Optional.some(UnitTemperature.celsius)
        } else if sym == "°F" {
            return Optional.some(UnitTemperature.fahrenheit)
        }
        return Optional.none
    }

}
