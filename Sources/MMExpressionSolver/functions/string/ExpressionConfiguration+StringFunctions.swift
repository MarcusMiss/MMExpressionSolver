//
//  ExpressionConfiguration+StringFunctions.swift
//  MMExpressionSolver
//

public extension ExpressionConfiguration {

    /// Register string-related functions.
    /// - Returns: functions
    static func setupStringFunctions() -> [any ExpressionFunction] {
        return [
            FunctionHASPOSTFIX(),
            FunctionHASPREFIX(),
            FunctionLEFT(),
            FunctionLEN(),
            FunctionLOWER(),
            FunctionMID(),
            FunctionLTRIM(),
            FunctionREPLACEALL(),
            FunctionREPLACEFIRST(),
            FunctionRTRIM(),
            FunctionTRIM(),
            FunctionTRIMPOSTFIX(),
            FunctionTRIMPREFIX(),
            FunctionRIGHT(),
            FunctionUPPER(),
            FunctionUUID(),
        ]
    }

}
