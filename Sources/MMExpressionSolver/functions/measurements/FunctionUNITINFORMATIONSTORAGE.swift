//
//  FunctionUNITINFORMATIONSTORAGE.swift
//  MMExpressionSolver
//

import Foundation

/// Function UNITINFORMATIONSTORAGE()
///
/// Implementation of expression-function `UNITINFORMATIONSTORAGE()`.
///
/// The UNITINFORMATIONSTORAGE() function returns a `Measurement` of type `UnitInformationStorage`.
///
/// ```
/// UNITINFORMATIONSTORAGE(value: numeric, unit: string) -> measurement
/// ```
///
/// ### Sample
///
/// ```
/// UNITINFORMATIONSTORAGE(100.0, "bytes")
/// ```
///
/// ### Unit Smbols
///
/// Symbols of unit are case-sensitive:
///
/// - `bits`, `nibbles`, `bytes`
/// - `kilobits`, `megabits`, `gigabits`, `terabits`, `petabits`, `exabits`, `zettabits`, `yottabits`
/// - `kibibits`, `mebibits`, `gibibits`, `tebibits`, `pebibits`, `exbibits`, `zebibits`, `yobibits`
/// - `kilobytes`, `megabytes`, `gigabytes`, `terabytes`, `petabytes`, `exabytes`, `zettabytes`, `yottabytes`
/// - `kibibytes`, `mebibytes`, `gibibytes`, `tebibytes`, `pebibytes`, `exbibytes`, `zebibytes`, `yobibytes`
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>. }
public final class FunctionUNITINFORMATIONSTORAGE: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITINFORMATIONSTORAGE"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITINFORMATIONSTORAGE") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITINFORMATIONSTORAGE.symbolFunction,
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
            let unit: Optional<UnitInformationStorage> = FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol(p2.asString()!)
            if unit.isPresent == false {
                throw ExpressionError.invalidParameterValue(token: functionToken,
                                                            funcName: functionToken.value,
                                                            paramName: ExpressionFunctionParameter.nameUnit,
                                                            value: p2.asStringForError())
            }
            let m: Measurement<UnitInformationStorage> = Measurement(value: value, unit: unit!)
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
        return FunctionUNITINFORMATIONSTORAGE.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITINFORMATIONSTORAGE.symbolFunction
    }

    /// Convers a symbol into an `UnitInformationStorage`.
    /// - Parameter sym: sym symbol to solve
    /// - Returns: `UnitInformationStorage` if known
    public static func solveUnitSymbol(_ sym: String) -> Optional<UnitInformationStorage> {
        if sym == "bits" {
            return Optional.some(UnitInformationStorage.bits)
        } else if sym == "nibbles" {
            return Optional.some(UnitInformationStorage.nibbles)
        } else if sym == "bytes" {
            return Optional.some(UnitInformationStorage.bytes)
        } else if sym == "kilobits" {
            return Optional.some(UnitInformationStorage.kilobits)
        } else if sym == "megabits" {
            return Optional.some(UnitInformationStorage.megabits)
        } else if sym == "gigabits" {
            return Optional.some(UnitInformationStorage.gigabits)
        } else if sym == "terabits" {
            return Optional.some(UnitInformationStorage.terabits)
        } else if sym == "petabits" {
            return Optional.some(UnitInformationStorage.petabits)
        } else if sym == "exabits" {
            return Optional.some(UnitInformationStorage.exabits)
        } else if sym == "zettabits" {
            return Optional.some(UnitInformationStorage.zettabits)
        } else if sym == "yottabits" {
            return Optional.some(UnitInformationStorage.yottabits)
        } else if sym == "kibibits" {
            return Optional.some(UnitInformationStorage.kibibits)
        } else if sym == "mebibits" {
            return Optional.some(UnitInformationStorage.mebibits)
        } else if sym == "gibibits" {
            return Optional.some(UnitInformationStorage.gibibits)
        } else if sym == "tebibits" {
            return Optional.some(UnitInformationStorage.tebibits)
        } else if sym == "pebibits" {
            return Optional.some(UnitInformationStorage.pebibits)
        } else if sym == "exbibits" {
            return Optional.some(UnitInformationStorage.exbibits)
        } else if sym == "zebibits" {
            return Optional.some(UnitInformationStorage.zebibits)
        } else if sym == "yobibits" {
            return Optional.some(UnitInformationStorage.yobibits)
        } else if sym == "kilobytes" {
            return Optional.some(UnitInformationStorage.kilobytes)
        } else if sym == "megabytes" {
            return Optional.some(UnitInformationStorage.megabytes)
        } else if sym == "gigabytes" {
            return Optional.some(UnitInformationStorage.gigabytes)
        } else if sym == "terabytes" {
            return Optional.some(UnitInformationStorage.terabytes)
        } else if sym == "petabytes" {
            return Optional.some(UnitInformationStorage.petabytes)
        } else if sym == "exabytes" {
            return Optional.some(UnitInformationStorage.exabytes)
        } else if sym == "zettabytes" {
            return Optional.some(UnitInformationStorage.zettabytes)
        } else if sym == "yottabytes" {
            return Optional.some(UnitInformationStorage.yottabytes)
        } else if sym == "kibibytes" {
            return Optional.some(UnitInformationStorage.kibibytes)
        } else if sym == "mebibytes" {
            return Optional.some(UnitInformationStorage.mebibytes)
        } else if sym == "gibibytes" {
            return Optional.some(UnitInformationStorage.gibibytes)
        } else if sym == "tebibytes" {
            return Optional.some(UnitInformationStorage.tebibytes)
        } else if sym == "pebibytes" {
            return Optional.some(UnitInformationStorage.pebibytes)
        } else if sym == "exbibytes" {
            return Optional.some(UnitInformationStorage.exbibytes)
        } else if sym == "zebibytes" {
            return Optional.some(UnitInformationStorage.zebibytes)
        } else if sym == "yobibytes" {
            return Optional.some(UnitInformationStorage.yobibytes)
        }
        return Optional.none
    }

}


