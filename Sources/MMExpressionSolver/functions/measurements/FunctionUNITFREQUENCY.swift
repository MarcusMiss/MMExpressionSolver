//
//  FunctionUNITFREQUENCY.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITFREQUENCY()
///
/// Implementation of expression-function `UNITFREQUENCY()`.
///
/// The UNITFREQUENCY() function returns a `Measurement` of type `UnitFrequency`.
///
/// ```
/// UNITFREQUENCY(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITFREQUENCY(100.0, "Hz")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `THz`, `GHz`, `MHz`, `kHz`, `Hz`, `mHz`, `µHz`, `nHz`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITFREQUENCY: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITFREQUENCY"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITFREQUENCY") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITFREQUENCY.symbolFunction,
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
            let unit: Optional<UnitFrequency> = FunctionUNITFREQUENCY.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitFrequency> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITFREQUENCY.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITFREQUENCY.symbolFunction
    }

    /// Convers a symbol into an `UnitFrequency`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitFrequency` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitFrequency> {
        if sym == "THz" {
            return Optional.some(UnitFrequency.terahertz)
        } else if sym == "GHz" {
            return Optional.some(UnitFrequency.gigahertz)
        } else if sym == "MHz" {
            return Optional.some(UnitFrequency.megahertz)
        } else if sym == "kHz" {
            return Optional.some(UnitFrequency.kilohertz)
        } else if sym == "Hz" {
            return Optional.some(UnitFrequency.hertz)
        } else if sym == "mHz" {
            return Optional.some(UnitFrequency.millihertz)
        } else if sym == "µHz" {
            return Optional.some(UnitFrequency.microhertz)
        } else if sym == "nHz" {
            return Optional.some(UnitFrequency.nanohertz)
        }
        return Optional.none
    }

}
