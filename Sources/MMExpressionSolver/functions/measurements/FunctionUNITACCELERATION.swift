//
//  FunctionUNITACCELERATION.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITACCELERATION()
///
/// Implementation of expression-function `UNITACCELERATION()`.
///
/// The UNITACCELERATION() function returns a `Measurement` of type `UnitAcceleration`.
///
/// ```
/// UNITACCELERATION(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITACCELERATION(100.0, "m/s²")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `m/s²`
/// - `g`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITACCELERATION: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITACCELERATION"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITACCELERATION") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITACCELERATION.symbolFunction,
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
            let unit: Optional<UnitAcceleration> = FunctionUNITACCELERATION.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitAcceleration> = Measurement(value: value, unit: unit!)
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

    /// Convers a symbol into an `UnitAcceleration`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitAcceleration` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitAcceleration> {
        if sym == "m/s²" {
            return Optional.some(UnitAcceleration.metersPerSecondSquared)
        } else if sym == "g" {
            return Optional.some(UnitAcceleration.gravity)
        }
        return Optional.none
    }

}
