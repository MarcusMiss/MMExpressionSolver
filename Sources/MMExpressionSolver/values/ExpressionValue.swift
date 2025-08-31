//
//  ExpressionValue.swift
//  MMExpressionSolver
//

import Foundation
import MMEcletic

/// Wrapper-object to save various supported native types.
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class ExpressionValue : Hashable {

    let standardDateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    // MARK: - Factories
    
    /// Wraps a `nil`-value.
    /// - Returns: wrapped value
    public static func ofNil() -> ExpressionValue {
        return valueOfAny(nil)!
    }

    /// Wraps a `String`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: String) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Int`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Int) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Double`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Double) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Float`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Float) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Decimal`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Decimal) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Bool`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Bool) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Date`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Date) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `ASTNode`-value. Needed for lazy evaluation of ASTs.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: ASTNode) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Array`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: [Any]) -> ExpressionValue {
        return valueOfAny(value)!
    }

    /// Wraps a `Any`-value.
    /// - Parameter value: value to wrap
    /// - Returns: wrapped value
    public static func of(_ value: Any) -> Optional<ExpressionValue> {
        return valueOfAny(value)
    }
    
    /// Internal method to wrap a native value into an expression value.
    /// - Parameter value: value to wrap
    /// - Returns: Wrapper or `nil` if type is unsupported
    static func valueOfAny(_ value: Any?) -> Optional<ExpressionValue> {
        if value == nil {
            return ExpressionValue()
        }
        if value is String {
            return ExpressionValue(value as! String, .string)
        } else if value is Double {
            return ExpressionValue(value as! Double, .double)
        } else if value is Float {
            return ExpressionValue(value as! Float, .float)
        } else if value is Decimal {
            return ExpressionValue(value as! Decimal, .decimal)
        } else if value is Int {
            return ExpressionValue(value as! Int, .int)
        } else if value is Bool {
            return ExpressionValue(value as! Bool, .boolean)
        } else if value is Date {
            return ExpressionValue(value as! Date, .datetime)
        } else if value is ASTNode {
            return ExpressionValue(value as! ASTNode, .nodeAST)
        } else if Mirror(reflecting: value!).displayStyle == .class {
            return ExpressionValue(value, .objClass)
        } else if Mirror(reflecting: value!).displayStyle == .struct {
            return ExpressionValue(value, .objStruct)
        } else if Mirror(reflecting: value!).displayStyle == .collection {
            return ExpressionValue(value, .array)
        } else if Mirror(reflecting: value!).displayStyle == .tuple {
            return ExpressionValue(value, .tupel)
        } else {
            return nil
        }
    }

    // MARK: - Properties

    /// Type of value
    public let type: ExpressionValueType
    /// Internal value
    let value: Any?

    /// Indicator if expression-value is of type `String`.
    public var isStringValue: Bool { return self.type == .string }
    /// Indicator if expression-value is of type `Decimal`.
    public var isDecimalValue: Bool { return self.type == .decimal }
    /// Indicator if expression-value is of type `Double`.
    public var isDoubleValue: Bool { return self.type == .double }
    /// Indicator if expression-value is of type `Float`.
    public var isFloatValue: Bool { return self.type == .float }
    /// Indicator if expression-value is of type `Int`.
    public var isIntegerValue: Bool { return self.type == .int }
    /// Indicator if expression-value is of type `Bool`.
    public var isBooleanValue: Bool { return self.type == .boolean }
    /// Indicator if expression-value is of type `Date`.
    public var isDateTime: Bool { return self.type == .datetime }
    /// Indicator if expression-value is of type `nil`.
    public var isNullValue: Bool { return self.type == .null }
    /// Indicator if expression-value is of type `Decimal`, `Double`, `Float`or `Int`.
    public var isNumericValue: Bool { return self.isDoubleValue || self.isFloatValue || self.isIntegerValue || self.isDecimalValue }
    /// Indicator if expression-value is of type `Array`.
    public var isArrayValue: Bool { return type == .array }
    /// Indicator if expression-value is of type `Class` or `Struct`.
    public var isStructureValue: Bool { return type == .objClass || type == .objStruct }
    /// Indicator if expression-value is of type `Tupel`.
    public var isTupel: Bool { return type == .tupel }
    /// Indicator if expression-value is of type `AST-node`.
    public var isAST: Bool { return type == .nodeAST }

    // MARK: - Initialization
    
    /// Initialization of this object.
    private init() {
        self.value = nil
        self.type = .null
    }

    /// Initialization of this object
    /// - Parameters:
    ///   - value: value
    ///   - type: type
    private init(_ value: Any?, _ type: ExpressionValueType) {
        self.value = value
        self.type = type
    }

    // MARK: - Protocol Hashable

    public static func == (lhs: ExpressionValue, rhs: ExpressionValue) -> Bool {
        if lhs.isNullValue && rhs.isNullValue {
            return true
        } else if lhs.isNumericValue && rhs.isNumericValue {
            let lhsValue: Decimal = lhs.asConvertedDecimalNumber()!
            let rhsValue: Decimal = rhs.asConvertedDecimalNumber()!
            return lhsValue == rhsValue
        } else if lhs.isStringValue && rhs.isStringValue {
            let lhsValue: String = lhs.asString()!
            let rhsValue: String = rhs.asString()!
            return lhsValue == rhsValue
        } else if lhs.isBooleanValue && rhs.isBooleanValue {
            let lhsValue: Bool = lhs.asBoolean()!
            let rhsValue: Bool = rhs.asBoolean()!
            return lhsValue == rhsValue
        } else if lhs.isDateTime && rhs.isDateTime {
            let lhsValue: Date = lhs.asDateTime()!
            let rhsValue: Date = rhs.asDateTime()!
            return lhsValue == rhsValue
        } else if lhs.type == rhs.type {
            return lhs.hashValue == rhs.hashValue
        }
        return false
    }
    
    /// This function calculates an hash-value.
    /// - Parameter hasher: hasher-object
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.type)
        switch self.type {
        case .int:
            hasher.combine(self.value as! Int)
        case .decimal:
            hasher.combine(self.value as! Decimal)
        case .double:
            hasher.combine(self.value as! Double)
        case .float:
            hasher.combine(self.value as! Float)
        case .boolean:
            hasher.combine(self.value as! Bool)
        case .string:
            hasher.combine(self.value as! String)
        case .datetime:
            hasher.combine(self.value as! Date)
        case .nodeAST:
            hasher.combine(self.value as! ASTNode)
        case .null:
            hasher.combine(0)
        case .tupel, .objStruct, .objClass, .array:
            if let conformHash = self.value as? (any Hashable) {
                hasher.combine(conformHash)
            } else {
                // Not sure what is best approach here, ensure unique
                hasher.combine(UUID())
            }
        }
    }

}

extension ExpressionValue: CustomStringConvertible, CustomDebugStringConvertible {

    /// Return object-value as string for messages.
    /// - Returns: object-description for messages.
    public func asStandardString() -> String {
        switch self.type {
        case .int:
            return "\(self.value!)"
        case .double:
            return "\(self.value!)"
        case .float:
            return "\(self.value!)"
        case .decimal:
            return "\(self.value!)"
        case .boolean:
            return "\(self.value!)"
        case .string:
            return "\(self.value!)"
        case .datetime:
            let df: DateFormatter = DateFormatter()
            df.dateFormat = DateFormatter.standardDateFormatPattern
            let now: String = df.string(from: self.asDateTime()!)
            return "\(now)"
        case .nodeAST:
            return "\(self.value!)"
        case .null:
            return "null"
        case .array:
            return "\(self.value!)"
        case .objClass:
            return "\(self.value!)"
        case .objStruct:
            return "\(self.value!)"
        case .tupel:
            return "\(self.value!)"
        }
    }

    /// Return object-value as string for error-messages.
    /// - Returns: object-description for error-messages.
    public func asStringForError() -> String {
        switch self.type {
        case .int:
            return "\(self.value!)"
        case .double:
            return "\(self.value!)"
        case .float:
            return "\(self.value!)"
        case .decimal:
            return "\(self.value!)"
        case .boolean:
            return "\(self.value!)"
        case .string:
            return "\"\(self.value!)\""
        case .datetime:
            let df: DateFormatter = DateFormatter()
            df.dateFormat = DateFormatter.standardDateFormatPattern
            let now: String = df.string(from: self.asDateTime()!)
            return "\"\(now)\""
        case .nodeAST:
            return "\(self.value!)"
        case .null:
            return "null"
        case .array:
            return "\(self.value!)"
        case .objClass:
            return "\(self.value!)"
        case .objStruct:
            return "\(self.value!)"
        case .tupel:
            return "\(self.value!)"
        }
    }
    
    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        switch self.type {
        case .int:
            return "\(self.type): \(self.value!)"
        case .double:
            return "\(self.type): \(self.value!)"
        case .float:
            return "\(self.type): \(self.value!)"
        case .decimal:
            return "\(self.type): \(self.value!)"
        case .boolean:
            return "\(self.type): \(self.value!)"
        case .string:
            return "\(self.type): \"\(self.value!)\""
        case .datetime:
            let df: DateFormatter = DateFormatter()
            df.dateFormat = DateFormatter.standardDateFormatPattern
            let now: String = df.string(from: self.asDateTime()!)
            return "\(self.type): \(now)"
        case .nodeAST:
            return "\(self.value!)"
        case .null:
            return "\(self.type): null"
        case .array:
            return "\(self.type): \(self.value!)"
        case .objClass:
            return "\(self.type): \(self.value!)"
        case .objStruct:
            return "\(self.type): \(self.value!)"
        case .tupel:
            return "\(self.type): \(self.value!)"
        }
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        switch self.type {
        case .int:
            return "\(self.type): \(self.value!)"
        case .double:
            return "\(self.type): \(self.value!)"
        case .float:
            return "\(self.type): \(self.value!)"
        case .decimal:
            return "\(self.type): \(self.value!)"
        case .boolean:
            return "\(self.type): \(self.value!)"
        case .string:
            return "\(self.type): \"\(self.value!)\""
        case .datetime:
            let df: DateFormatter = DateFormatter()
            df.dateFormat = DateFormatter.standardDateFormatPattern
            let now: String = df.string(from: self.asDateTime()!)
            return "\(self.type): \"\(now)\""
        case .nodeAST:
            return "\(self.value!)"
        case .null:
            return "\(self.type): null"
        case .array:
            return "\(self.type): \(self.value.debugDescription)"
        case .objClass:
            return "\(self.type): \(self.value.debugDescription)"
        case .objStruct:
            return "\(self.type): \(self.value.debugDescription)"
        case .tupel:
            return "\(self.type): \(self.value.debugDescription)"
        }
    }

}

extension ExpressionValue {

    /// Check if value has a component (value.component)
    /// - Parameter name: component name
    /// - Returns: true if component is available
    public func hasComponent(_ name: String) -> Bool {
        if self.isStructureValue || self.isTupel {
            return Mirror(reflecting: self.value!).children.contains { $0.label == name }
        }
        return false
    }
    
    /// Return component-value
    /// - Parameter name: component name
    /// - Returns: component-value if available
    public func getComponent(_ name: String) -> Optional<ExpressionValue> {
        var optValue: Optional<ExpressionValue> = Optional.none
        Mirror(reflecting: self.value!).children.forEach { child in
            if child.label == name && !optValue.isPresent {
                optValue = ExpressionValue.of(child.value)
            }
        }
        return optValue
    }

}

extension ExpressionValue {

    /// Operator `EvalValue != EvalValue`.
    /// - Parameters:
    ///   - lhs: left-side value
    ///   - rhs: right-side value
    /// - Returns: `true` if `lhs != rhs`
    public static func != (lhs: ExpressionValue, rhs: ExpressionValue) -> Bool {
        //return !(lhs == rhs)
        if lhs.isNullValue && !rhs.isNullValue {
            return true
        } else if !lhs.isNullValue && rhs.isNullValue {
            return true
        } else if lhs.isNumericValue && rhs.isNumericValue {
            let lhsValue: Decimal = lhs.asConvertedDecimalNumber()!
            let rhsValue: Decimal = rhs.asConvertedDecimalNumber()!
            return lhsValue != rhsValue
        } else if lhs.isStringValue && rhs.isStringValue {
            let lhsValue: String = lhs.asString()!
            let rhsValue: String = rhs.asString()!
            return lhsValue != rhsValue
        } else if lhs.isBooleanValue && rhs.isBooleanValue {
            let lhsValue: Bool = lhs.asBoolean()!
            let rhsValue: Bool = rhs.asBoolean()!
            return lhsValue != rhsValue
        } else if lhs.isDateTime && rhs.isDateTime {
            let lhsValue: Date = lhs.asDateTime()!
            let rhsValue: Date = rhs.asDateTime()!
            return lhsValue != rhsValue
        } else if lhs.type == rhs.type {
            return lhs.hashValue != rhs.hashValue
        }
        return true
    }

    /// Operator `EvalValue > EvalValue`.
    /// - Parameters:
    ///   - lhs: left-side value
    ///   - rhs: right-side value
    /// - Returns: `true` if `lhs > rhs`
    public static func > (lhs: ExpressionValue, rhs: ExpressionValue) -> Bool {
        if lhs.isNumericValue && rhs.isNumericValue {
            let lhsValue: Decimal = lhs.asConvertedDecimalNumber()!
            let rhsValue: Decimal = rhs.asConvertedDecimalNumber()!
            return lhsValue > rhsValue
        } else if lhs.isStringValue && rhs.isStringValue {
            let lhsValue: String = lhs.asString()!
            let rhsValue: String = rhs.asString()!
            return lhsValue > rhsValue
        } else if lhs.isBooleanValue && rhs.isBooleanValue {
            let lhsValue: Int = lhs.asBoolean()! ? 1 : 0
            let rhsValue: Int = rhs.asBoolean()! ? 1 : 0
            return lhsValue > rhsValue
        } else if lhs.isDateTime && rhs.isDateTime {
            let lhsValue: Date = lhs.asDateTime()!
            let rhsValue: Date = rhs.asDateTime()!
            return lhsValue > rhsValue
        }
        return false
    }

    /// Operator `EvalValue >= EvalValue`.
    /// - Parameters:
    ///   - lhs: left-side value
    ///   - rhs: right-side value
    /// - Returns: `true` if `lhs >= rhs`
    public static func >= (lhs: ExpressionValue, rhs: ExpressionValue) -> Bool {
        if lhs.isNullValue && rhs.isNullValue {
            return true
        } else if lhs.isNumericValue && rhs.isNumericValue {
            let lhsValue: Decimal = lhs.asConvertedDecimalNumber()!
            let rhsValue: Decimal = rhs.asConvertedDecimalNumber()!
            return lhsValue >= rhsValue
        } else if lhs.isStringValue && rhs.isStringValue {
            let lhsValue: String = lhs.asString()!
            let rhsValue: String = rhs.asString()!
            return lhsValue >= rhsValue
        } else if lhs.isBooleanValue && rhs.isBooleanValue {
            let lhsValue: Int = lhs.asBoolean()! ? 1 : 0
            let rhsValue: Int = rhs.asBoolean()! ? 1 : 0
            return lhsValue >= rhsValue
        } else if lhs.isDateTime && rhs.isDateTime {
            let lhsValue: Date = lhs.asDateTime()!
            let rhsValue: Date = rhs.asDateTime()!
            return lhsValue >= rhsValue
        } else if lhs.type == rhs.type {
            return lhs.hashValue == rhs.hashValue
        }
        return false
    }

    /// Operator `EvalValue < EvalValue`.
    /// - Parameters:
    ///   - lhs: left-side value
    ///   - rhs: right-side value
    /// - Returns: `true` if `lhs < rhs`
    public static func < (lhs: ExpressionValue, rhs: ExpressionValue) -> Bool {
        if lhs.isNumericValue && rhs.isNumericValue {
            let lhsValue: Decimal = lhs.asConvertedDecimalNumber()!
            let rhsValue: Decimal = rhs.asConvertedDecimalNumber()!
            return lhsValue < rhsValue
        } else if lhs.isStringValue && rhs.isStringValue {
            let lhsValue: String = lhs.asString()!
            let rhsValue: String = rhs.asString()!
            return lhsValue < rhsValue
        } else if lhs.isBooleanValue && rhs.isBooleanValue {
            let lhsValue: Int = lhs.asBoolean()! ? 1 : 0
            let rhsValue: Int = rhs.asBoolean()! ? 1 : 0
            return lhsValue < rhsValue
        } else if lhs.isDateTime && rhs.isDateTime {
            let lhsValue: Date = lhs.asDateTime()!
            let rhsValue: Date = rhs.asDateTime()!
            return lhsValue < rhsValue
        }
        return false
    }

    /// Operator `EvalValue <= EvalValue`.
    /// - Parameters:
    ///   - lhs: left-side value
    ///   - rhs: right-side value
    /// - Returns: `true` if `lhs <= rhs`
    public static func <= (lhs: ExpressionValue, rhs: ExpressionValue) -> Bool {
        if lhs.isNullValue && rhs.isNullValue {
            return true
        } else if lhs.isNumericValue && rhs.isNumericValue {
            let lhsValue: Decimal = lhs.asConvertedDecimalNumber()!
            let rhsValue: Decimal = rhs.asConvertedDecimalNumber()!
            return lhsValue <= rhsValue
        } else if lhs.isStringValue && rhs.isStringValue {
            let lhsValue: String = lhs.asString()!
            let rhsValue: String = rhs.asString()!
            return lhsValue <= rhsValue
        } else if lhs.isBooleanValue && rhs.isBooleanValue {
            let lhsValue: Int = lhs.asBoolean()! ? 1 : 0
            let rhsValue: Int = rhs.asBoolean()! ? 1 : 0
            return lhsValue <= rhsValue
        } else if lhs.isDateTime && rhs.isDateTime {
            let lhsValue: Date = lhs.asDateTime()!
            let rhsValue: Date = rhs.asDateTime()!
            return lhsValue <= rhsValue
        } else if lhs.type == rhs.type {
            return lhs.hashValue == rhs.hashValue
        }
        return false
    }

}
