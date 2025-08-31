//
//  ExpressionFunctionParameter.swift
//  MMExpressionSolver
//

import Foundation

/// Definition of single expression-function-parameter
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public struct ExpressionFunctionParameter: Hashable, CustomStringConvertible, CustomDebugStringConvertible {

    /// Constant for _value_.
    public static let nameValue: String = "value"
    /// Constant for _text_.
    public static let nameText: String = "text"
    /// Constant for _numChars_.
    public static let nameNumChars: String = "numChars"
    /// Constant for _number_.
    public static let nameNumber: String = "number"
    /// Constant for _base_.
    public static let nameBase: String = "base"
    /// Constant for _y_.
    public static let nameX: String = "x"
    /// Constant for _y_.
    public static let nameY: String = "y"
    /// Constant for _start_.
    public static let nameStart: String = "start"
    /// Constant for _length_.
    public static let nameLength: String = "length"

    // MARK: - Properties
    
    /// Name of parameter
    public let name: String
    /// indicator if evaluation is lazy
    public let isLazy: Bool
    /// indicator if vararg-parameter
    public let isVarArg: Bool
    /// indicator if null/nil-arguments are allowed
    public let allowNull: Bool
    /// Some functions might require strict types
    public let strictTypes: [ExpressionValueType]

    // MARK: - Initialization
    
    /// Initialization of this oject
    /// - Parameters:
    ///   - name: Name of this parameter
    ///   - strictTypes: restriction on types
    ///   - isLazy: evaluation is done lazy
    ///   - isVarArg: vararg-parameter
    public init(name: String, strictTypes: [ExpressionValueType] = [], isLazy: Bool = false, isVarArg: Bool = false) {
        self.name = name
        self.strictTypes = strictTypes
        self.allowNull = strictTypes.filter { $0 == .null  }.count > 0
        self.isLazy = isLazy
        self.isVarArg = isVarArg
    }

    /// Initialization of this oject
    /// - Parameters:
    ///   - name: Name of this parameter
    ///   - allowNull: null allowed
    ///   - isLazy: evaluation is done lazy
    ///   - isVarArg: vararg-parameter
    public init(name: String, allowNull: Bool, isLazy: Bool = false, isVarArg: Bool = false) {
        self.name = name
        self.strictTypes = []
        self.allowNull = allowNull
        self.isLazy = isLazy
        self.isVarArg = isVarArg
    }

    // MARK: - Protocol Equatable

    public static func == (lhs: ExpressionFunctionParameter, rhs: ExpressionFunctionParameter) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    // MARK: - Protocol Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.strictTypes)
        hasher.combine(self.allowNull)
        hasher.combine(self.isLazy)
        hasher.combine(self.isVarArg)
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return "name:\'\(self.name)\', strictTypes:\(self.strictTypes), allowNull:\(self.allowNull), isLazy:\(self.isLazy), isVarArg:\(self.isVarArg)"
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "ExpressionFunctionParameter(name:\'\(self.name)\', strictTypes:\(self.strictTypes), allowNull:\(self.allowNull), isLazy:\(self.isLazy), isVarArg:\(self.isVarArg))"
    }

}
