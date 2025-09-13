//
//  FunctionUNITELECTRICRESISTENCE.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITELECTRICRESISTENCE()
///
/// Implementation of expression-function `UNITELECTRICRESISTENCE()`.
///
/// The UNITELECTRICRESISTENCE() function returns a `Measurement` of type `UnitElectricResistance`.
///
/// ```
/// UNITELECTRICRESISTENCE(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITELECTRICRESISTENCE(100.0, "Ω")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `MΩ`, `kΩ`, `Ω`, `mΩ`, `µΩ`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITELECTRICRESISTENCE: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITELECTRICRESISTENCE"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITELECTRICRESISTENCE") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITELECTRICRESISTENCE.symbolFunction,
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
            let unit: Optional<UnitElectricResistance> = FunctionUNITELECTRICRESISTENCE.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitElectricResistance> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITELECTRICRESISTENCE.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITELECTRICRESISTENCE.symbolFunction
    }

    /// Convers a symbol into an `UnitElectricResistance`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitElectricResistance` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitElectricResistance> {
        if sym == "MΩ" {
            return Optional.some(UnitElectricResistance.megaohms)
        } else if sym == "kΩ" {
            return Optional.some(UnitElectricResistance.kiloohms)
        } else if sym == "Ω" {
            return Optional.some(UnitElectricResistance.ohms)
        } else if sym == "mΩ" {
            return Optional.some(UnitElectricResistance.milliohms)
        } else if sym == "µΩ" {
            return Optional.some(UnitElectricResistance.microohms)
        }
        return Optional.none
    }

}
