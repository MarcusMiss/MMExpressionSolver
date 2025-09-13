//
//  FunctionUNITELECTRICCURRENT.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITELECTRICCURRENT()
///
/// Implementation of expression-function `UNITELECTRICCURRENT()`.
///
/// The UNITELECTRICCHARGE() function returns a `Measurement` of type `UnitElectricCurrent`.
///
/// ```
/// UNITELECTRICCURRENT(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITELECTRICCURRENT(100.0, "A")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `MA`, `kA`, `A`, `mA`, `µA`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITELECTRICCURRENT: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITELECTRICCURRENT"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITELECTRICCURRENT") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITELECTRICCURRENT.symbolFunction,
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
            let unit: Optional<UnitElectricCurrent> = FunctionUNITELECTRICCURRENT.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitElectricCurrent> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITELECTRICCURRENT.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITELECTRICCURRENT.symbolFunction
    }

    /// Convers a symbol into an `UnitElectricCurrent`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitElectricCurrent` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitElectricCurrent> {
        if sym == "MA" {
            return Optional.some(UnitElectricCurrent.megaamperes)
        } else if sym == "kA" {
            return Optional.some(UnitElectricCurrent.kiloamperes)
        } else if sym == "A" {
            return Optional.some(UnitElectricCurrent.amperes)
        } else if sym == "mA" {
            return Optional.some(UnitElectricCurrent.milliamperes)
        } else if sym == "µA" {
            return Optional.some(UnitElectricCurrent.microamperes)
        }
        return Optional.none
    }

}
