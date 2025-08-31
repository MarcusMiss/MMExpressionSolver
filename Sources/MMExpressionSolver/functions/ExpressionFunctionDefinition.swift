//
//  ExpressionFunctionDefinition.swift
//  MMExpressionSolver
//

import Foundation

/// Definition of an expression-function.
///
/// This struct describes the _interface_ of an expression-function.
/// A function has a symbolic-name which will be used for registration and error-messages.
/// Additionally all argments or parameters of this functions are declared. Only the last parameter is allowed to be an _vararg_.
/// Functions without any parameters are allowed.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public struct ExpressionFunctionDefinition: Hashable, CustomStringConvertible, CustomDebugStringConvertible {

    // MARK: - Properties

    /// Name of function
    public let name: String
    /// Parameter(s) of a function
    public let parameters: [ExpressionFunctionParameter]

    /// Indicator if function-definition contains an vararg
    public var hasVarsArgs: Bool { get {
        parameters.filter { $0.isVarArg }.count > 0
    }}

    // MARK: - Initialization
    
    /// Initialization of this object.
    /// - Parameters:
    ///   - name: Name of function
    ///   - parameters: Parameters of function
    public init(name: String, parameters: [ExpressionFunctionParameter]) {
        self.name = name
        self.parameters = parameters
    }
    
    // MARK: - Protocol Equatable

    public static func == (lhs: ExpressionFunctionDefinition, rhs: ExpressionFunctionDefinition) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    // MARK: - Protocol Hashable

    public func hash(into hasher: inout Hasher) {
        for parameter in parameters {
            hasher.combine(parameter)
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return "name:\(name), parameters:\(parameters)"
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "ExpressionFunctionDefinition(name:\(name), parameters:\(parameters.debugDescription))"
    }

}
