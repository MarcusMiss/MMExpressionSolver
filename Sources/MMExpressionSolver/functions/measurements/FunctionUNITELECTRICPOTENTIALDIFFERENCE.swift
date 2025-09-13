//
//  FunctionUNITELECTRICPOTENTIALDIFFERENCE.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITELECTRICPOTENTIALDIFFERENCE()
///
/// Implementation of expression-function `UNITELECTRICPOTENTIALDIFFERENCE()`.
///
/// The UNITELECTRICPOTENTIALDIFFERENCE() function returns a `Measurement` of type `UnitElectricCurrent`.
///
/// ```
/// UNITELECTRICPOTENTIALDIFFERENCE(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITELECTRICPOTENTIALDIFFERENCE(100.0, "V")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `MV`, `kV`, `V`, `mV`, `µV`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITELECTRICPOTENTIALDIFFERENCE: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITELECTRICPOTENTIALDIFFERENCE"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITELECTRICPOTENTIALDIFFERENCE") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITELECTRICPOTENTIALDIFFERENCE.symbolFunction,
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
            let unit: Optional<UnitElectricPotentialDifference> = FunctionUNITELECTRICPOTENTIALDIFFERENCE.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitElectricPotentialDifference> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITELECTRICPOTENTIALDIFFERENCE.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITELECTRICPOTENTIALDIFFERENCE.symbolFunction
    }

    /// Convers a symbol into an `UnitElectricPotentialDifference`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitElectricPotentialDifference` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitElectricPotentialDifference> {
        if sym == "MV" {
            return Optional.some(UnitElectricPotentialDifference.megavolts)
        } else if sym == "kV" {
            return Optional.some(UnitElectricPotentialDifference.kilovolts)
        } else if sym == "V" {
            return Optional.some(UnitElectricPotentialDifference.volts)
        } else if sym == "mV" {
            return Optional.some(UnitElectricPotentialDifference.millivolts)
        } else if sym == "µV" {
            return Optional.some(UnitElectricPotentialDifference.microvolts)
        }
        return Optional.none
    }

}
