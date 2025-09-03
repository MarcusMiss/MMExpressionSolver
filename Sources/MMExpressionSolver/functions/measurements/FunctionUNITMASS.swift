//
//  FunctionUNITMASS.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITMASS()
///
/// Implementation of expression-function `UNITMASS()`.
///
/// The UNITMASS() function returns a `Measurement` of type `UnitMass`.
///
/// ```
/// UNITMASS(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITMASS(100.0, "kg")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `kg`, `g`, `dg`, `cg`, `mg`, `µg`, `ng`, `pg`
/// - `oz`, `lb`, `st`
/// - `t`, `ton`, `xx`
/// - `ct`, `oz t`, `slug`
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>.
public final class FunctionUNITMASS: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITMASS"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITMASS") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITMASS.symbolFunction,
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
            let unit: Optional<UnitMass> = FunctionUNITMASS.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitMass> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITMASS.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITMASS.symbolFunction
    }

    /// Convers a symbol into an `UnitMass`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitMass` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitMass> {
        if sym == "kg" {
            return Optional.some(UnitMass.kilograms)
        } else if sym == "g" {
            return Optional.some(UnitMass.grams)
        } else if sym == "dg" {
            return Optional.some(UnitMass.decigrams)
        } else if sym == "cg" {
            return Optional.some(UnitMass.centigrams)
        } else if sym == "mg" {
            return Optional.some(UnitMass.milligrams)
        } else if sym == "µg" {
            return Optional.some(UnitMass.micrograms)
        } else if sym == "ng" {
            return Optional.some(UnitMass.nanograms)
        } else if sym == "pg" {
            return Optional.some(UnitMass.picograms)
        } else if sym == "oz" {
            return Optional.some(UnitMass.ounces)
        } else if sym == "lb" {
            return Optional.some(UnitMass.pounds)
        } else if sym == "st" {
            return Optional.some(UnitMass.stones)
        } else if sym == "t" {
            return Optional.some(UnitMass.metricTons)
        } else if sym == "ton" {
            return Optional.some(UnitMass.shortTons)
        } else if sym == "ct" {
            return Optional.some(UnitMass.carats)
        } else if sym == "oz t" {
            return Optional.some(UnitMass.ouncesTroy)
        } else if sym == "slug" {
            return Optional.some(UnitMass.slugs)
        }
        return Optional.none
    }

}
