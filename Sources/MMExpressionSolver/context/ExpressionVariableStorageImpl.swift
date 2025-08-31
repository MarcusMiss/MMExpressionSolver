//
//  ExpressionVariableStorageImpl.swift
//  MMExpressionSolver
//

import Foundation

/// Default implementation of ```ExpressionVariableStorage```.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public class ExpressionVariableStorageImpl: ExpressionVariableStorage {

    // MARK: - Properties

    public var count: Int { get { return variables.count } }

    private var variables: [String: ExpressionValue] = [:]

    // MARK: - Initialization

    /// Initialization of this object.
    public init() {
    }

    // MARK: - Protocol ExpressionVariableStorage

    @discardableResult
    public func storeVariable(identifier: String, value: ExpressionValue)  -> any ExpressionVariableStorage {
        self.variables[identifier] = value
        return self
    }
    
    public func getVariable(identifier: String) -> Optional<ExpressionValue> {
        if let value = self.variables[identifier] {
            return Optional.some(value)
        }
        return Optional.none
    }

    public func getVariableNames() -> [String] {
        return self.variables.keys.sorted()
    }

}
