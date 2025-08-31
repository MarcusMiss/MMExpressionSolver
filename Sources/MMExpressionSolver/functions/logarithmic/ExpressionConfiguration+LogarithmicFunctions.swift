//
//  ExpressionConfiguration+LogarithmicFunctions.swift
//  MMExpressionSolver
//

public extension ExpressionConfiguration {

    /// Register logarithmic functions.
    /// - Returns: functions
    static func setupLogarithmicFunctions() -> [any ExpressionFunction] {
        return [
            FunctionLOG(),
            FunctionLOG10(),
            FunctionLOG1P(),
            FunctionLOGN(),
        ]
    }

}
