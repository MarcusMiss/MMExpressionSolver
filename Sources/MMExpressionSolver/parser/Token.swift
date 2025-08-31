//
//  Token.swift
//  MMExpressionSolver
//

import Foundation

/// This class is a representation of parsed token from an epxression.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public struct Token: Hashable, Equatable, Sendable, CustomStringConvertible, CustomDebugStringConvertible {

    // MARK: - Factories

    public static func of(position: Int, value: String, type: TokenType) -> Token {
        return Token(position: position, value: value, type: type)
    }

    public static func of(position: Int, value: Character, type: TokenType) -> Token {
        return Token(position: position, value: String(value), type: type)
    }

    public static func of(position: Int, value: String, ident: FunctionIdentifier) -> Token {
        return Token(position: position, value: value, type: .function, ident: ident)
    }

    public static func ofPrefix(position: Int, value: String, ident: OperatorIdentifier) -> Token {
        return Token(position: position, value: value, type: .operatorPrefix, ident: ident)
    }

    public static func ofInfix(position: Int, value: String, ident: OperatorIdentifier) -> Token {
        return Token(position: position, value: value, type: .operatorInfix, ident: ident)
    }

    public static func ofPostfix(position: Int, value: String, ident: OperatorIdentifier) -> Token {
        return Token(position: position, value: value, type: .operatorPostfix, ident: ident)
    }

    // MARK: - Properties

    let position: Int
    let value: String
    let type: TokenType

    let operatorId: Optional<OperatorIdentifier>
    let functionId: Optional<FunctionIdentifier>

    // MARK: - Initialization

    private init(position: Int, value: String, type: TokenType) {
        self.position = position
        self.value = value
        self.type = type
        self.operatorId = Optional.none
        self.functionId = Optional.none
    }

    private init(position: Int, value: String, type: TokenType, ident: FunctionIdentifier) {
        self.position = position
        self.value = value
        self.type = type
        self.operatorId = Optional.none
        self.functionId = ident
    }

    private init(position: Int, value: String, type: TokenType, ident: OperatorIdentifier) {
        self.position = position
        self.value = value
        self.type = type
        self.operatorId = ident
        self.functionId = Optional.none
    }

    // MARK: - Protocol Equatable

    public static func == (lhs: Token, rhs: Token) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    // MARK: - Protocol Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.position)
        hasher.combine(self.value)
        hasher.combine(self.type)
        if self.operatorId.isPresent {
            hasher.combine(operatorId!)
        } else {
            hasher.combine(0)
        }
        if self.functionId.isPresent {
            hasher.combine(functionId!)
        } else {
            hasher.combine(0)
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        if self.functionId.isPresent {
            return "type:\(self.type), value:\'\(self.value)\', position:\(self.position), functionId:\(String(describing: self.functionId))"
        } else if self.operatorId.isPresent {
            return "type:\(self.type), value:\'\(self.value)\', position:\(self.position), operatorId:\(String(describing: self.operatorId))"
        }
        return "type:\(self.type), value:\'\(self.value)\', position:\(self.position)"
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        if self.functionId.isPresent {
            return "Token(type:\(self.type), value:\'\(self.value)\', position:\(self.position), functionId:\(String(describing: self.functionId)))"
        } else if self.operatorId.isPresent {
            return "Token(type:\(self.type), value:\'\(self.value)\', position:\(self.position), operatorId:\(String(describing: self.operatorId)))"
        }
        return "Token(type:\(self.type), value:\'\(self.value)\', position:\(self.position))"
    }

}
