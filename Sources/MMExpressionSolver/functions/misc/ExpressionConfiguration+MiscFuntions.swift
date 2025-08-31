//
//  ExpressionConfiguration+MiscFuntions.swift
//  MMExpressionSolver
//

import Foundation

public extension ExpressionConfiguration {

    /// Register miscellaneous functions.
    /// - Returns: functions
    static func setupMiscFunctions() -> [any ExpressionFunction] {
        return [
            FunctionARRAYLEN(),
            FunctionIF(),
            FunctionISNOTNULL(),
            FunctionISNULL(),
        ]
    }

}
