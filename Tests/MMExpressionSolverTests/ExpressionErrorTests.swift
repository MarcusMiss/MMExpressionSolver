//
//  ExpressionErrorTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionError")
class ExpressionErrorTests {

    @Test("ExpressionError errorDescription (en)")
    func localizedDescriptionEN() async throws {
        print(ExpressionError.internalError(error: "SYM").localizedDescription)
        #expect(ExpressionError.internalError(error: "SYM").localizedDescription
                == "Internal error SYM occurred.")

        print(ExpressionError.unknownEscapeCharacter(position: 10, symbol: "SYM").localizedDescription)
        #expect(ExpressionError.unknownEscapeCharacter(position: 10, symbol: "SYM").localizedDescription
                == "Unknown escape character “SYM“ used at position 10.")

        print(ExpressionError.closingQuoteNotFound(start: 5, end: 10, symbol: "SYM").localizedDescription)
        #expect(ExpressionError.closingQuoteNotFound(start: 5, end: 10, symbol: "SYM").localizedDescription
                == "Closing quote-symbol for “SYM“ not found in range (5-10).")

        print(ExpressionError.illegalNumberFormat(position: 5, symbol: "SYM").localizedDescription)
        #expect(ExpressionError.illegalNumberFormat(position: 5, symbol: "SYM").localizedDescription
                == "Illegal number-format found “SYM“ at position 5.")

        print(ExpressionError.numberWithMoreThanOneDecimalPoint(position: 5, symbol: "SYM").localizedDescription)
        #expect(ExpressionError.numberWithMoreThanOneDecimalPoint(position: 5, symbol: "SYM").localizedDescription
                == "More than one allowed decimal-point found “SYM“ at position 5.")

        print(ExpressionError.unexpectedClosingBrace(token: Token.of(position: 1, value: ")", type: .braceClose)).localizedDescription)
        #expect(ExpressionError.unexpectedClosingBrace(token: Token.of(position: 1, value: ")", type: .braceClose)).localizedDescription
                == "Unexpected closing brace at position 1.")

        print(ExpressionError.unexpectedClosingArray(token: Token.of(position: 1, value: "]", type: .arrayClose)).localizedDescription)
        #expect(ExpressionError.unexpectedClosingArray(token: Token.of(position: 1, value: ")", type: .braceClose)).localizedDescription
                == "Unexpected closing array at position 1.")

        print(ExpressionError.unexpectedOpenArray(token: Token.of(position: 1, value: "(", type: .arrayOpen)).localizedDescription)
        #expect(ExpressionError.unexpectedOpenArray(token: Token.of(position: 1, value: ")", type: .braceClose)).localizedDescription
                == "Unexpected open array at position 1.")

        print(ExpressionError.unexpectedStructureSeparator(token: Token.of(position: 1, value: ".", type: .arrayOpen)).localizedDescription)
        #expect(ExpressionError.unexpectedStructureSeparator(token: Token.of(position: 1, value: ".", type: .braceClose)).localizedDescription
                == "Unexpected structure separator at position 1.")

        print(ExpressionError.unknownFunction(start: 5, end: 10, symbol: "SYM").localizedDescription)
        #expect(ExpressionError.unknownFunction(start: 5, end: 10, symbol: "SYM").localizedDescription
                == "Unknown function “SYM“ was addressed at range (5-10).")

        print(ExpressionError.unknownOperator(start: 5, end: 10, symbol: "SYM").localizedDescription)
        #expect(ExpressionError.unknownOperator(start: 5, end: 10, symbol: "SYM").localizedDescription
                == "Unknown operator “SYM“ was addressed at range (5-10).")

        print(ExpressionError.missingOperator(start: 5, end: 10, symbol: "SYM").localizedDescription)
        #expect("Missing operator SYM at range (5-10)."
                == ExpressionError.missingOperator(start: 5, end: 10, symbol: "SYM").localizedDescription)

        print(ExpressionError.misplacedStructureOperator(token: Token.of(position: 1, value: ".", type: .arrayOpen)).localizedDescription)
        #expect("Misplaced structure-operator “.“ found at range (1-2)."
                == ExpressionError.misplacedStructureOperator(token: Token.of(position: 1, value: ".", type: .braceClose)).localizedDescription)

        print(ExpressionError.unexpectedTokenAfterInfixOperator(token: Token.of(position: 1, value: "+", type: .arrayOpen)).localizedDescription)
        #expect("Unexpected token “+“ found at range (1-2) after Infix-operator."
                == ExpressionError.unexpectedTokenAfterInfixOperator(token: Token.of(position: 1, value: "+", type: .braceClose)).localizedDescription)

        print(ExpressionError.missingOperandForOperator(token: Token.of(position: 1, value: "+", type: .arrayOpen)).localizedDescription)
        #expect("Missing Operand for operator “+“ at range (1-2)."
                == ExpressionError.missingOperandForOperator(token: Token.of(position: 1, value: "+", type: .braceClose)).localizedDescription)

        print(ExpressionError.missingSecondOperandForOperator(token: Token.of(position: 1, value: "+", type: .arrayOpen)).localizedDescription)
        #expect("Missing second Operand for operator “+“ at range (1-2)."
                == ExpressionError.missingSecondOperandForOperator(token: Token.of(position: 1, value: "+", type: .braceClose)).localizedDescription)

        print(ExpressionError.unexpectedToken(token: Token.of(position: 1, value: "+", type: .arrayOpen)).localizedDescription)
        #expect("Unexpected token “+“ given at range (1-2)."
                == ExpressionError.unexpectedToken(token: Token.of(position: 1, value: "+", type: .braceClose)).localizedDescription)

        print(ExpressionError.emptyExpression(source: "SYM").localizedDescription)
        #expect("Empty expression received: “SYM“"
                == ExpressionError.emptyExpression(source: "SYM").localizedDescription)

        print(ExpressionError.tooManyOperands(source: "SYM").localizedDescription)
        #expect("Too many operands received: “SYM“"
                == ExpressionError.tooManyOperands(source: "SYM").localizedDescription)

        print(ExpressionError.unexpectedToken(token: Token.of(
            position: 1, value: "+", type: .braceClose)).localizedDescription)
        #expect(ExpressionError.unexpectedToken(token: Token.of( position: 1, value: "+", type: .braceClose)).localizedDescription
                == "Unexpected token “+“ given at range (1-2).")

        print(ExpressionError.divisionByZero(token: Token.of(position: 1, value: "0", type: .literalNumber)).localizedDescription)
        #expect(ExpressionError.divisionByZero(token: Token.of(position: 1, value: "0", type: .literalNumber)).localizedDescription
                == "Division by zero (“0“) found at position 1.")

        print(ExpressionError.useOfArrayWithoutVariable(token: Token.of(position: 1,
                                                                        value: "xx",
                                                                        type: .arrayOpen)).localizedDescription)
        #expect(ExpressionError.useOfArrayWithoutVariable(token: Token.of(position: 1,
                                                                          value: "xx",
                                                                          type: .arrayOpen)).localizedDescription
                == "Use of array without variable “xx“ at range (1-3).")

        print(ExpressionError.nonMatchingOperand(token: Token.of(position: 1,
                                                                 value: "10",
                                                                 type: .literalNumber), value: "10").localizedDescription)
        #expect(ExpressionError.nonMatchingOperand(token: Token.of(position: 1,
                                                                   value: "10",
                                                                   type: .literalNumber), value: "10").localizedDescription
                == "Operand-value “10“ does not match expected type at 1.")
        print(ExpressionError.nonMatchingOperandLeft(token: Token.of(position: 1,
                                                                     value: "10",
                                                                     type: .literalNumber), value: "10").localizedDescription)
        #expect(ExpressionError.nonMatchingOperandLeft(token: Token.of(position: 1,
                                                                       value: "10",
                                                                       type: .literalNumber), value: "10").localizedDescription
                == "Operand-value on left side “10“ does not match expected type at 1.")
        print(ExpressionError.nonMatchingOperandRight(token: Token.of(position: 1,
                                                                      value: "10",
                                                                      type: .literalNumber), value: "10").localizedDescription)
        #expect(ExpressionError.nonMatchingOperandRight(token: Token.of(position: 1,
                                                                        value: "10",
                                                                        type: .literalNumber), value: "10").localizedDescription
                == "Operand-value on right side “10“ does not match expected type at 1.")
        
        
        print(ExpressionError.invalidParameterType(token: Token.of(position: 1,
                                                                   value: "10",
                                                                   type: .literalNumber),
                                                   funcName: "FUNC",
                                                   paramName: "PARAM",
                                                   value: "murks").localizedDescription)
        #expect(ExpressionError.invalidParameterType(token: Token.of(position: 1,
                                                                     value: "10",
                                                                     type: .literalNumber),
                                                     funcName: "FUNC",
                                                     paramName: "PARAM",
                                                     value: "murks").localizedDescription
                == "Function “FUNC“ received for parameter “PARAM“ invalid value “murks“ at position 1.")

        print(ExpressionError.parameterInInvalidRange(token: Token.of(position: 1,
                                                                   value: "10",
                                                                   type: .literalNumber),
                                                   funcName: "FUNC",
                                                   paramName: "PARAM",
                                                      value: "10.0").localizedDescription)
        #expect(ExpressionError.parameterInInvalidRange(token: Token.of(position: 1,
                                                                     value: "10",
                                                                     type: .literalNumber),
                                                     funcName: "FUNC",
                                                     paramName: "PARAM",
                                                        value: "10.0").localizedDescription
                == "Parameter “PARAM“ of function “FUNC“ at position 1 with value “10.0“ not in valid range.")

        print(ExpressionError.invalidParameterValue(token: Token.of(position: 1,
                                                                   value: "10",
                                                                   type: .literalNumber),
                                                   funcName: "FUNC",
                                                   paramName: "PARAM",
                                                      value: "10.0").localizedDescription)
        #expect(ExpressionError.invalidParameterValue(token: Token.of(position: 1,
                                                                     value: "10",
                                                                     type: .literalNumber),
                                                     funcName: "FUNC",
                                                     paramName: "PARAM",
                                                        value: "10.0").localizedDescription
                == "Parameter “PARAM“ of function “FUNC“ at position 1 with value “10.0“ not valid.")

        print(ExpressionError.argumentMissing(token: Token.of(position: 1,
                                                              value: "10",
                                                              type: .literalNumber)).localizedDescription)
        #expect(ExpressionError.argumentMissing(token: Token.of(position: 1,
                                                                value: "10",
                                                                type: .literalNumber)).localizedDescription
                == "Argument missing for “10“ at position 1.")

        print(ExpressionError.argumentCountNotMatching(token: Token.of(position: 1,
                                                              value: "10",
                                                              type: .literalNumber)).localizedDescription)
        #expect(ExpressionError.argumentCountNotMatching(token: Token.of(position: 1,
                                                                value: "10",
                                                                type: .literalNumber)).localizedDescription
                == "Number of arguments not valid for “10“ at position 1.")

        print(ExpressionError.nillNotAllowed(paramName: "SYM").localizedDescription)
        #expect(ExpressionError.nillNotAllowed(paramName: "SYM").localizedDescription
                == "Nil not allowed for parameter “SYM“.")

        print(ExpressionError.invalidFieldInStructure(token: Token.of(position: 1,
                                                                      value: "10",
                                                                      type: .literalNumber),
                                                      field: "field").localizedDescription)
        #expect(ExpressionError.invalidFieldInStructure(token: Token.of(position: 1,
                                                                        value: "10",
                                                                        type: .literalNumber),
                                                        field: "field").localizedDescription
                == "Field “field“ not valid for structur-access at position 1.")

        
        print(ExpressionError.unknownVariableOrConstant(token: Token.of(position: 1,
                                                                      value: "SYM",
                                                                      type: .literalNumber)).localizedDescription)
        #expect(ExpressionError.unknownVariableOrConstant(token: Token.of(position: 1,
                                                                        value: "SYM",
                                                                        type: .literalNumber)).localizedDescription
                == "Unknown variable or constant “SYM“ at position 1.")

        print(ExpressionError.invalidIndex(token: Token.of(position: 1,
                                                           value: "SYM",
                                                           type: .literalNumber)).localizedDescription)
        #expect(ExpressionError.invalidIndex(token: Token.of(position: 1,
                                                             value: "SYM",
                                                             type: .literalNumber)).localizedDescription
                == "Invalid array-index “SYM“ at position 1.")

        print(ExpressionError.invalidTypeInStructure(token: Token.of(position: 1,
                                                           value: "SYM",
                                                           type: .literalNumber)).localizedDescription)
        #expect(ExpressionError.invalidTypeInStructure(token: Token.of(position: 1,
                                                             value: "SYM",
                                                             type: .literalNumber)).localizedDescription
                == "Unsupported type “literalNumber“ for “SYM“ in structure at 1.")

        print(ExpressionError.invalidParameter(paramName: "P1",
                                               recType: ExpressionValueType.array.getTypeName(),
                                               expType: ExpressionValueType.datetime.getTypeName(),
                                               value: "FOO").localizedDescription)
        #expect(ExpressionError.invalidParameter(paramName: "P1",
                                                 recType: ExpressionValueType.array.getTypeName(),
                                                 expType: ExpressionValueType.datetime.getTypeName(),
                                                 value: "FOO").localizedDescription
                == "Parameter “P1“ expected Array but got Date: “FOO“.")

    }

}
