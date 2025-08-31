//
//  OperatorIdentifier.swift
//  MMExpressionSolver
//

import Foundation

/// Identifier of a expression-operator.
///
/// This identifier will be used to identify an operator.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public struct OperatorIdentifier: Identifiable, Hashable, Sendable, CustomStringConvertible, CustomDebugStringConvertible {

    // MARK: - Properties

    /// identifier-attribute
    public let id: String

    // MARK: - Initialization
    
    /// Initialistion of this object.
    /// - Parameter id: identifier
    public init(_ id: String) {
        self.id = id
    }

    // MARK: - Protocol Equatable

    public static func == (lhs: OperatorIdentifier, rhs: OperatorIdentifier) -> Bool {
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
        return "OperatorIdentifier(id:\'\(self.id)\')"
    }

}
