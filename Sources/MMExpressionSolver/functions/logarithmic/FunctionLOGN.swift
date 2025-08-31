//
//  FunctionLOGN.swift
//  MMExpressionSolver
//

import Foundation

/// Function LOGN()
///
/// Implementation of expression-function `LOGN()`.
///
/// The LOGN() function returns the logarithm of a positive number x to a specified base n.
///
/// ```
/// LOGN(base: numeric value, value: numeric value) -> double
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionLOGN: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "LOGN"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionLOGN") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionLOGN.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameBase,
                                        strictTypes: [.double, .float, .decimal, .int ]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameValue,
                                        strictTypes: [.double, .float, .decimal, .int ])
        ]
    )

    public var symbols: [String] { get { [definition.name] } }
    
    public func evaluateFunction(expression: MMExpression,
                                 context: any ExpressionEvaluationContext,
                                 functionToken: Token,
                                 arguments: [ExpressionValue]) throws(ExpressionError) -> ExpressionValue {
        let p1: ExpressionValue = arguments[0]
        let p2: ExpressionValue = arguments[1]
        if p1.isNumericValue && p2.isNumericValue {
            let base: Double = p1.asConvertedDoubleNumber()!
            let value: Double = p2.asConvertedDoubleNumber()!
            if base == 1.0 {
                throw ExpressionError.parameterInInvalidRange(token: functionToken,
                                                              funcName: FunctionLOGN.symbolFunction,
                                                              paramName: ExpressionFunctionParameter.nameBase,
                                                              value: p1.asStringForError())
            }
            if base <= 0.0 {
                throw ExpressionError.parameterInInvalidRange(token: functionToken,
                                                              funcName: FunctionLOGN.symbolFunction,
                                                              paramName: ExpressionFunctionParameter.nameBase,
                                                              value: p1.asStringForError())
            }
            if value <= 0.0 {
                throw ExpressionError.parameterInInvalidRange(token: functionToken,
                                                              funcName: FunctionLOGN.symbolFunction,
                                                              paramName: ExpressionFunctionParameter.nameValue,
                                                              value: p2.asStringForError())
            }
            return ExpressionValue.of(log(value) / log(base))!
        }
        if p1.isNumericValue {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameValue,
                                                       value: p2.asStringForError())
        }
        throw ExpressionError.invalidParameterType(token: functionToken,
                                                   funcName: definition.name,
                                                   paramName: ExpressionFunctionParameter.nameBase,
                                                   value: p1.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionLOGN.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionLOGN.symbolFunction
    }

}
