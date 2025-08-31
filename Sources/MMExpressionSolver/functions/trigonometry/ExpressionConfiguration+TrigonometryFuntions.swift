//
//  ExpressionConfiguration+TrigonometryFuntions.swift
//  MMExpressionSolver
//

import Foundation

public extension ExpressionConfiguration {

    /// Register trigonometry functions.
    /// - Returns: functions
    static func setupTrigonometryFunctions() -> [any ExpressionFunction] {
        return [
            FunctionACOS(),
            FunctionACOSEC(),
            FunctionACOSECH(),
            FunctionACOSH(),
            FunctionACOTAN(),
            FunctionACOTANH(),
            FunctionASEC(),
            FunctionASECH(),
            FunctionASIN(),
            FunctionASINH(),
            FunctionATAN(),
            FunctionATAN2(),
            FunctionATANH(),
            FunctionCOS(),
            FunctionCOSEC(),
            FunctionCOSECH(),
            FunctionCOSH(),
            FunctionCOTAN(),
            FunctionDEG(),
            FunctionHYPOT(),
            FunctionRAD(),
            FunctionSEC(),
            FunctionSECH(),
            FunctionSIN(),
            FunctionSINH(),
            FunctionTAN(),
            FunctionTANH()
        ]
    }

}
