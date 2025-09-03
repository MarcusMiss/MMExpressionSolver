//
//  ExpressionConfiguration+MeasurementFunctions.swift
//  MMExpressionSolver
//

import Foundation

public extension ExpressionConfiguration {

    /// Register measurement functions.
    /// - Returns: functions
    static func setupMeasurementFunctions() -> [any ExpressionFunction] {
        return [
            FunctionUNITCONVERT(),
            // Physical dimension
            FunctionUNITAREA(),
            FunctionUNITLENGTH(),
            FunctionUNITVOLUME(),
            FunctionUNITANGLE(),
            // Mass, Weight, and Force
            FunctionUNITMASS(),
            FunctionUNITPRESSURE(),
            // Time and Motion
            FunctionUNITACCELERATION(),
            FunctionUNITDURATION(),
            FunctionUNITFREQUENCY(),
            FunctionUNITSPEED(),
            // Energy, Heat, and Light
            FunctionUNITENERGY(),
            FunctionUNITPOWER(),
            FunctionUNITTEMPERATURE(),
            FunctionUNITILLUMINANCE(),
            // Electricity
            FunctionUNITELECTRICCHARGE(),
            FunctionUNITELECTRICCURRENT(),
            FunctionUNITELECTRICPOTENTIALDIFFERENCE(),
            FunctionUNITELECTRICRESISTENCE(),
            // Concentration and Dispersion
            FunctionUNITCONCENTRATIONMASS(),
            FunctionUNITDISPERSION(),
            // Fuel Efficiency
            FunctionUNITFUELEFFICIENCY(),
            // Data Storage
            FunctionUNITINFORMATIONSTORAGE(),
        ]
    }

}
