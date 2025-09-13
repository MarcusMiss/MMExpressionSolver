//
//  FunctionUNITANGLE.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITANGLE()
///
/// Implementation of expression-function `UNITANGLE()`.
///
/// The UNITANGLE() function returns a `Measurement` of type `UnitAngle`.
///
/// ```
/// UNITANGLE(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITANGLE(100.0, "°")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `°`
/// - `ʹ`
/// - `ʺ`
/// - `rad`, `grad`, `rev`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITANGLE: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITANGLE"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITANGLE") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITANGLE.symbolFunction,
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
            let unit: Optional<UnitAngle> = FunctionUNITANGLE.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitAngle> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITANGLE.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITANGLE.symbolFunction
    }

    /// Convers a symbol into an `UnitAngle`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitAngle` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitAngle> {
        if sym == "°" {
            return Optional.some(UnitAngle.degrees)
        } else if sym == "ʹ" {
            return Optional.some(UnitAngle.arcMinutes)
        } else if sym == "ʺ" {
            return Optional.some(UnitAngle.arcSeconds)
        } else if sym == "rad" {
            return Optional.some(UnitAngle.radians)
        } else if sym == "grad" {
            return Optional.some(UnitAngle.gradians)
        } else if sym == "rev" {
            return Optional.some(UnitAngle.revolutions)
        }
        return Optional.none
    }

}
