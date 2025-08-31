//
//  FunctionIdentifier.swift
//  MMExpressionSolver
//

import Foundation

/// Identifier of an expression-function.
///
/// This identifier will be used to identify a function.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public struct FunctionIdentifier: Identifiable, Hashable, Sendable, CustomStringConvertible, CustomDebugStringConvertible {

    // MARK: - Properties
    
    /// identifier-attribute
    public let id: String

    // MARK: - Initialization
    
    /// Initialization of this object.
    /// - Parameter id: identifier
    public init(_ id: String) {
        self.id = id
    }

    // MARK: - Protocol Equatable

    public static func == (lhs: FunctionIdentifier, rhs: FunctionIdentifier) -> Bool {
        return lhs.id == rhs.id
    }

    // MARK: - Protocol Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return "id:\'\(self.id)\'"
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "FunctionIdentifier(id:\'\(self.id)\')"
    }

}
