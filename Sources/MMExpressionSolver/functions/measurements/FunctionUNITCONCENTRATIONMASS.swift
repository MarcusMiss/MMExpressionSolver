//
//  FunctionUNITCONCENTRATIONMASS.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITCONCENTRATIONMASS()
///
/// Implementation of expression-function `UNITCONCENTRATIONMASS()`.
///
/// The UNITCONCENTRATIONMASS() function returns a `Measurement` of type `UnitConcentrationMass`.
///
/// ```
/// UNITCONCENTRATIONMASS(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITCONCENTRATIONMASS(100.0, "mg/dL")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `g/L`
/// - `mg/dL`
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>.
public final class FunctionUNITCONCENTRATIONMASS: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITCONCENTRATIONMASS"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITCONCENTRATIONMASS") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITCONCENTRATIONMASS.symbolFunction,
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
            let unit: Optional<UnitConcentrationMass> = FunctionUNITCONCENTRATIONMASS.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitConcentrationMass> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITCONCENTRATIONMASS.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITCONCENTRATIONMASS.symbolFunction
    }

    /// Convers a symbol into an `UnitConcentrationMass`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitConcentrationMass` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitConcentrationMass> {
        if sym == "g/L" {
            return Optional.some(UnitConcentrationMass.gramsPerLiter)
        } else if sym == "mg/dL" {
            return Optional.some(UnitConcentrationMass.milligramsPerDeciliter)
        }
        return Optional.none
    }

}
