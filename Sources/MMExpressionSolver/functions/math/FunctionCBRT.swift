//
//  FunctionCBRT.swift
//  MMExpressionSolver
//

import Foundation

/// Function CBRT()
///
/// Implementation of expression-function `CBRT()`.
///
/// The CBRT() (cube root) function returns the cube root of a numeric expression
/// It calculates the real number that, when multiplied by itself three times, equals the given input value.
///
/// ```
/// CBRT(value: decimal) -> decimal
/// CBRT(value: double) -> double
/// CBRT(value: float) -> float
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionCBRT: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "CBRT"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionCBRT") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionCBRT.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [.double, .float, .decimal])
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        if p1.type == .decimal {
            return ExpressionValue.of(Decimal(cbrt(p1.asConvertedDoubleNumber()!)))!
        } else if p1.type == .double {
            return ExpressionValue.of(cbrt(p1.asDouble()!))!
        } else if p1.type == .float {
            return ExpressionValue.of(cbrt(p1.asFloat()!))!
        } else {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameValue,
                                                       value: p1.asStringForError())
        }
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionCBRT.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionCBRT.symbolFunction
    }

}

