//
//  ExpressionFunctionRepositoryImpl.swift
//  MMExpressionSolver
//

import Foundation
import MMEcletic

/// Default implementation.
///
/// The default ``ExpressionFunctionRepository``-implementation.
/// Functions will be registered by its internal identifier and per symbol name in uppercase.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public class ExpressionFunctionRepositoryImpl: ExpressionFunctionRepository {

    // MARK: - Properties
    
    /// Dictionary of function by symbolic name (in uppercase)
    private var functionsBySymbol: [String: any ExpressionFunction] = [:]
    /// Dictionary of functions by internal identifier
    private var functionsById: [FunctionIdentifier: any ExpressionFunction] = [:]
    
    /// Number of registered functions by symbolic name
    public var countBySymbol: Int { get { self.functionsBySymbol.count }}
    /// Number of registered functions by internal identifier
    public var countById: Int { get { self.functionsById.count }}
    /// Number of register functions
    public var count: Int { get { self.functionsById.count }}

    // MARK: - Initialization

    /// Initialization of this object.
    /// - Paramter functions: Functions to register
    public init(
        _ functions: [any ExpressionFunction]
    ) {
        for fn in functions {
            self.registerFunction(fn)
        }
    }

    // MARK: - API

    @discardableResult
    public func registerFunction(_ fn: any ExpressionFunction) -> ExpressionFunctionRepository {
        self.functionsById[fn.id] = fn
        fn.symbols.forEach {
            self.functionsBySymbol[$0.uppercased()] = fn
        }
        return self;
    }

    // MARK: - Protocol ExpressionFunctionRepository

    public func hasFunction(name: String) -> Bool {
        return self.findFunction(name: name).isPresent
    }

    public func findFunction(name: String) -> Optional<FunctionIdentifier> {
        guard let fn = self.functionsBySymbol[name.uppercased()] else {
            return Optional.none
        }
        return Optional.some(fn.id)
    }

    public func findFunction(identifier: Optional<FunctionIdentifier>) -> Optional<any ExpressionFunction> {
        if identifier.isPresent == false {
            return Optional.none
        }
        guard let fb = self.functionsById[identifier!] else {
            return Optional.none
        }
        return Optional.some(fb)
    }

}
