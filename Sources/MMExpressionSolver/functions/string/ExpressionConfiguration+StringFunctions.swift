//
//  ExpressionConfiguration+StringFunctions.swift
//  MMExpressionSolver
//

public extension ExpressionConfiguration {

    /// Register string-related functions.
    /// - Returns: functions
    static func setupStringFunctions() -> [any ExpressionFunction] {
        return [
            FunctionLEFT(),
            FunctionLEN(),
            FunctionLOWER(),
            FunctionMID(),
            FunctionLTRIM(),
            FunctionREPLACEALL(),
            FunctionREPLACEFIRST(),
            FunctionRTRIM(),
            FunctionTRIM(),
            FunctionRIGHT(),
            FunctionUPPER(),
            FunctionUUID(),
        ]
    }

}
