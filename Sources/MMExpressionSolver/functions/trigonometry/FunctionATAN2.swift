//
//  FunctionATAN2.swift
//  MMExpressionSolver
//

import Foundation

/// Function ATAN2()
///
/// Implementation of expression-function `ATAN2()`.
///
/// The ATAN2() function returns the angle (in radians) between the positive x-axis and the point (x, y) in the Cartesian plane.
/// It extends the basic ATAN() function by correctly handling the quadrant of the point.
///
/// ```
/// ATAN2(y: numeric value, x: numeric value) -> double
/// ```
///
/// Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>.
public final class FunctionATAN2: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "ATAN2"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionATAN2") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionATAN2.symbolFunction,
        parameters:[
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameY,
                                        strictTypes: [.double, .float, .decimal, .int ]),
            ExpressionFunctionParameter(name: ExpressionFunctionParameter.nameX,
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
            let y: Double = p1.asConvertedDoubleNumber()!
            let x: Double = p2.asConvertedDoubleNumber()!
            return ExpressionValue.of(atan2(y, x))!
        }
        if p2.isNumericValue {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameX,
                                                       value: p1.asStringForError())
        }
        throw ExpressionError.invalidParameterType(token: functionToken,
                                                   funcName: definition.name,
                                                   paramName: ExpressionFunctionParameter.nameY,
                                                   value: p2.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionATAN2.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionATAN2.symbolFunction
    }

}
