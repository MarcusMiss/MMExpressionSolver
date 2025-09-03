//
//  FunctionUNITENERGY.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITENERGY()
///
/// Implementation of expression-function `UNITENERGY()`.
///
/// The UNITENERGY() function returns a `Measurement` of type `UnitEnergy`.
///
/// ```
/// UNITENERGY(value: numeric, unit: string) -> measurement
/// ```
/// ### Sample
///
/// ```
/// UNITENERGY(100.0, "kWh")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `kJ`, `J`, `kCal`, `cal`, `kWh`
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>.
public final class FunctionUNITENERGY: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITENERGY"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITENERGY") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITENERGY.symbolFunction,
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
            let unit: Optional<UnitEnergy> = FunctionUNITENERGY.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitEnergy> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITENERGY.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITENERGY.symbolFunction
    }

    /// Convers a symbol into an `UnitEnergy`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitEnergy` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitEnergy> {
        if sym == "kJ" {
            return Optional.some(UnitEnergy.kilojoules)
        } else if sym == "J" {
            return Optional.some(UnitEnergy.joules)
        } else if sym == "kCal" {
            return Optional.some(UnitEnergy.kilocalories)
        } else if sym == "cal" {
            return Optional.some(UnitEnergy.calories)
        } else if sym == "kWh" {
            return Optional.some(UnitEnergy.kilowattHours)
        }
        return Optional.none
    }

}
