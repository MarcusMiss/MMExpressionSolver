//
//  ExpressionConfiguration+DateFunctions.swift
//  MMExpressionSolver
//

import Foundation

public extension ExpressionConfiguration {

    /// Register date functions.
    /// - Returns: functions
    static func setupDateFunctions() -> [any ExpressionFunction] {
        return [
            FunctionNOW(),
            FunctionDATE(),
            FunctionADDYEAR(),
            FunctionADDMONTH(),
            FunctionADDDAY(),
            FunctionADDHOUR(),
            FunctionADDMINUTE(),
            FunctionADDSECOND(),
            FunctionGETYEAR(),
            FunctionGETMONTH(),
            FunctionGETDAY(),
            FunctionGETHOUR(),
            FunctionGETMINUTE(),
            FunctionGETSECOND(),
        ]
    }

}
