//
//  ExpressionVariableStorage.swift
//  MMExpressionSolver
//

/// Container to handle expression-variables.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public protocol ExpressionVariableStorage {

    // MARK: - Properties
    
    /// Number of stored variables
    var count: Int { get }

    // MARK: - API

    /// Save value of variable in storage.
    /// - Parameters:
    ///   - identifier: name of variable
    ///   - value: value of variable
    /// - Returns: self of storage
    @discardableResult
    func storeVariable(identifier: String, value: ExpressionValue) -> any ExpressionVariableStorage
    
    /// Return value of variable if known in storage.
    /// - Parameter identifier: name of variable
    /// - Returns: Value of variable if known
    func getVariable(identifier: String) -> Optional<ExpressionValue>
    
    /// Return names of variables in storage
    /// - Returns: list of variable-names
    func getVariableNames() -> [String]

}
