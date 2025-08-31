//
//  ExpressionOperatorTypeStorage.swift
//  MMExpressionSolver
//

import Foundation

/// Storage-container for operators.
///
/// This storage-container stores operators of a specific type: _prefix_, _infix_ or _postfix_.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public class ExpressionOperatorTypeStorage {
    
    // MARK: - Properties

    private var operatorsBySymbol: [String: any ExpressionOperator] = [:]
    private var operatorsById: [OperatorIdentifier: any ExpressionOperator] = [:]
    public var countBySymbol: Int { get { self.operatorsById.count }}
    public var countById: Int { get { self.operatorsById.count }}

    public let type: OperatorType

    // MARK: - Initialization

    public init(_ type: OperatorType) {
        self.type = type
    }

    // MARK: - API

    public func register(_ op: any ExpressionOperator) {
        for symbol in op.symbols {
            self.operatorsBySymbol[symbol.uppercased()] = op
        }
        self.operatorsById[op.id] = op
    }

    public func findOperatorBySymbol(_ symbol: String) -> Optional<any ExpressionOperator> {
        if let op = self.operatorsBySymbol[symbol.uppercased()] {
            return Optional.some(op)
        }
        return Optional.none
    }

    public func findOperatorById(_ ident: OperatorIdentifier) -> Optional<any ExpressionOperator> {
        if let op = self.operatorsById[ident] {
            return Optional.some(op)
        }
        return Optional.none
    }

}
