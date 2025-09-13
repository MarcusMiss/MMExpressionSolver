//
//  FunctionUNITELECTRICCHARGE.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITELECTRICCHARGE()
///
/// Implementation of expression-function `UNITELECTRICCHARGE()`.
///
/// The UNITELECTRICCHARGE() function returns a `Measurement` of type `UnitElectricCharge`.
///
/// ```
/// UNITELECTRICCHARGE(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITELECTRICCHARGE(100.0, "MAh")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
/// - `C`
/// - `MAh`, `kAh`, `Ah`, `mAh`, `µAh`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITELECTRICCHARGE: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITELECTRICCHARGE"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITELECTRICCHARGE") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITELECTRICCHARGE.symbolFunction,
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
            let unit: Optional<UnitElectricCharge> = FunctionUNITELECTRICCHARGE.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitElectricCharge> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITELECTRICCHARGE.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITELECTRICCHARGE.symbolFunction
    }

    /// Convers a symbol into an `UnitElectricCharge`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitElectricCharge` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitElectricCharge> {
        if sym == "C" {
            return Optional.some(UnitElectricCharge.coulombs)
        } else if sym == "MAh" {
            return Optional.some(UnitElectricCharge.megaampereHours)
        } else if sym == "kAh" {
            return Optional.some(UnitElectricCharge.kiloampereHours)
        } else if sym == "Ah" {
            return Optional.some(UnitElectricCharge.ampereHours)
        } else if sym == "mAh" {
            return Optional.some(UnitElectricCharge.milliampereHours)
        } else if sym == "µAh" {
            return Optional.some(UnitElectricCharge.microampereHours)
        }
        return Optional.none
    }

}
