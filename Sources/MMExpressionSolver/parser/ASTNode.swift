//
//  ASTNode.swift
//  MMExpressionSolver
//

/// A node within an Abstract-Syntax-Tree.
///
/// This node is used build an Abstract-Syntax-Tree. It stores its chilldren and also its related source token.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public class ASTNode: Hashable, CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: - Properties

    /// The source token
    public let token: Token
    /// Children (or parameters) for this node
    public let parameters: [ASTNode]
    

    // MARK: - Initialization
    
    /// Initialization of this object with assignment of children.
    /// - Parameters:
    ///   - token: related token
    ///   - parameters: children of this node
    public init(_ token: Token, parameters: [ASTNode]) {
        self.token = token
        self.parameters = parameters
    }
    
    /// Initialization of this object without any children.
    /// - Parameter token: related token
    public convenience init(_ token: Token) {
        self.init(token, parameters: [])
    }

    // MARK: - Protocol Equatable

    public static func == (lhs: ASTNode, rhs: ASTNode) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    // MARK: - Protocol Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.token)
        for parameter in parameters {
            hasher.combine(parameter)
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return "token: \(self.token), parameters: \(self.parameters)"
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "ASTNode(token: \(self.token), parameters: \(self.parameters))"
    }

}
