//
//  ExpressionEvaluationContex.swift
//  MMExpressionSolver
//

import Foundation

/// Context for evaluation of an expression.
///
/// The context-object provides access to:
///
/// - variables
/// - function repository
/// - operator repository
/// - calendar
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public protocol ExpressionEvaluationContext {

    // MARK: - Properties

    var variables: any ExpressionVariableStorage { get }

    var functions: any ExpressionFunctionRepository { get }

    var operators: any ExpressionOperatorRepository { get }

    var calendar: Calendar { get }

}
