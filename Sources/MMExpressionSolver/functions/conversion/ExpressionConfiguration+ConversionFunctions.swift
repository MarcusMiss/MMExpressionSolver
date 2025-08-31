//
//  ExpressionConfiguration+ConversionFunctions.swift
//  MMExpressionSolver
//

import Foundation

public extension ExpressionConfiguration {
    
    /// Register conversions functions.
    /// - Returns: functions
    static func setupConversionFunctions() -> [any ExpressionFunction] {
        return [
            FunctionCINT(),
            FunctionCDBL(),
            FunctionCDEC(),
            FunctionCFLT(),
            FunctionCSTR(),
        ]
    }

}
