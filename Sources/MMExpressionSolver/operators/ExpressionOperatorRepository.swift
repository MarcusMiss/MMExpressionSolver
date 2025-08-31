//
//  ExpressionOperatorRepository.swift
//  MMExpressionSolver
//

import Foundation

/// Required APIs for an operqtor-repository.
///
/// A operator-repository is used to register and manage operators for ``MMExpression``.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public protocol ExpressionOperatorRepository {

    /// Check if prefix-operator is registered in repository.
    /// - Parameter symbol: symbol of operator
    /// - Returns: `true` if function is known
    func hasPrefixOperator(_ symbol: String) -> Bool

    /// Check if infix-operator is registered in repository.
    /// - Parameter symbol: symbol of operator
    /// - Returns: `true` if function is known
    func hasInfixOperator(_ symbol: String) -> Bool

    /// Check if postfix-operator is registered in repository.
    /// - Parameter symbol: symbol of operator
    /// - Returns: `true` if function is known
    func hasPostfixOperator(_ symbol: String) -> Bool

    /// Find prefix-operator-identifier by operator-symbol.
    /// - Parameter symbol: symbol of operator to lookup
    /// - Returns: Identifier of operator
    func findPrefixOperatorId(_ symbol: String) -> Optional<OperatorIdentifier>

    /// Find infix-operator-identifier by operator-symbol.
    /// - Parameter symbol: symbol of operator to lookup
    /// - Returns: Identifier of operator
    func findInfixOperatorId(_ symbol: String) -> Optional<OperatorIdentifier>

    /// Find postfix-operator-identifier by operator-symbol.
    /// - Parameter symbol: symbol of operator to lookup
    /// - Returns: Identifier of operator
    func findPostfixOperatorId(_ symbol: String) -> Optional<OperatorIdentifier>

    /// Find operator by operator-identifier.
    /// - Parameter identifier: identifier of operator to lookup
    /// - Returns: `ExpressionOperator` of operator
    func findOperator(_ identifier: Optional<OperatorIdentifier>) -> Optional<any ExpressionOperator>

}
