//
//  FunctionUNITCONVERT.swift
//  MMExpressionSolver
//


import Foundation

/// Function UNITCONVERT()
///
/// Implementation of expression-function `UNITCONVERT()`.
///
/// The UNITCONVERT() function returns a `Measurement` with new unit.
///
/// ```
/// UNITCONVERT(value: measurement, unit: string) -> measurement
/// ```
/// ### Sample
///
/// ```
/// UNITCONVERT( UNITANGLE(100.0, 'rad'), '°')
/// UNITCONVERT( UNITENERGY(100.0, 'kCal'), 'kWh')
/// UNITCONVERT( UNITACCELERATION(100.0, 'm/s²'), 'm/s²')
/// UNITCONVERT( UNITAREA(100.0, 'km²'), 'm²')
/// UNITCONVERT( UNITCONCENTRATIONMASS(100.0, 'g/L'), 'mg/dL')
/// UNITCONVERT( UNITDISPERSION(100.0, 'ppm'), 'ppm')
/// UNITCONVERT( UNITDURATION(100.0, 'sec'), 'min')
/// UNITCONVERT( UNITELECTRICCHARGE(100.0, 'MAh'), 'kAh')
/// UNITCONVERT( UNITELECTRICCURRENT(100.0, 'A'), 'kA')
/// UNITCONVERT( UNITELECTRICPOTENTIALDIFFERENCE(100.0, 'V'), 'kV')
/// UNITCONVERT( UNITELECTRICRESISTENCE(100.0, 'kΩ'), 'Ω')
/// UNITCONVERT( UNITFREQUENCY(100.0, 'kHz'), 'Hz')
/// UNITCONVERT( UNITFUELEFFICIENCY(100.0, 'mpg'), 'L/100km')
/// UNITCONVERT( UNITILLUMINANCE(100.0, 'lx'), 'lx')
/// UNITCONVERT( UNITINFORMATIONSTORAGE(100.0, 'bytes'), 'bits')
/// UNITCONVERT( UNITLENGTH(100.0, 'cm'), 'mm')
/// UNITCONVERT( UNITMASS(100.0, 'kg'), 'g')
/// UNITCONVERT( UNITPOWER(100.0, 'W'), 'mW')
/// UNITCONVERT( UNITPRESSURE(100.0, 'kPa'), 'bar')
/// UNITCONVERT( UNITSPEED(100.0, 'm/s'), 'km/h')
/// UNITCONVERT( UNITTEMPERATURE(100.0, '°C'), '°F')
/// UNITCONVERT( UNITVOLUME(100.0, 'm³'), 'cm³')
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.1.0>.
public final class FunctionUNITCONVERT: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "UNITCONVERT"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionUNITCONVERT") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionUNITCONVERT.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [
                                            .measurement(unit: .unitAcceleration),
                                            .measurement(unit: .unitAngle),
                                            .measurement(unit: .unitArea),
                                            .measurement(unit: .unitConcentrationMass),
                                            .measurement(unit: .unitDispersion),
                                            .measurement(unit: .unitDuration),
                                            .measurement(unit: .unitElectricCharge),
                                            .measurement(unit: .unitElectricCurrent),
                                            .measurement(unit: .unitElectricPotentialDifference),
                                            .measurement(unit: .unitElectricalResistance),
                                            .measurement(unit: .unitEnergy),
                                            .measurement(unit: .unitFrequency),
                                            .measurement(unit: .unitFuelEfficiency),
                                            .measurement(unit: .unitIlluminance),
                                            .measurement(unit: .unitInformationStorage),
                                            .measurement(unit: .unitLength),
                                            .measurement(unit: .unitMass),
                                            .measurement(unit: .unitPower),
                                            .measurement(unit: .unitPressure),
                                            .measurement(unit: .unitSpeed),
                                            .measurement(unit: .unitTemperature),
                                            .measurement(unit: .unitVolume),
                                        ]),
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
        if p2.isStringValue {
            switch p1.type {
            case let .measurement(unit):
                switch unit {
                case .unitAcceleration:
                    let unit : Optional<UnitAcceleration> = FunctionUNITACCELERATION.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitAcceleration()!.converted(to: unit!))
                case .unitAngle:
                    let unit : Optional<UnitAngle> = FunctionUNITANGLE.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitAngle()!.converted(to: unit!))
                case .unitArea:
                    let unit : Optional<UnitArea> = FunctionUNITAREA.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitArea()!.converted(to: unit!))
                case .unitConcentrationMass:
                    let unit : Optional<UnitConcentrationMass> = FunctionUNITCONCENTRATIONMASS.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitConcentrationMass()!.converted(to: unit!))
                case .unitDispersion:
                    let unit : Optional<UnitDispersion> = FunctionUNITDISPERSION.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitDispersion()!.converted(to: unit!))
                case .unitDuration:
                    let unit : Optional<UnitDuration> = FunctionUNITDURATION.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitDuration()!.converted(to: unit!))
                case .unitElectricCharge:
                    let unit : Optional<UnitElectricCharge> = FunctionUNITELECTRICCHARGE.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitElectricCharge()!.converted(to: unit!))
                case .unitElectricCurrent:
                    let unit : Optional<UnitElectricCurrent> = FunctionUNITELECTRICCURRENT.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitElectricCurrent()!.converted(to: unit!))
                case .unitElectricPotentialDifference:
                    let unit : Optional<UnitElectricPotentialDifference> = FunctionUNITELECTRICPOTENTIALDIFFERENCE.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitElectricPotentialDifference()!.converted(to: unit!))
                case .unitElectricalResistance:
                    let unit : Optional<UnitElectricResistance> = FunctionUNITELECTRICRESISTENCE.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitElectricResistence()!.converted(to: unit!))
                case .unitEnergy:
                    let unit : Optional<UnitEnergy> = FunctionUNITENERGY.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitEnergy()!.converted(to: unit!))
                case .unitFrequency:
                    let unit : Optional<UnitFrequency> = FunctionUNITFREQUENCY.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitFrequency()!.converted(to: unit!))
                case .unitIlluminance:
                    let unit : Optional<UnitIlluminance> = FunctionUNITILLUMINANCE.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitIlluminance()!.converted(to: unit!))
                case .unitInformationStorage:
                    let unit : Optional<UnitInformationStorage> = FunctionUNITINFORMATIONSTORAGE.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitInformationStorage()!.converted(to: unit!))
                case .unitLength:
                    let unit : Optional<UnitLength> = FunctionUNITLENGTH.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitLength()!.converted(to: unit!))
                case .unitMass:
                    let unit : Optional<UnitMass> = FunctionUNITMASS.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitMass()!.converted(to: unit!))
                case .unitPower:
                    let unit : Optional<UnitPower> = FunctionUNITPOWER.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitPower()!.converted(to: unit!))
                case .unitPressure:
                    let unit : Optional<UnitPressure> = FunctionUNITPRESSURE.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitPressure()!.converted(to: unit!))
                case .unitSpeed:
                    let unit : Optional<UnitSpeed> = FunctionUNITSPEED.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitSpeed()!.converted(to: unit!))
                case .unitTemperature:
                    let unit : Optional<UnitTemperature> = FunctionUNITTEMPERATURE.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitTemperature()!.converted(to: unit!))
                case .unitVolume:
                    let unit : Optional<UnitVolume> = FunctionUNITVOLUME.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitVolume()!.converted(to: unit!))
                case .unitFuelEfficiency:
                    let unit : Optional<UnitFuelEfficiency> = FunctionUNITFUELEFFICIENCY.solveUnitSymbol(p2.asString()!)
                    if unit.isPresent == false {
                        throw ExpressionError.invalidParameterValue(token: functionToken,
                                                                    funcName: functionToken.value,
                                                                    paramName: ExpressionFunctionParameter.nameUnit,
                                                                    value: p2.asStringForError())
                    }
                    return ExpressionValue.of(p1.asUnitFuelEfficiency()!.converted(to: unit!))
                }
            default:
                throw ExpressionError.invalidParameterType(token: functionToken,
                                                           funcName: functionToken.value,
                                                           paramName: ExpressionFunctionParameter.nameValue,
                                                           value: p1.asStringForError())
            }
        }
        if !p1.isMeasurement {
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
        return FunctionUNITCONVERT.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionUNITCONVERT.symbolFunction
    }

}
