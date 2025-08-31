//
//  ExpressionOperatorRepositoryImpl.swift
//  MMExpressionSolver
//

import Foundation

/// Default implementation.
///
/// The default ``ExpressionOperatorRepository``-implementation.
/// Operators will be registered by its internal identifier and per symbol name in uppercase.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public class ExpressionOperatorRepositoryImpl: ExpressionOperatorRepository {

    // MARK: - Properties

    var prefix: ExpressionOperatorTypeStorage = ExpressionOperatorTypeStorage(.prefix)
    var infix: ExpressionOperatorTypeStorage = ExpressionOperatorTypeStorage(.infix)
    var postfix: ExpressionOperatorTypeStorage = ExpressionOperatorTypeStorage(.postfix)

    // MARK: - Initialization

    /// Initialization of this object.
    /// - Parameter operators: Operators to register
    public init(
        _ operators: [any ExpressionOperator]
    ) {
        for op in operators {
            self.registerOperator(op)
        }
    }

    // MARK: - API

    @discardableResult
    public func registerOperator(_ op: any ExpressionOperator) -> any ExpressionOperatorRepository {
        self.findOperatorListByType(op.definition.type).register(op)
        return self
    }

    public func findOperatorBySymbol(symbol: String) -> Optional<OperatorIdentifier> {
        var op: Optional<any ExpressionOperator> = infix.findOperatorBySymbol(symbol)
        if op.isPresent {
            return Optional.some(op!.id)
        }
        op = prefix.findOperatorBySymbol(symbol)
        if op.isPresent {
            return Optional.some(op!.id)
        }
        op = postfix.findOperatorBySymbol(symbol)
        if op.isPresent {
            return Optional.some(op!.id)
        }
        return Optional.none
    }

    public func findOperatorById(ident: OperatorIdentifier) -> Optional<any ExpressionOperator> {
        var op: Optional<any ExpressionOperator> = infix.findOperatorById(ident)
        if op.isPresent {
            return op
        }
        op = prefix.findOperatorById(ident)
        if op.isPresent {
            return op
        }
        op = postfix.findOperatorById(ident)
        if op.isPresent {
            return op
        }
        return Optional.none
    }

    // MARK: - API (internal)

    func findOperatorListByType(_ type: OperatorType) -> ExpressionOperatorTypeStorage {
        switch type {
        case .prefix:
            return self.prefix
        case .infix:
            return self.infix
        case .postfix:
            return self.postfix
        }
    }

    func findOperatorInStorage(_ symbol: String, storage: ExpressionOperatorTypeStorage) -> Optional<OperatorIdentifier> {
        switch storage.findOperatorBySymbol(symbol) {
        case .none:
            return .none
        case .some(let op):
            return op.id
        }
    }

    // MARK: - Protocol ExpressionOperatorRepository

    public func hasPrefixOperator(_ symbol: String) -> Bool {
        self.findPrefixOperatorId(symbol).isPresent
    }
    
    public func hasInfixOperator(_ symbol: String) -> Bool {
        self.findInfixOperatorId(symbol).isPresent
    }
    
    public func hasPostfixOperator(_ symbol: String) -> Bool {
        self.findPostfixOperatorId(symbol).isPresent
    }

    public func findPrefixOperatorId(_ symbol: String) -> Optional<OperatorIdentifier> {
        return findOperatorInStorage(symbol, storage: self.prefix)
    }

    public func findInfixOperatorId(_ symbol: String) -> Optional<OperatorIdentifier> {
        return findOperatorInStorage(symbol, storage: self.infix)
    }

    public func findPostfixOperatorId(_ symbol: String) -> Optional<OperatorIdentifier> {
        return findOperatorInStorage(symbol, storage: self.postfix)
    }

    public func findOperator(_ identifier: Optional<OperatorIdentifier>) -> Optional<any ExpressionOperator> {
        if !identifier.isPresent {
            return Optional.none
        }
        return findOperatorById(ident: identifier!)
    }
}
