//
//  ExpressionEvaluationContextImpl.swift
//  MMExpressionSolver
//

import Foundation

/// Default implementation of ```ExpressionEvaluationContext```.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public class ExpressionEvaluationContextImpl: ExpressionEvaluationContext {

    // MARK: - Properties
    
    /// Storage for variables.
    public let variables: any ExpressionVariableStorage
    
    /// Repository of functions.
    public let functions: any ExpressionFunctionRepository
    
    /// Repository of operators.
    public let operators: any ExpressionOperatorRepository

    public let calendar: Calendar

    // MARK: - Initialization

    /// Initialization of object.
    /// - Parameters:
    ///   - variables: storage for variables
    ///   - functions: function repository
    ///   - operators: operator repository
    ///   - calendar: calendar to use
    public init(variables: any ExpressionVariableStorage,
                functions: any ExpressionFunctionRepository,
                operators: any ExpressionOperatorRepository,
                calendar: Calendar = .current
    ) {
        self.variables = variables
        self.functions = functions
        self.operators = operators
        self.calendar = calendar
    }

    /// Initialization of object.
    /// - Parameter configuration: expression-configuration
    public init(configuration: ExpressionConfiguration) {
        self.variables = ExpressionVariableStorageImpl()
        self.functions = configuration.functions
        self.operators = configuration.operators
        self.calendar = Calendar.current
    }

}
