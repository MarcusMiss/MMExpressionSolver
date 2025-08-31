//
//  ExpressionValue+asType.swift
//  MMExpressionSolver
//

import Foundation

public extension ExpressionValue {

    /// Return value as Int-value.
    /// - Returns: Int-value when available
    func asInteger() -> Optional<Int> {
        switch self.type {
        case .int:
            return self.value as? Int
        default:
            return Optional.none
        }
    }

    /// Return value as Decimal-value.
    /// - Returns: Decimal-value when available
    func asDecimal() -> Optional<Decimal> {
        switch self.type {
        case .decimal:
            return self.value as? Decimal
        default:
            return Optional.none
        }
    }

    /// Return value as Double-value.
    /// - Returns: Double-value when available
    func asDouble() -> Optional<Double> {
        switch self.type {
        case .double:
            return self.value as? Double
        default:
            return Optional.none
        }
    }

    /// Return value as Float-value.
    /// - Returns: Float-value when available
    func asFloat() -> Optional<Float> {
        switch self.type {
        case .float:
            return self.value as? Float
        default:
            return Optional.none
        }
    }

    /// Return value as String-value.
    /// - Returns: String-value when available
    func asString() -> Optional<String> {
        switch self.type {
        case .string:
            return self.value as? String
        default:
            return Optional.none
        }
    }

    /// Return value as Bool-value.
    /// - Returns: Bool-value when available
    func asBoolean() -> Optional<Bool> {
        switch self.type {
        case .boolean:
            return self.value as? Bool
        default:
            return Optional.none
        }
    }

    /// Return value as DateTime-value.
    /// - Returns: DateTime-value when available
    func asDateTime() -> Optional<Date> {
        switch self.type {
        case .datetime:
            return self.value as? Date
        default:
            return Optional.none
        }
    }

    /// Return value as AST-node-value.
    /// - Returns: AST-node-value when available
    func asNode() -> Optional<ASTNode> {
        switch self.type {
        case .nodeAST:
            return self.value as? ASTNode
        default:
            return Optional.none
        }
    }

    /// Return value as Array-value.
    /// - Returns: Array-value when available
    func asArray() -> Optional<Array<Any?>> {
        switch self.type {
        case .array:
            return self.value as? Array
        default:
            return Optional.none
        }
    }

    /// Return value as tupel-value.
    /// - Returns:tupel-value when available
    func asTupel() -> Optional<()> {
        switch self.type {
        case .tupel:
            return self.value as? ()
        default:
            return Optional.none
        }
    }

    /// Return value as object-value.
    /// - Returns: object-value when available
    func asObject() -> Optional<Any> {
        switch self.type {
        case .objClass:
            return self.value
        default:
            return Optional.none
        }
    }

    /// Return value as struct-value.
    /// - Returns: struct-value when available
    func asStruct() -> Optional<Any> {
        switch self.type {
        case .objStruct:
            return self.value
        default:
            return Optional.none
        }
    }

}
