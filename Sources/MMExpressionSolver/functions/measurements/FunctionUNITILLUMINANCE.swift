//
//  FunctionUNITILLUMINANCE.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITILLUMINANCE()
///
/// Implementation of expression-function `UNITILLUMINANCE()`.
///
/// The UNITILLUMINANCE() function returns a `Measurement` of type `UnitIlluminance`.
///
/// ```
/// UNITILLUMINANCE(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITILLUMINANCE(100.0, "lx")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `lx`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITILLUMINANCE: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITILLUMINANCE"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITILLUMINANCE") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITILLUMINANCE.symbolFunction,
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
            let unit: Optional<UnitIlluminance> = FunctionUNITILLUMINANCE.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitIlluminance> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITILLUMINANCE.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITILLUMINANCE.symbolFunction
    }

    /// Convers a symbol into an `UnitIlluminance`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitIlluminance` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitIlluminance> {
        if sym == "lx" {
            return Optional.some(UnitIlluminance.lux)
        }
        return Optional.none
    }

}
