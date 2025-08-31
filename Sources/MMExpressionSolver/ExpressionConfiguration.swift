//
//  ExpressionConfiguration.swift
//  MMExpressionSolver
//

import Foundation

/// Configuration for an expression-solver.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public struct ExpressionConfiguration {

    // MARK: - Factories
    
    /// Gather all functions.
    /// - Returns: all known functions
    public static func setupAllFunctions() -> [any ExpressionFunction] {
        return ExpressionConfiguration.setupStringFunctions()
                + ExpressionConfiguration.setupMathFunctions()
                + ExpressionConfiguration.setupTrigonometryFunctions()
                + ExpressionConfiguration.setupLogarithmicFunctions()
                + ExpressionConfiguration.setupDateFunctions()
                + ExpressionConfiguration.setupMiscFunctions()
                + ExpressionConfiguration.setupConversionFunctions()
    }
    
    /// Gather all operators.
    /// - Returns: all known operators
    public static func setupAllOperators() -> [any ExpressionOperator] {
        return ExpressionConfiguration.setupArithmeticOperators()
                + ExpressionConfiguration.setupBooleanOperators()
    }

    /// Creates default configurations for ``MMExpressionSolver``.
    /// - Returns: default configuration
    public static func createDefault() -> ExpressionConfiguration {
        return ExpressionConfiguration(
            arraysAllowed: true,
            structuresAllowed: true,
            singleQuoteAllowed: true,
            implicitMultiplyAllowed: true,
            functions: ExpressionFunctionRepositoryImpl(
                setupAllFunctions()
            ),
            operators: ExpressionOperatorRepositoryImpl(
                setupAllOperators()
            )
        )
    }

    // MARK: - Properties
    
    /// Indicator arrays allowed
    public let arraysAllowed: Bool
    
    /// Indicator structures allowed
    public let structuresAllowed: Bool
    
    /// Indicator single quotes allowed
    public let singleQuoteAllowed: Bool
    
    /// Indicator implicit multiplication allowed
    public let implicitMultiplyAllowed: Bool
    
    /// Repository of functions
    public let functions: ExpressionFunctionRepository
    
    /// Repository of operators
    public let operators: ExpressionOperatorRepository

    // MARK: - Initialization
    
    /// Initialiation of object.
    /// - Parameters:
    ///   - arraysAllowed: flag to allow arrays
    ///   - structuresAllowed: flag to allow structures
    ///   - singleQuoteAllowed: flag to allow single quotes
    ///   - implicitMultiplyAllowed: flag to allow implicit multiply
    ///   - functions: repository of functions
    ///   - operators: repository of operators
    public init(
        arraysAllowed: Bool,
        structuresAllowed: Bool,
        singleQuoteAllowed: Bool,
        implicitMultiplyAllowed: Bool,
        functions: ExpressionFunctionRepository,
        operators: ExpressionOperatorRepository
    ) {
        self.arraysAllowed = arraysAllowed
        self.structuresAllowed = structuresAllowed
        self.singleQuoteAllowed = singleQuoteAllowed
        self.implicitMultiplyAllowed = implicitMultiplyAllowed
        self.functions = functions
        self.operators = operators
    }

}
