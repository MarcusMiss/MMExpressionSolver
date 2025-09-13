//
//  FunctionHYPOT.swift
//  MMExpressionSolver
//

import Foundation

/// Function HYPOT()
///
/// Implementation of expression-function `HYPOT()`.
///
/// The HYPOT() function returns the length of the hypotenuse of a right-angled triangle, given the lengths of the two perpendicular sides.
///
/// ```
/// HYPOT(y: numeric value, x: numeric value) -> double
/// ```
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public final class FunctionHYPOT: ExpressionFunction {

    /// Symbol of this function
    static let symbolFunction: String = "HYPOT"

    // MARK: - Protocol Identifiable

    public var id: FunctionIdentifier { get { FunctionIdentifier("FunctionHYPOT") }}

    // MARK: - Protocol ExpressionFunction

    public var definition: ExpressionFunctionDefinition = ExpressionFunctionDefinition(
        name: FunctionHYPOT.symbolFunction,
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
            return ExpressionValue.of(hypot(y, x))!
        }
        if p2.isNumericValue {
            throw ExpressionError.invalidParameterType(token: functionToken,
                                                       funcName: definition.name,
                                                       paramName: ExpressionFunctionParameter.nameY,
                                                       value: p1.asStringForError())
        }
        throw ExpressionError.invalidParameterType(token: functionToken,
                                                   funcName: definition.name,
                                                   paramName: ExpressionFunctionParameter.nameX,
                                                   value: p2.asStringForError())
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return FunctionHYPOT.symbolFunction
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return FunctionHYPOT.symbolFunction
    }

}
