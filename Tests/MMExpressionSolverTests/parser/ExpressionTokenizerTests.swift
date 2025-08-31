//
//  ExpressionTokenizerTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("ExpressionTokenizer")
class ExpressionTokenizerTests {

    @Test("Parse empty expression")
    func parseExpression01() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: ""
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("01:\(result)")
        #expect(result.isSuccess)
    }

    @Test("Parse expression '-1'")
    func parseExpression02() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "-1"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("02:\(result)")
        #expect(result.isSuccess)
        #expect(try result.get().count == 2)
    }

    @Test("Parse expression 'a+b'")
    func parseExpression03() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "a+b"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("03:\(result)")
        #expect(result.isSuccess)
        #expect(try result.get().count == 3)
    }

    @Test("Parse expression 'a.x+b.y'")
    func parseExpression04() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "a.x+b.x"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("04:\(result)")
        #expect(result.isSuccess)
        #expect(try result.get().count == 7)
    }

    @Test("Parse array expression")
    func parseExpression05() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "foo[10]"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("05:\(result)")
        try #require(result.isSuccess)
        #expect(try result.get().count == 4)
    }

    @Test("Parse number and postfix-operator")
    func parseExpression06() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "10#"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("06:\(result)")
        try #require(result.isSuccess)
        #expect(try result.get().count == 2)
    }

    @Test("Parse numbers and infix-operator")
    func parseExpression07() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "10 & 20"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("07:\(result)")
        try #require(result.isSuccess)
        #expect(try result.get().count == 3)
    }

    @Test("Parse structure")
    func parseExpression08() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "ident.attribute"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("08:\(result)")
        try #require(result.isSuccess)
        #expect(try result.get().count == 3)
    }

    @Test("Parse structure when not allowed")
    func parseExpression09() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: false,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([])),
            expression: "ident.attribute"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("09:\(result)")
        try #require(result.isFailure)
    }

    @Test("Parse identifier (as infix operator")
    func parseExpression10() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "10 INFIX 20"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("10:\(result)")
        try #require(result.isSuccess)
        #expect(try result.get().count == 3)
    }

    @Test("Parse identifier (as prefix operator)")
    func parseExpression11() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "PREFIX 10"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("11:\(result)")
        try #require(result.isSuccess)
        #expect(try result.get().count == 2)
    }

    @Test("Parse identifier (as postfix operator)")
    func parseExpression12() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "10 POSTFIX"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("12:\(result)")
        try #require(result.isSuccess)
        #expect(try result.get().count == 2)
    }

    @Test("Parse identifier (as unkwnon function call)")
    func parseExpression13() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "FOO(10)"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("13:\(result)")
        try #require(result.isFailure)
    }

    @Test("Parse identifier (as function call)")
    func parseExpression14() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl(
                    ExpressionConfiguration.setupMathFunctions()
                ),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "ABS(10)"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("14:\(result)")
        try #require(result.isSuccess)
    }

    @Test("Parse array closing")
    func parseExpression15() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "FOO[]"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("15:\(result)")
        try #require(result.isFailure)
    }

    @Test("Parse array closing")
    func parseExpression16() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "FOO[(]"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("16:\(result)")
        try #require(result.isFailure)
    }

    @Test("Parse array closing")
    func parseExpression17() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "FOO[1]"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("17:\(result)")
        try #require(result.isSuccess)
    }

    @Test("Parse invalid expression ')100'")
    func parseInvalidExpression1() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: ")100"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("01:\(result)")
        #expect(result.isFailure)
    }

    @Test("Parse invalid expression '100)'")
    func parseInvalidExpression2() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "100)"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("02:\(result)")
        #expect(result.isFailure)
    }

    @Test("Parse invalid expression '100 + )'")
    func parseInvalidExpression3() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "100 + ,"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("03:\(result)")
        try #require(result.isFailure)
    }

    @Test("Parse various identifiers'",
          arguments: [
            "ident",
            "ident1",
            "id_1t1",
          ])
    func parseIdentifiers(ident: String) async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: ident
        )
        expr.skipWhitespaces() // important
        let token: Token = try expr.parseIdentifier()
        try #require(token.type == .variable)
    }

    @Test("Parse structure-separater 'a.b'")
    func parseStructureSeparator() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([])
                ),
            expression: "a.b"
        )
        expr.skipWhitespaces() // important
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("\(result)")
        try #require(result.isSuccess)
        #expect(try result.get().count == 3)
    }

    @Test("Parse structure-separater 'a.'")
    func parseStructureSeparator2() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([])
                ),
            expression: "a."
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("\(result)")
        try #require(result.isSuccess)
        #expect(try result.get().count == 2)
    }

    @Test("Parse structure-separater '.a'")
    func parseStructureSeparator3() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([])
                ),
            expression: ".a"
        )
        let result: Result<[Token], ExpressionError> = expr.parseExpression()
        print("\(result)")
        try #require(result.isFailure)
    }

    @Test("Parse none-token")
    func nextTokenEmpty() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: ""
        )
        #expect(try expr.nextToken() == Optional.none)
    }

    @Test("Parse operator '+' (without registered functions and operator)")
    func nextTokeOperator() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([])
                ),
            expression: "+"
        )
        let error: ExpressionError? = #expect(throws: ExpressionError.self) {
            try expr.nextToken()
        }
        // failure is success because no operator or functions are available
        print("\(String(describing: error))")
        #expect(error == ExpressionError.unknownOperator(start: 1, end: 1, symbol: "+"))
    }

    @Test("Parse prefix-operator only")
    func nextTokeOperatorPrefixOnly() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "@"
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        try #require(token.isPresent == true)
        #expect(token?.type == .operatorPrefix)
    }

    @Test("Parse postfix-operator only")
    func nextTokeOperatorPostfixOnly() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "#"
        )
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try expr.nextToken()
        }
        print("\(String(describing: error))")
        #expect(error == ExpressionError.unknownOperator(start: 1, end: 1, symbol: "#"))
    }

    @Test("Parse infix-operator only")
    func nextTokeOperatorInfixOnly() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators:ExpressionOperatorRepositoryImpl([
                    /* @ */ FakePrefixOperator(),
                    /* # */ FakePostfixOperator(),
                    /* & */ FakeInfixOperator()
                ])
                ),
            expression: "&"
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        try #require(token.isPresent == true)
        #expect(token?.type == .operatorInfix)
    }
    
    @Test("Parse identifier 'name' (without registered functions and operator)")
    func nextTokenIdentifier() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "name"
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        #expect(token.isPresent == true)
        #expect(token?.type == .variable)
        #expect(token?.position == 1)
        #expect(token?.value == "name")
    }

    @Test("Parse structure separator .")
    func nextTokenStructureSeparator() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "."
        )
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try expr.nextToken()
        }
        // failure is success because of invalid expression
        print("\(String(describing: error))")
    }

    @Test("Parse structure separator . when structures are not allowed")
    func nextTokenStructureSeparator2() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(arraysAllowed: true,
                                                   structuresAllowed: false,
                                                   singleQuoteAllowed: true,
                                                   implicitMultiplyAllowed: true,
                                                   functions: ExpressionFunctionRepositoryImpl([]),
                                                   operators: ExpressionOperatorRepositoryImpl([])
                                                  ),
            expression: "."
        )
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try expr.nextToken()
        }
        // failure is success because no opening array was available
        print("\(String(describing: error))")
        // #expect(error == ExpressionError.unexpectedClosingArray(token: Token.of(position: 1, value: "]", type: .arrayClose)))
    }

    @Test("Parse opening array [")
    func nextTokenArrayOpen() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "["
        )
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try expr.nextToken()
        }
        // failure is success
        print("\(String(describing: error))")
        // #expect(error == ExpressionError.unexpectedClosingArray(token: Token.of(position: 1, value: "]", type: .arrayClose)))
    }

    @Test("Parse closing array ]")
    func nextTokenArrayClose() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "]"
        )
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try expr.nextToken()
        }
        // failure is success because no opening array was available
        print("\(String(describing: error))")
        #expect(error == ExpressionError.unexpectedClosingArray(token: Token.of(position: 1, value: "]", type: .arrayClose)))
    }

    @Test("Parse comma ,")
    func nextTokenComma() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: ","
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        #expect(token.isPresent)
        #expect(token?.type == .comma)
        #expect(token?.position == 1)
        #expect(token?.value == ",")
    }

    @Test("Parse opening brace (")
    func nextTokenBraceOpen() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "("
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        #expect(token.isPresent)
        #expect(token?.type == .braceOpen)
        #expect(token?.position == 1)
        #expect(token?.value == "(")
    }

    @Test("Parse closing brace )")
    func nextTokenBraceClose() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: ")"
        )
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try expr.nextToken()
        }
        // failure is success because no opening brace was available
        print("\(String(describing: error))")
        #expect(error == ExpressionError.unexpectedClosingBrace(token: Token.of(position: 1, value: ")", type: .braceClose)))
    }

    @Test("Parse string-literal 'Hello'")
    func nextTokenStringLiteral1() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "\"Hello\""
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        #expect(token.isPresent)
        #expect(token?.type == .literalString)
        #expect(token?.position == 1)
        #expect(token?.value == "Hello")
    }

    @Test("Parse empty string-literal")
    func nextTokenStringLiteral2() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "\"\""
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        #expect(token.isPresent)
        #expect(token?.type == .literalString)
        #expect(token?.position == 1)
        #expect(token?.value == "")
    }

    @Test("Parse invalid string-literal with missing closing quote")
    func nextTokenStringLiteralMissingQuote() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "\"Hello"
        )
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try expr.nextToken()
        }
        print("\(String(describing: error))")
        #expect(error == ExpressionError.closingQuoteNotFound(start: 1, end: 6, symbol: "Hello"))
    }

    @Test("Parse invalid string-literal with invalid escaping")
    func nextTokenStringLiteralInvalidEscape() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "\"Hel\\xlo\""
        )
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try expr.nextToken()
        }
        print("\(String(describing: error))")
        #expect(error == ExpressionError.unknownEscapeCharacter(position: 6, symbol: "x"))
    }

    @Test("Parse invalid string-literal with valid escaping")
    func nextTokenStringLiteralValidEscape() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "\"Hel\\'lo\""
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        #expect(token.isPresent)
        #expect(token?.type == .literalString)
        #expect(token?.position == 1)
        #expect(token?.value == "Hel'lo")
    }

    @Test("Parse decimal number '1234'")
    func nextTokenDecimalNumberLiteral() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "1234"
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        #expect(token.isPresent)
        #expect(token?.type == .literalNumber)
        #expect(token?.position == 1)
        #expect(token?.value == "1234")
    }

    @Test("Parse decimal number '1234.456'")
    func nextTokenDecimalNumberLiteral2() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "1234.456"
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        #expect(token.isPresent)
        #expect(token?.type == .literalNumber)
        #expect(token?.position == 1)
        #expect(token?.value == "1234.456")
    }

    @Test("Parse decimal number '1234.456e10'")
    func nextTokenDecimalNumberLiteral3() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "1234.456e10"
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        #expect(token.isPresent)
        #expect(token?.type == .literalNumber)
        #expect(token?.position == 1)
        #expect(token?.value == "1234.456e10")
    }

    @Test("Parse invalid decimal number '1234..'")
    func nextTokenDecimalNumberLiteral4() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "1234.."
        )
        let error: ExpressionError? = #expect(throws: ExpressionError.self) {
            try expr.nextToken()
        }
        print("\(String(describing: error))")
        #expect(error == ExpressionError.numberWithMoreThanOneDecimalPoint(position: 1, symbol: "1234.."))
    }

    @Test("Parse invalid decimal number '1234.")
    func nextTokenDecimalNumberLiteral5() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "1234."
        )
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try expr.nextToken()
        }
        print("\(String(describing: error))")
        #expect(error == ExpressionError.illegalNumberFormat(position: 1, symbol: "1234."))
    }

    @Test("Parse invalid decimal number '1234e'")
    func nextTokenDecimalNumberLiteral6() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "1234e"
        )
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try expr.nextToken()
        }
        print("\(String(describing: error))")
        #expect(error == ExpressionError.illegalNumberFormat(position: 1, symbol: "1234e"))
    }

    @Test("Parse decimal number '.1234'")
    func nextTokenDecimalNumberLiteral7() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: ".1234"
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        #expect(token.isPresent)
        #expect(token?.type == .literalNumber)
        #expect(token?.position == 1)
        #expect(token?.value == ".1234")
    }
    
    @Test("Parse decimal number '.1234e-5'")
    func nextTokenDecimalNumberLiteral8() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: ".1234e-5"
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        #expect(token.isPresent)
        #expect(token?.type == .literalNumber)
        #expect(token?.position == 1)
        #expect(token?.value == ".1234e-5")
    }
/*
    private func isAtNumberChar() -> Bool {
        let previousChar: Optional<Character> = self.peekPreviousChar()
        if previousChar != Optional.none {
            if (previousChar == ExpressionTokenizer.kExponentLower ||  previousChar == ExpressionTokenizer.kExponentUpper)
                && self.currentChar != ExpressionTokenizer.kDot {
                return self.currentChar.isNumber
                    || self.currentChar == ExpressionTokenizer.kPlus
                    || self.currentChar == ExpressionTokenizer.kMinus
            }
            if previousChar == ExpressionTokenizer.kDot && self.currentChar != ExpressionTokenizer.kDot {
                return self.currentChar.isNumber
                    || self.currentChar == ExpressionTokenizer.kExponentLower
                    || self.currentChar == ExpressionTokenizer.kExponentUpper
            }
        }
        return self.currentChar.isNumber
            || self.currentChar == ExpressionTokenizer.kDot
            || self.currentChar == ExpressionTokenizer.kExponentLower
            || self.currentChar == ExpressionTokenizer.kExponentUpper
    }
*/

    @Test("Parse hexadecimal number '0x1234'")
    func nextTokenHexadecimalNumberLiteral() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "0x1234"
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        #expect(token.isPresent)
        #expect(token?.type == .literalNumber)
        #expect(token?.position == 1)
        #expect(token?.value == "0x1234")
    }

    @Test("Parse hexadecimal number '0X1234'")
    func nextTokenHexadecimalNumberLiteral2() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "0X1234"
        )
        let token: Optional<Token> = try expr.nextToken()
        print("\(String(describing: token))")
        #expect(token.isPresent)
        #expect(token?.type == .literalNumber)
        #expect(token?.position == 1)
        #expect(token?.value == "0X1234")
    }

    @Test("Parse invalid hexadecimal number '0x'")
    func nextTokenHexadecimalNumberLiteral3() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: "0x"
        )
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try expr.nextToken()
        }
        print("\(String(describing: error))")
        #expect(error == ExpressionError.illegalNumberFormat(position: 1, symbol: "0x"))
    }

    @Test("Check invalidTokenAfterInfixOperator()")
    func invalidTokenAfterInfixOperator() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration.createDefault(),
            expression: ""
        )
        #expect(expr.invalidTokenAfterInfixOperator(Token.ofInfix(position: 1, value: "+", ident: OperatorIdentifier("+"))) == true)
        #expect(expr.invalidTokenAfterInfixOperator(Token.of(position: 1, value: ")", type: .braceClose))  == true)
        #expect(expr.invalidTokenAfterInfixOperator(Token.of(position: 1, value: ",", type: .comma))  == true)
        #expect(expr.invalidTokenAfterInfixOperator(Token.of(position: 1, value: "1", type: .literalNumber))  == false)
    }
    
    @Test("Check implicitMultiplicationPossible when not allowed")
    func implicitMultiplicationPossible() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: false,
                functions: ExpressionFunctionRepositoryImpl(
                    ExpressionConfiguration.setupMathFunctions()
                ),
                operators: ExpressionOperatorRepositoryImpl(
                    ExpressionConfiguration.setupArithmeticOperators()
                )
            ),
            expression: "5variable"
        )
        // no previous token yet because not parsing yet implicit-multiply is disallowed
        #expect(expr.implicitMultiplicationPossible(Token.of(position: 1, value: "1", type: .literalNumber)) == false)
        // now lets parse and fail because
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try expr.parseExpressionComplete()
        }
        print("\(String(describing: error))")
        #expect(error == ExpressionError.missingOperator(start: 2, end: 10, symbol: "variable"))
    }

    @Test("Check implicitMultiplicationPossible when allowed but operator is not registered")
    func implicitMultiplicationPossible2() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators: ExpressionOperatorRepositoryImpl([])
            ),
            expression: "5variable"
        )
        // now lets parse and fail because operator for implicit is unregistered
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try expr.parseExpressionComplete()
        }
        print("\(String(describing: error))")
        // #expect(error == ExpressionError.missingOperator(start: 2, end: 10, symbol: "variable"))
    }
    
    @Test("Check implicitMultiplicationPossible when allowed and operator is egistered")
    func implicitMultiplicationPossible3() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators: ExpressionOperatorRepositoryImpl([
                    InfixOperatorMultiply()
                ])
            ),
            expression: "5variable"
        )
        // now lets parse and fail because operator for implicit is unregistered
        let tokens: [Token] = try expr.parseExpressionComplete()
        print("result=\(tokens)")
        try #require(tokens.count == 3)
        #expect(tokens[0].type == .literalNumber)
        #expect(tokens[1].type == .operatorInfix)
        #expect(tokens[2].type == .variable)
    }

    @Test("Validate arrayOpenOrStructureSeparatorNotAllowed")
    func arrayOpenOrStructureSeparatorNotAllowed() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators: ExpressionOperatorRepositoryImpl([
                    InfixOperatorMultiply()
                ])
            ),
            expression: "()"
        )
        expr.skipWhitespaces()
        try #require(expr.arrayOpenOrStructureSeparatorNotAllowed() == true)
    }

    @Test("Validate arrayCloseAllowed")
    func arrayCloseAllowed() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators: ExpressionOperatorRepositoryImpl([
                    InfixOperatorMultiply()
                ])
            ),
            expression: ")()"
        )
        expr.skipWhitespaces()
        try #require(expr.arrayCloseAllowed() == false)
    }

    @Test("Validate prefixOperatorAllowed")
    func prefixOperatorAllowed() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators: ExpressionOperatorRepositoryImpl([
                    InfixOperatorMultiply()
                ])
            ),
            expression: "irrelevant"
        )
        expr.skipWhitespaces()
        try #require(expr.prefixOperatorAllowed() == true)
    }

    @Test("Validate postfixOperatorAllowed")
    func postfixOperatorAllowed() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators: ExpressionOperatorRepositoryImpl([
                    InfixOperatorMultiply()
                ])
            ),
            expression: "irrelevant"
        )
        expr.skipWhitespaces()
        try #require(expr.postfixOperatorAllowed() == false)
    }

    
    @Test("Validate infixOperatorAllowed")
    func infixOperatorAllowed() async throws {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: ExpressionConfiguration(
                arraysAllowed: true,
                structuresAllowed: true,
                singleQuoteAllowed: true,
                implicitMultiplyAllowed: true,
                functions: ExpressionFunctionRepositoryImpl([]),
                operators: ExpressionOperatorRepositoryImpl([
                    InfixOperatorMultiply()
                ])
            ),
            expression: "irrelevant"
        )
        expr.skipWhitespaces()
        try #require(expr.infixOperatorAllowed() == false)
    }

    @Test
    func isAtIdentifierStart() async throws {
        #expect(ExpressionTokenizer.isAtIdentifierStart("A") == true)
        #expect(ExpressionTokenizer.isAtIdentifierStart("_") == true)
        #expect(ExpressionTokenizer.isAtIdentifierStart("9") == false)
    }

    @Test
    func isAtIdentifier() async throws {
        #expect(ExpressionTokenizer.isAtIdentifier("A") == true)
        #expect(ExpressionTokenizer.isAtIdentifier("_") == true)
        #expect(ExpressionTokenizer.isAtIdentifier("9") == true)
    }

    @Test
    func isAtStringLiteralStart() async throws {
        #expect(ExpressionTokenizer.isAtStringLiteralStart("0") == false)
        #expect(ExpressionTokenizer.isAtStringLiteralStart("\"") == true)
        #expect(ExpressionTokenizer.isAtStringLiteralStart("'") == true)
        #expect(ExpressionTokenizer.isAtStringLiteralStart("'", true) == true)
        #expect(ExpressionTokenizer.isAtStringLiteralStart("'", false) == false)
    }

    @Test
    func escapeCharacter() async throws {
        try #expect(ExpressionTokenizer.escapeCharacter("\'", position: 1) == "\'")
        try #expect(ExpressionTokenizer.escapeCharacter("\"", position: 1) == "\"")
        try #expect(ExpressionTokenizer.escapeCharacter("\\", position: 1) == "\\")
        try #expect(ExpressionTokenizer.escapeCharacter("n", position: 1) == "\n")
        try #expect(ExpressionTokenizer.escapeCharacter("r", position: 1) == "\r")
        try #expect(ExpressionTokenizer.escapeCharacter("t", position: 1) == "\t")
        let error: ExpressionError? = try #require(throws: ExpressionError.self) {
            try ExpressionTokenizer.escapeCharacter("#", position: 1)
        }
        print("\(String(describing: error))")
        //  #expect(error == .unknownEscapeCharacter)
    }

    @Test("Validate const symbols")
    func validateConstSymbols() async throws {
        #expect(ExpressionTokenizer.kExponentLower == "e")
        #expect(ExpressionTokenizer.kExponentUpper == "E")
        #expect(ExpressionTokenizer.kDot == ".")
        #expect(ExpressionTokenizer.kComma == ",")
        #expect(ExpressionTokenizer.kPlus == "+")
        #expect(ExpressionTokenizer.kMinus == "-")
        #expect(ExpressionTokenizer.kUnderScore == "_")
        #expect(ExpressionTokenizer.kQuoteSingle == "'")
        #expect(ExpressionTokenizer.kQuoteDouble == "\"")
        #expect(ExpressionTokenizer.kBraceOpen == "(")
        #expect(ExpressionTokenizer.kBraceClose == ")")
        #expect(ExpressionTokenizer.kArrayOpen == "[")
        #expect(ExpressionTokenizer.kArrayClose == "]")

        
        #expect(ExpressionTokenizer.kCodeInitial == -2)
        #expect(ExpressionTokenizer.kCodeEOF == -1)
    }

}
