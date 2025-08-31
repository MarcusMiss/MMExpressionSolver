//
//  ExpressionFunctionRepository.swift
//  MMExpressionSolver
//

import Foundation

/// Required APIs for an function-repository.
///
/// A function-repository is used to register and manage functions for ``MMExpression``.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public protocol ExpressionFunctionRepository {

    // MARK: - Properties
    
    /// Number of registered functions.
    var count: Int { get }

    // MARK: - API

    /// Check if function is registered in repository.
    /// - Parameter name: name of function to lookup
    /// - Returns: `true` if function is known
    func hasFunction(name: String) -> Bool
    
    /// Find function-identifier by function-name.
    /// - Parameter name: name of function to lookup
    /// - Returns: Identifier of function
    func findFunction(name: String) -> Optional<FunctionIdentifier>
    
    /// Find function by its identifier.
    /// - Parameter identifier: function identifier
    /// - Returns: `ExpressionFunction` if found
    func findFunction(identifier: Optional<FunctionIdentifier>) -> Optional<any ExpressionFunction>

}
