//
//  ExpressionValueType.swift
//  MMExpressionSolver
//

import Foundation

/// Enumaration of all data-types.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public enum ExpressionValueType: Codable, Sendable, Hashable {

    case string
    case double
    case float
    case int
    case decimal
    case boolean
    case datetime
    case array
    case objClass
    case objStruct
    case tupel
    case null
    case nodeAST
    case measurement(unit: ExpressionUnitType)

    /// Return name of type.
    /// - Returns: typename
    public func getTypeName() -> String {
        switch self {
        case .string:
            return "String"
        case .double:
            return "Double"
        case .float:
            return "Float"
        case .int:
            return "Int"
        case .boolean:
            return "Bool"
        case .datetime:
            return "Date"
        case .decimal:
            return "Decimal"
        case .array:
            return "Array"
        case .objClass:
            return "Class"
        case .objStruct:
            return "Struct"
        case .tupel:
            return "Tupel"
        case .null:
            return "Nil"
        case .nodeAST:
            return "AST"
        case .measurement:
            return "Measurement"
        }
    }

}
