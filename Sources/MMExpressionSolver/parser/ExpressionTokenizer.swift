//
//  ExpressionTokenizer.swift
//  MMExpressionSolver
//

import Foundation

/// This class transforms a string-expression into an array of tokens.
/// 
/// The transformation from an string-expression into an ``Token`` eliminates unnecessary information
/// like whitespaces.
/// 
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public class ExpressionTokenizer {

    static let kExponentLower: Character = "e"
    static let kExponentUpper: Character = "E"
    static let kDot: Character = "."
    static let kComma: Character = ","
    static let kPlus: Character = "+"
    static let kMinus: Character = "-"
    static let kUnderScore: Character = "_"
    static let kQuoteSingle: Character = "'"
    static let kQuoteDouble: Character = "\""
    static let kBraceOpen: Character = "("
    static let kBraceClose: Character = ")"
    static let kArrayOpen: Character = "["
    static let kArrayClose: Character = "]"

    static let kCodeInitial: Int = -2
    static let kCodeEOF: Int = -1

    // MARK: - Properties

    let expression: String
    private let configration: ExpressionConfiguration
    private var tokens: [Token] = []
    private var currentColumnIndex: Int = 0
    private var currentChar: Character = " "
    private var currentCharCode: Int = kCodeInitial
    private var braceBalance: Int = 0
    private var arrayBalance: Int = 0

    // MARK: - Initialization

    /// Initialization of object.
    /// - Parameters:
    ///   - configuration: configuration for parser
    ///   - expression: expression to analyse
    public init(
        configuration: ExpressionConfiguration,
        expression: String
    ) {
        self.configration = configuration
        self.expression = expression
    }

    // MARK: - API (Parsing)

    /// Parse expression.
    ///
    /// The expression will be converted into an array of ``Token``.
    ///
    /// - Returns: parsed tokens or detected ``ExpressionError``
    func parseExpression() -> Result<[Token], ExpressionError> {
        do {
            return .success(try self.parseExpressionComplete())
        } catch let error {
            return .failure(error)
        }
    }

    func parseExpressionComplete() throws(ExpressionError) -> [Token] {
        var currentToken: Optional<Token> = try self.nextToken()
        while currentToken.isPresent {
            if self.implicitMultiplicationPossible(currentToken!) {
                if self.configration.implicitMultiplyAllowed {
                    let operatorMultiply: Optional<OperatorIdentifier> = self.configration.operators.findInfixOperatorId("*")
                    if !operatorMultiply.isPresent {
                        throw ExpressionError.unknownOperator(start: currentToken!.position,
                                                              end: currentToken!.position + currentToken!.value.count,
                                                              symbol: currentToken!.value)
                    }
                    self.tokens.append(Token.ofInfix(position: currentToken!.position,
                                                     value: "",
                                                     ident: operatorMultiply!))
                } else {
                    throw ExpressionError.missingOperator(start: currentToken!.position,
                                                          end: currentToken!.position + currentToken!.value.count,
                                                          symbol: currentToken!.value)
                }
            }
            try self.validateToken(currentToken!)
            self.tokens.append(currentToken!)
            currentToken = try self.nextToken()
        }
        return self.tokens
    }

    /// Validation given token.
    ///
    /// Check if gien token and previous token are harmonizing.
    ///
    /// - Parameter token: related token
    /// - Throws: May throw the ``ExpressionError`` in case of errors
    func validateToken(_ token: Token) throws(ExpressionError) {
        let previousToken: Optional<Token> = self.previousToken()
        if previousToken.isPresent
            && previousToken!.type == .operatorInfix
            && self.invalidTokenAfterInfixOperator(token) {
            throw ExpressionError.unexpectedTokenAfterInfixOperator(token: token)
        }
    }

    /// Check if given token is a valid if trailing after an infix-operator.
    ///
    /// The given token must be of type ``.operatorInfix``, ``.braceClose`` or ``.comma`` when
    /// previous token was an infix-operator
    ///
    /// - Parameter token: related token
    /// - Returns: true if token is valid
    func invalidTokenAfterInfixOperator(_ token: Token) -> Bool {
        switch token.type {
        case .operatorInfix, .braceClose, .comma:
            return true
        default:
            return false
        }
    }
    
    /// Checks if implicit multiplication is possible.
    /// - Parameter token: current token
    /// - Returns: `true` if implicit multiply allowed
    func implicitMultiplicationPossible(_ token: Token) -> Bool {
        let previousToken: Optional<Token> = self.previousToken()
        if !previousToken.isPresent {
            return false
        }
        return (previousToken!.type == .braceOpen && token.type == .braceOpen)
            || (previousToken!.type == .literalNumber && token.type == .variable)
            || (previousToken!.type == .literalNumber && token.type == .braceOpen)
    }

    /// Parse next token from sourc-expression.
    /// -Returns: parsed token if available
    /// - Throws:May throw the ``ExpressionError`` in case of parsing errors
    func nextToken() throws(ExpressionError) -> Optional<Token> {
        self.skipWhitespaces()
        if self.currentCharCode == ExpressionTokenizer.kCodeEOF {
            return Optional.none
        }
        if ExpressionTokenizer.isAtStringLiteralStart(self.currentChar, self.configration.singleQuoteAllowed) {
            return try Optional.some(self.parseStringLiteral())
        } else if self.currentChar == ExpressionTokenizer.kBraceOpen {
            return try Optional.some(self.parseBraceOpen())
        } else if self.currentChar == ExpressionTokenizer.kBraceClose {
            return try Optional.some(self.parseBraceClose())
        } else if self.currentChar == ExpressionTokenizer.kArrayOpen && self.configration.arraysAllowed {
            return try Optional.some(self.parseArrayOpen())
        } else if self.currentChar == ExpressionTokenizer.kArrayClose && self.configration.arraysAllowed {
            return try Optional.some(self.parseArrayClose())
        } else if self.currentChar == ExpressionTokenizer.kDot && !self.isNextCharacterNumberChar() && self.configration.structuresAllowed {
            return try Optional.some(self.parseStructureSeparator())
        } else if self.currentChar == ExpressionTokenizer.kComma {
            return try Optional.some(self.parseComma())
        } else if ExpressionTokenizer.isAtIdentifierStart(self.currentChar) {
            return try Optional.some(self.parseIdentifier())
        } else if self.isAtNumberStart() {
            return try Optional.some(self.parseNumber())
        } else {
            return try Optional.some(self.parseOperator())
        }
    }

    /// Parsing of an operator
    /// - Returns: parsed token
    /// - Throws:May throw the ``ExpressionError`` in case of parsing errors
    func parseOperator() throws (ExpressionError) -> Token {
        let tokenStartIndex: Int = self.currentColumnIndex
        var tokenValueProc: String = ""
        while true {
            tokenValueProc.append(self.currentChar)
            let nextChar: Optional<Character> = self.peekNextChar()
            let possibleNextOperator: String = nextChar.map { tokenValueProc + "\($0)" } ?? tokenValueProc
            let possibleNextOperatorFound: Bool =
                (self.prefixOperatorAllowed() &&  self.configration.operators.hasPrefixOperator(possibleNextOperator))
            || (self.postfixOperatorAllowed() && self.configration.operators.hasPostfixOperator(possibleNextOperator))
            || (self.infixOperatorAllowed() && self.configration.operators.hasInfixOperator(possibleNextOperator))
            self.consumeCharacter()
            if !possibleNextOperatorFound {
                break
            }
        }
        tokenValueProc = tokenValueProc.trim()
        if tokenValueProc.count > 1 {
            tokenValueProc = String(tokenValueProc.dropLast())
        }
        if self.prefixOperatorAllowed() && self.configration.operators.hasPrefixOperator(tokenValueProc) {
            let ident: Optional<OperatorIdentifier> = self.configration.operators.findPrefixOperatorId(tokenValueProc)
            return Token.ofPrefix(position: tokenStartIndex,
                                  value: tokenValueProc,
                                  ident: ident!)
        } else if self.postfixOperatorAllowed() && self.configration.operators.hasPostfixOperator(tokenValueProc) {
            let ident: Optional<OperatorIdentifier> = self.configration.operators.findPostfixOperatorId(tokenValueProc)
            return Token.ofPostfix(position: tokenStartIndex,
                                   value: tokenValueProc,
                                   ident: ident!)
        } else if self.configration.operators.hasInfixOperator(tokenValueProc) {
            let ident: Optional<OperatorIdentifier> = self.configration.operators.findInfixOperatorId(tokenValueProc)
            return Token.ofInfix(position: tokenStartIndex,
                                 value: tokenValueProc,
                                 ident: ident!)

/*        } else if tokenValueProc == "." && self.configration.structuresAllowed {
            return Token.of(position: tokenStartIndex,
                            value: tokenValueProc,
                            type: .separatorStructure)*/

        }
        throw ExpressionError.unknownOperator(start: tokenStartIndex,
                                              end: tokenStartIndex + tokenValueProc.count - 1,
                                              symbol: tokenValueProc)
    }

    /// Parsing of an identifier.
    /// - Returns: parsed token
    /// - Throws:May throw the ``ExpressionError`` in case of parsing errors
    func parseIdentifier() throws (ExpressionError) -> Token {
        let tokenStartIndex: Int = self.currentColumnIndex
        var tokenValue: String = ""
        while self.currentCharCode != ExpressionTokenizer.kCodeEOF
                && ExpressionTokenizer.isAtIdentifier(self.currentChar) {
            tokenValue.append(self.currentChar)
            self.consumeCharacter()
        }
        if self.prefixOperatorAllowed() && self.configration.operators.hasPrefixOperator(tokenValue) {
            let ident: Optional<OperatorIdentifier> = self.configration.operators.findPrefixOperatorId(tokenValue)
            return Token.ofPrefix(position: tokenStartIndex, value: tokenValue, ident: ident!)
        } else if self.postfixOperatorAllowed() && self.configration.operators.hasPostfixOperator(tokenValue) {
            let ident: Optional<OperatorIdentifier> = self.configration.operators.findPostfixOperatorId(tokenValue)
            return Token.ofPostfix(position: tokenStartIndex, value: tokenValue, ident: ident!)
        } else if self.configration.operators.hasInfixOperator(tokenValue) {
            let ident: Optional<OperatorIdentifier> = self.configration.operators.findInfixOperatorId(tokenValue)
            return Token.ofInfix(position: tokenStartIndex, value: tokenValue, ident: ident!)
        }
        self.skipWhitespaces()
        if self.currentChar == ExpressionTokenizer.kBraceOpen {
            let ident: Optional<FunctionIdentifier> = self.configration.functions.findFunction(name: tokenValue)
            if ident.isPresent {
                return Token.of(position: tokenStartIndex, value: tokenValue, ident: ident!)
            }
            throw ExpressionError.unknownFunction(start: tokenStartIndex, end: self.currentColumnIndex, symbol: tokenValue)
        } else {
            return Token.of(position: tokenStartIndex, value: tokenValue, type: .variable)
        }
    }

    /// Parsing of an array opening.
    /// - Returns: parsed token
    /// - Throws:May throw the ``ExpressionError`` in case of parsing errors
    func parseStructureSeparator() throws (ExpressionError) -> Token {
        let token: Token = Token.of(position: self.currentColumnIndex, value: ExpressionTokenizer.kDot, type: .separatorStructure)
        if self.arrayOpenOrStructureSeparatorNotAllowed() {
            throw ExpressionError.unexpectedStructureSeparator(token: token)
        }
        self.consumeCharacter()
        return token
    }

    /// Parsing of an array opening.
    /// - Returns: parsed token
    /// - Throws:May throw the ``ExpressionError`` in case of parsing errors
    func parseArrayOpen() throws (ExpressionError) -> Token {
        let token: Token = Token.of(position: self.currentColumnIndex, value: ExpressionTokenizer.kArrayOpen, type: .arrayOpen)
        if self.arrayOpenOrStructureSeparatorNotAllowed() {
            throw ExpressionError.unexpectedOpenArray(token: token)
        }
        self.consumeCharacter()
        self.arrayBalance += 1
        return token
    }

    /// Parsing of an array opening.
    /// - Returns: parsed token
    /// - Throws:May throw the ``ExpressionError`` in case of parsing errors
    func parseArrayClose() throws (ExpressionError) -> Token {
        let token: Token = Token.of(position: self.currentColumnIndex, value: ExpressionTokenizer.kArrayClose, type: .arrayClose)
        if self.arrayCloseAllowed() == false {
            throw ExpressionError.unexpectedClosingArray(token: token)
        }
        self.consumeCharacter()
        self.arrayBalance -= 1
        if self.arrayBalance < 0 {
            throw ExpressionError.unexpectedClosingArray(token: token)
        }
        return token
    }

    /// Parsing of a comma.
    /// - Returns: parsed token
    /// - Throws:May throw the ``ExpressionError`` in case of parsing errors
    func parseComma() throws (ExpressionError) -> Token {
        let token: Token = Token.of(position: self.currentColumnIndex, value: ExpressionTokenizer.kComma, type: .comma)
        self.consumeCharacter()
        self.braceBalance += 1
        return token
    }

    /// Parsing of a opening brace.
    /// - Returns: parsed token
    /// - Throws:May throw the ``ExpressionError`` in case of parsing errors
    func parseBraceOpen() throws (ExpressionError) -> Token {
        let token: Token = Token.of(position: self.currentColumnIndex, value: ExpressionTokenizer.kBraceOpen, type: .braceOpen)
        self.consumeCharacter()
        self.braceBalance += 1
        return token
    }

    /// Parsing of a clsong brace.
    /// - Returns: parsed token
    /// - Throws:May throw the ``ExpressionError`` in case of parsing errors
    func parseBraceClose() throws (ExpressionError) -> Token {
        let token: Token = Token.of(position: self.currentColumnIndex, value: ExpressionTokenizer.kBraceClose, type: .braceClose)
        self.consumeCharacter()
        self.braceBalance -= 1
        if self.braceBalance < 0 {
            throw ExpressionError.unexpectedClosingBrace(token: token)
        }
        return token
    }

    /// Parsing of a number-literal.
    /// - Returns: parsed token
    /// - Throws:May throw the ``ExpressionError`` in case of parsing errors
    func parseNumber() throws (ExpressionError) -> Token {
        let nextChar = self.peekNextChar()
        if self.currentChar == "0" && (nextChar == "x" || nextChar == "X") {
            return try self.parseHexadecimalNumberLiteral()
        } else {
            return try self.parseDecimalNumberLiteral()
        }
    }

    /// Parsing of a decimal-number-literal.
    /// - Returns: parsed token
    /// - Throws:May throw the ``ExpressionError`` in case of parsing errors
    func parseDecimalNumberLiteral() throws (ExpressionError) -> Token {
        let tokenStartIndex: Int = self.currentColumnIndex
        var tokenValue: String = ""
        var lastChar: Character = " "
        var scientificNotation: Bool = false
        var dotEncountered: Bool = false

        while self.currentCharCode != ExpressionTokenizer.kCodeEOF && self.isAtNumberChar() {
            if self.currentChar == ExpressionTokenizer.kDot && dotEncountered {
                tokenValue.append(self.currentChar)
                throw ExpressionError.numberWithMoreThanOneDecimalPoint(position: tokenStartIndex, symbol: tokenValue)
            }
            if self.currentChar == ExpressionTokenizer.kDot {
                dotEncountered = true
                scientificNotation = true
            }
            if self.currentChar == ExpressionTokenizer.kExponentLower || self.currentChar == ExpressionTokenizer.kExponentUpper {
                scientificNotation = true
            }
            tokenValue.append(self.currentChar)
            lastChar = self.currentChar
            self.consumeCharacter()
        }
        if scientificNotation && (lastChar == ExpressionTokenizer.kExponentUpper
                                  || lastChar == ExpressionTokenizer.kExponentLower
                                  || lastChar == ExpressionTokenizer.kPlus
                                  || lastChar == ExpressionTokenizer.kMinus
                                  || lastChar == ExpressionTokenizer.kDot
        ) {
            throw ExpressionError.illegalNumberFormat(position: tokenStartIndex, symbol: tokenValue)
        }
        return Token.of(position: tokenStartIndex, value: tokenValue, type: .literalNumber)
    }

    /// Parsing of a hexadecimal-number-literal.
    /// - Returns: parsed token
    /// - Throws:May throw the ``ExpressionError`` in case of parsing errors
    func parseHexadecimalNumberLiteral() throws (ExpressionError) -> Token {
        let tokenStartIndex: Int = self.currentColumnIndex
        var tokenValue: String = ""
        // consume leading "0x" of hexadecimal number
        tokenValue.append(self.currentChar)
        self.consumeCharacter()
        repeat {
            tokenValue.append(self.currentChar)
            self.consumeCharacter()
        } while self.currentCharCode != ExpressionTokenizer.kCodeEOF && self.currentChar.isHexDigit
        if tokenValue.count == 2 {
            throw ExpressionError.illegalNumberFormat(position: tokenStartIndex, symbol: tokenValue)
        }
        return Token.of(position: tokenStartIndex, value: tokenValue, type: .literalNumber)
    }

    /// Parsing of a string-literal.
    /// - Returns: parsed token
    /// - Throws:May throw the ``ExpressionError.closingQuoteNotFound`` in case of missing closing quote
    func parseStringLiteral() throws (ExpressionError) -> Token {
        let startChar: Character = self.currentChar
        let tokenStartIndex: Int = self.currentColumnIndex
        var tokenValue: String = ""
        self.consumeCharacter() // skip initial quote
        var inQuote: Bool = true
        while inQuote && self.currentCharCode != ExpressionTokenizer.kCodeEOF {
            if self.currentChar == "\\" {
                self.consumeCharacter()
                tokenValue.append(try ExpressionTokenizer.escapeCharacter(self.currentChar, position: self.currentColumnIndex))
            } else  if self.currentChar == startChar {
                inQuote = false
            } else {
                tokenValue.append(self.currentChar)
            }
            self.consumeCharacter()
        }
        if inQuote {
            throw ExpressionError.closingQuoteNotFound(start: tokenStartIndex, end: self.currentColumnIndex, symbol: tokenValue)
        }
        return Token.of(position: tokenStartIndex, value: tokenValue, type: .literalString)
    }

    // MARK: - API (Token handling)

    /// Check if array or structure cannot be open.
    /// - Returns: true if not allowed
    func arrayOpenOrStructureSeparatorNotAllowed() -> Bool {
        guard let previousToken = self.previousToken() else {
            return true
        }
        switch previousToken.type {
        case .braceClose, .variable, .arrayClose, .literalString:
            return false
        default:
            return true
        }
    }

    /// Check if array-closing is allowed.
    /// - Returns: true if allowed
    func arrayCloseAllowed() -> Bool {
        guard let previousToken = self.previousToken() else {
            return false
        }
        switch previousToken.type {
        case .braceOpen, .operatorInfix, .operatorPrefix, .function, .comma, .arrayOpen:
            return false
        default:
            return true
        }
    }

    /// Check if prefix operator is allowed.
    /// - Returns: true if allowed
    func prefixOperatorAllowed() -> Bool {
        guard let previousToken = self.previousToken() else {
            return true
        }
        switch previousToken.type {
        case .braceOpen, .operatorInfix, .comma, .operatorPrefix:
            return true
        default:
            return false
        }
    }

    /// Check if postfix operator is allowed.
    /// - Returns: true if allowed
    func postfixOperatorAllowed() -> Bool {
        guard let previousToken = self.previousToken() else {
            return false
        }
        switch previousToken.type {
        case .braceClose, .literalNumber, .variable,.literalString:
            return true
        default:
            return false
        }
    }

    /// Check if infix operator is allowed.
    /// - Returns: true if allowed
    func infixOperatorAllowed() -> Bool {
        guard let previousToken = self.previousToken() else {
            return false
        }
        switch previousToken.type {
        case .braceClose, .variable, .literalString, .operatorPostfix, .literalNumber, .arrayClose:
            return true
        default:
            return false
        }
    }

    /// Return last stored token.
    /// - Returns: last stored token if available
    func previousToken() -> Optional<Token> {
        return self.tokens.isEmpty ? Optional.none : Optional(self.tokens.last!)
    }
    
    // MARK: - API (Character handling)

    /// Read and purge whitespaces.
    func skipWhitespaces() {
        if self.currentCharCode == ExpressionTokenizer.kCodeInitial {
            self.consumeCharacter()
        }
        while self.currentCharCode != ExpressionTokenizer.kCodeEOF && self.currentChar.isWhitespace {
            self.consumeCharacter()
        }
    }

    /// Evaluate next charactor from source-expression.
    func consumeCharacter() {
        if self.currentColumnIndex == self.expression.count {
            self.currentCharCode = ExpressionTokenizer.kCodeEOF
        } else {
            self.currentChar = self.expression[self.currentColumnIndex]
            self.currentCharCode = 1
            self.currentColumnIndex += 1
        }
    }
    
    /// Peek next character from source-expression without consuming it.
    /// - Returns: next character if available
    func peekNextChar() -> Optional<Character> {
        return self.currentColumnIndex >= self.expression.count
            ? Optional.none
            : Optional.some(self.expression[self.currentColumnIndex])
    }
    
    /// Peek already consumed previous character.
    /// - Returns: previous character if available
    func peekPreviousChar() -> Optional<Character> {
        return self.currentColumnIndex <= 1
            ? Optional.none
            : Optional.some(self.expression[self.currentColumnIndex - 2])
    }

    // MARK: - API (Character test with context)

    /// Check if current character is start of number.
    /// - Returns: true if start of number
    private func isAtNumberStart() -> Bool {
        if self.currentChar.isNumber {
            return true
        }
        if self.currentChar == "." {
            let peek: Optional<Character> = self.peekNextChar()
            return peek.isPresent && peek!.isNumber
        }
        return false
    }

    /// Check if current character belongs to a number.
    /// - Returns: true if belongs of number
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

    /// Check if next character will be a number character.
    /// - Returns: true if next character will be a number
    private func isNextCharacterNumberChar() -> Bool {
        let peekChar: Optional<Character> = self.peekNextChar()
        if peekChar == Optional.none {
            return false
        }
        self.consumeCharacter()
        let isAtNumber: Bool = self.isAtNumberChar()
        self.currentColumnIndex -= 1
        self.currentChar = self.expression[self.currentColumnIndex - 1]
        return isAtNumber
    }

    // MARK: - API (Character test without context)

    /// Check if given character is beginning of an identifier.
    /// - Parameter ch: character to check
    /// - Returns: true if initial identifier character
    public static func isAtIdentifierStart(_ ch: Character) -> Bool {
        return ch.isLetter || ch == kUnderScore
    }

    /// Check if given character is within an identifier.
    /// - Parameter ch: character to check
    /// - Returns: true
    public static func isAtIdentifier(_ ch: Character) -> Bool {
        return ch.isLetter || ch.isNumber || ch == kUnderScore
    }

    /// Check if given character is start of a string-quote.
    /// - Parameters:
    ///   - ch: character to check
    ///   - allowSingleQuote: if set allow also single-quotes (')
    /// - Returns: true if start of string literal
    public static func isAtStringLiteralStart(_ ch: Character, _ allowSingleQuote: Bool = true) -> Bool {
        return ch == kQuoteDouble || (allowSingleQuote && ch == kQuoteSingle)
    }

    /// Handle character escaping.
    /// - Parameters:
    ///     - ch: character to escape
    ///     - position: position within source-expression
    public static func escapeCharacter(_ ch: Character, position: Int) throws(ExpressionError) -> Character {
        switch ch {
        case "\'": return "\'"
        case "\"": return "\""
        case "\\": return "\\"
        case "n": return "\n"
        case "r": return "\r"
        case "t": return "\t"
        default: throw ExpressionError.unknownEscapeCharacter(position: position, symbol: "\(ch)")
        }
    }

}
