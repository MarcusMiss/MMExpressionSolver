//
//  ExpressionError.swift
//  MMExpressionSolver
//

import Foundation

/// Enumeration of all expression-errors
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public enum ExpressionError: Error {

    // MARK: - Parser errors

    /// Internal error
    case internalError(error: String)
    /// Error: invalid escape character
    case unknownEscapeCharacter(position: Int, symbol: String)
    /// Error: Closing quote of String-literal not found
    case closingQuoteNotFound(start: Int, end: Int, symbol: String)
    /// Error: Illegal number-format
    case illegalNumberFormat(position: Int, symbol: String)
    /// Error: Illegal number-format
    case numberWithMoreThanOneDecimalPoint(position: Int, symbol: String)
    /// Error: Unexpected closing brace
    case unexpectedClosingBrace(token: Token)
    /// Error: Unexpected closing array
    case unexpectedClosingArray(token: Token)
    /// Error: Unexpexted open array
    case unexpectedOpenArray(token: Token)
    /// Error : Unexpected structure separator
    case unexpectedStructureSeparator(token: Token)
    /// Error: An unknown function was referenced
    case unknownFunction(start: Int, end: Int, symbol: String)
    /// Error: An unknown operator was referenced
    case unknownOperator(start: Int, end: Int, symbol: String)
    /// Error: Operator is missing
    case missingOperator(start: Int, end: Int, symbol: String)
    /// Error: Misplaced structure-operator
    case misplacedStructureOperator(token: Token)
    /// Error: Unexpected token after infix operator
    case unexpectedTokenAfterInfixOperator(token: Token)
    /// Error: Missing Operand for Operatpr
    case missingOperandForOperator(token: Token)
    /// Error : Missing second Operand for Operator
    case missingSecondOperandForOperator(token: Token)
    /// Error: Received unexpected token
    case unexpectedToken(token: Token)
    /// Error: Received empty expression
    case emptyExpression(source: String)
    /// Error: Too many operands received
    case tooManyOperands(source: String)

    // MARK: - Evaluation errors

    /// Error: Use of array without variable
    case useOfArrayWithoutVariable(token: Token)
    /// Error: operand does not match expected type
    case nonMatchingOperand(token: Token, value: String)
    /// Error: left-operand does not match expected type
    case nonMatchingOperandLeft(token: Token, value: String)
    /// Error: right-operand does not match expected type
    case nonMatchingOperandRight(token: Token, value: String)
    /// Error: Invalid parameter-type for function-call
    case invalidParameterType(token: Token, funcName: String, paramName: String, value: String)
    // Error: Parameter not in valid range
    case parameterInInvalidRange(token: Token, funcName: String, paramName: String, value: String)
    // Error: Invalid Parameter value
    case invalidParameterValue(token: Token, funcName: String, paramName: String, value: String)
    // Error: argument is missing
    case argumentMissing(token: Token)
    // Error: invalid number of arguments
    case argumentCountNotMatching(token: Token)
    // Error: nil not allowed
    case nillNotAllowed(paramName: String)
    // Error: invalid field in structure
    case invalidFieldInStructure(token: Token, field: String)
    // Error: parameter-type not valid
    case invalidParameter(paramName: String, recType: String, expType: String, value: String)
    /// Error: Unknown variable or constant
    case unknownVariableOrConstant(token: Token)
    /// Error: Invalid index
    case invalidIndex(token: Token)
    // Error: invalid type in structure
    case invalidTypeInStructure(token: Token)

    // MARK: - Mathematic errors

    /// Error: Division By Zero Not Allowed
    case divisionByZero(token: Token)

}

extension ExpressionError: Equatable, LocalizedError {
    
    /// Return localized description of an error
    public var errorDescription: String? {
        switch self {
        case .internalError(error: let error):
            return LocalizedExprErrorString("error.internalError", with: error)

        case .unknownEscapeCharacter(position: let position,
                                     symbol: let symbol):
            return LocalizedExprErrorString("error.unknownEscapeCharacter", with: position, symbol)

        case.closingQuoteNotFound(start: let start,
                                  end: let end,
                                  symbol: let symbol):
            return LocalizedExprErrorString("error.closingQuoteNotFound", with: symbol, start, end)

        case .illegalNumberFormat(position: let position,
                                  symbol: let symbol):
            return LocalizedExprErrorString("error.illegalNumberFormat", with: position, symbol)

        case .numberWithMoreThanOneDecimalPoint(position: let position,
                                                symbol: let symbol):
            return LocalizedExprErrorString("error.numberWithMoreThanOneDecimalPoint", with: position, symbol)

        case .unexpectedClosingBrace(token: let token):
            return LocalizedExprErrorString("error.unexpectedClosingBrace", with: token.position)

        case .unexpectedClosingArray(token: let token):
            return LocalizedExprErrorString("error.unexpectedClosingArray", with: token.position)

        case .unexpectedOpenArray(token: let token):
            return LocalizedExprErrorString("error.unexpectedOpenArray", with: token.position)

        case .unexpectedStructureSeparator(token: let token):
            return LocalizedExprErrorString("error.unexpectedStructureSeparator", with: token.position)

        case .unknownFunction(start: let start,
                              end: let end,
                              symbol: let symbol):
            return LocalizedExprErrorString("error.unknownFunction", with: symbol, start, end)

        case .unknownOperator(start: let start,
                              end: let end,
                              symbol: let symbol):
            return LocalizedExprErrorString("error.unknownOperator", with: symbol, start, end)

        case .missingOperator(start: let start,
                              end: let end,
                              symbol: let symbol):
            return LocalizedExprErrorString("error.missingOperator", with: symbol, start, end)

        case .misplacedStructureOperator(token: let token):
            return LocalizedExprErrorString("error.misplacedStructureOperator",
                                            with: token.value, token.position, token.position + token.value.count)

        case .unexpectedTokenAfterInfixOperator(token: let token):
            return LocalizedExprErrorString("error.unexpectedTokenAfterInfixOperator",
                                            with: token.value, token.position, token.position + token.value.count)

        case .missingOperandForOperator(token: let token):
            return LocalizedExprErrorString("error.missingOperandForOperator",
                                            with: token.value, token.position, token.position + token.value.count)

        case .missingSecondOperandForOperator(token: let token):
            return LocalizedExprErrorString("error.missingSecondOperandForOperator",
                                            with: token.value, token.position, token.position + token.value.count)

        case .unexpectedToken(token: let token):
            return LocalizedExprErrorString("error.unexpectedToken",
                                            with: token.value, token.position, token.position + token.value.count)

        case .emptyExpression(source: let source):
            return LocalizedExprErrorString("error.emptyExpression", with: source)

        case .tooManyOperands(source: let source):
            return LocalizedExprErrorString("error.tooManyOperands", with: source)

        case .useOfArrayWithoutVariable(token: let token):
            return LocalizedExprErrorString("error.useOfArrayWithoutVariable",
                                            with: token.value, token.position, token.position + token.value.count)

        case .nonMatchingOperand(token: let token,
                                 value: let value):
            return LocalizedExprErrorString("error.nonMatchingOperand",
                                            with: value, token.position)

        case .nonMatchingOperandLeft(token: let token,
                                     value: let value):
            return LocalizedExprErrorString("error.nonMatchingOperandLeft",
                                            with: value, token.position)

        case .nonMatchingOperandRight(token: let token,
                                      value: let value):
            return LocalizedExprErrorString("error.nonMatchingOperandRight",
                                            with: value, token.position)

        case .invalidParameterType(token: let token,
                                   funcName: let funcName,
                                   paramName: let paramName,
                                   value: let value):
            return LocalizedExprErrorString("error.invalidParameterType",
                                            with: token.position, funcName, paramName, value)

        case .parameterInInvalidRange(token: let token,
                                      funcName:let funcName,
                                      paramName: let paramName,
                                      value: let value):
            return LocalizedExprErrorString("error.parameterInInvalidRange",
                                            with: token.position, funcName, paramName, value)

        case .invalidParameterValue(token: let token,

                                    funcName: let funcName,
                                    paramName: let paramName,
                                    value: let value):
            return LocalizedExprErrorString("error.invalidParameterValue",
                                            with: token.position, funcName, paramName, value)

        case .argumentMissing(token: let token):
            return LocalizedExprErrorString("error.argumentMissing",
                                            with: token.position, token.value)

        case .argumentCountNotMatching(token: let token):
            return LocalizedExprErrorString("error.argumentCountNotMatching",
                                            with: token.position, token.value)

        case .nillNotAllowed(paramName: let paramName):
            return LocalizedExprErrorString("error.nillNotAllowed", with: paramName)

        case .invalidParameter(paramName: let paramName,
                               recType: let recType,
                               expType: let expType,
                               value: let value):
            return LocalizedExprErrorString("error.invalidParameter", with: paramName, recType, expType, value)

        case .invalidFieldInStructure(token: let token,
                                      field: let field):
            return LocalizedExprErrorString("error.invalidFieldInStructure", with: token.position, field)

        case .unknownVariableOrConstant(token: let token):
            return LocalizedExprErrorString("error.unknownVariableOrConstant", with: token.value, token.position)

        case .divisionByZero(token: let token):
            return LocalizedExprErrorString("error.divisionByZero", with: token.value, token.position)

        case .invalidIndex(token: let token):
            return LocalizedExprErrorString("error.invalidIndex", with: token.value, token.position)

        case .invalidTypeInStructure(token: let token):
            return LocalizedExprErrorString("error.invalidTypeInStructure", with: token.type.rawValue, token.value, token.position)
        }
    }

}

fileprivate func LocalizedExprErrorString(_ key: String, with arguments: CVarArg...) -> String {
    let localizedString = Foundation.NSLocalizedString(
        key,
        tableName: "MMExpressionErrors",
        bundle: Bundle.module,
        value: "",
        comment: "")
    return String.localizedStringWithFormat(localizedString, arguments)
}
