//
//  FunctionUNITSPEED.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITSPEED()
///
/// Implementation of expression-function `UNITSPEED()`.
///
/// The UNITSPEED() function returns a `Measurement` of type `UnitSpeed`.
///
/// ```
/// UNITSPEED(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITSPEED(100.0, "m/s")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `m/s`, `km/h`
/// - `mph`
/// - `kn`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITSPEED: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITSPEED"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITSPEED") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITSPEED.symbolFunction,
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
            let unit: Optional<UnitSpeed> = FunctionUNITSPEED.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitSpeed> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITSPEED.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITSPEED.symbolFunction
    }

    /// Convers a symbol into an `UnitSpeed`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitSpeed` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitSpeed> {
        if sym == "m/s" {
            return Optional.some(UnitSpeed.metersPerSecond)
        } else if sym == "km/h" {
            return Optional.some(UnitSpeed.kilometersPerHour)
        } else if sym == "mph" {
            return Optional.some(UnitSpeed.milesPerHour)
        } else if sym == "kn" {
            return Optional.some(UnitSpeed.knots)
        }
        return Optional.none
    }

}
