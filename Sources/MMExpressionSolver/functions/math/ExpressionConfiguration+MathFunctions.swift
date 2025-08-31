//
//  ExpressionConfiguration+MathFunctions.swift
//  MMExpressionSolver
//

import Foundation

public extension ExpressionConfiguration {
    
    /// Register nathematical functions.
    /// - Returns: functions
    static func setupMathFunctions() -> [any ExpressionFunction] {
        return [
            FunctionABS(),
            FunctionAVG(),
            FunctionCBRT(),
            FunctionCEIL(),
            FunctionFLOOR(),
            FunctionMAX(),
            FunctionMIN(),
            FunctionPOWER(),
            FunctionROUND(),
            FunctionSIGN(),
            FunctionSUM(),
            FunctionSQRT(),
        ]
    }

}
