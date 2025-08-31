//
//  ExpressionSyntaxTreeBuilder.swift
//  MMExpressionSolver
//

import Foundation

/// Abstract-Syntax-Tree-Builder based on Shunting-Yard-algorithmen.
///
/// This class converts a list of ``Token`` into an Abstract-Syntax-Tree (as ``ASTNode``).
///
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public class ExpressionSyntaxTreeBuilder {

    // MARK: - Properties

    /// expression source
    private var expression: String
    /// parsed tokens
    private var expressionTokens: [Token]
    /// configuration
    private var configuration: ExpressionConfiguration
    /// stack of operators
    private var operatorStack: Array<Token> = []
    /// stack of operands
    private var operandStack: Array<ASTNode> = []

    // MARK: - Initialization

    /// Initialization of this object.
    /// - Parameters:
    ///   - expression: source expression
    ///   - configuration: configuration
    ///   - expressionTokens: parsed tokens
    public init(expression: String,
                configuration: ExpressionConfiguration,
                expressionTokens: [Token]
    ) {
        self.expression = expression
        self.expressionTokens = expressionTokens
        self.configuration = configuration
    }

    // MARK: - API

    /// Build syntax-tree.
    ///
    /// The complete expression will be tokenized and arranged in an _Abstract-Syntax-Tree_.
    /// This tree can be evaluate once or multiple times (in case variables might be used).
    ///
    /// - Returns: created root-node of tree or error
    public func buildSyntaxTree() -> Result<ASTNode, ExpressionError> {
        do {
            return .success(try self.toAbstractSyntaxTree()!)
        } catch let error {
            return .failure(error)
        }
    }

    /// Internal method to build syntax tree.
    ///
    /// - Returns: root-node of syntax-tree
    /// - Throws: May throw the ``ExpressionError`` in case of errors
    func toAbstractSyntaxTree() throws(ExpressionError) -> Optional<ASTNode> {
        var previousToken: Optional<Token> = Optional.none
        for token in self.expressionTokens {
            switch token.type {
            case .variable, .literalNumber, .literalString:
                self.operandStack.append(ASTNode(token))
            case .function:
                self.operatorStack.append(token)
            case .comma:
                try self.processOperatorsFromStackUntilTokenType(.braceOpen)
            case .operatorInfix, .operatorPrefix, .operatorPostfix:
                try self.processOperator(token)
            case .braceOpen:
                try self.processBraceOpen(previousToken, token)
            case .braceClose:
                try self.processBraceClose()
            case .arrayOpen:
                try self.processArrayOpen(token)
            case .arrayClose:
                try self.processArrayClose(token)
            case .separatorStructure:
                try self.processStructureSeparator(token)
            default:
                throw ExpressionError.unexpectedToken(token: token)
            }
            previousToken = token
        }
        while !self.operatorStack.isEmpty {
            let token: Optional<Token> = self.operatorStack.popLast()
            try self.createOperatorNode(token!)
        }
        if self.operandStack.isEmpty {
            throw ExpressionError.emptyExpression(source: self.expression)
        }
        if self.operandStack.count > 1 {
            throw ExpressionError.tooManyOperands(source: self.expression)
        }
        return self.operandStack.popLast()
    }

    /// Validation of function parameters
    /// - Parameters
    ///     - functionToken: token representing function-call
    ///     - parameters: nodes as arguments for function-call
    /// - Throws: May throw the ``ExpressionError`` in case of errors
    func validateFunctionParameters(_ functionToken: Token, parameters: [ASTNode]) throws(ExpressionError) {
        let funcDef: Optional<any ExpressionFunction> = self.configuration.functions.findFunction(identifier: functionToken.functionId)
        if funcDef.isPresent == false {
            throw ExpressionError.unknownFunction(start: functionToken.position,
                                                  end: functionToken.position + functionToken.value.count,
                                                  symbol: functionToken.value)
        }
        if parameters.count < funcDef!.definition.parameters.count {
            throw ExpressionError.argumentCountNotMatching(token: functionToken)
        }
        if !funcDef!.definition.hasVarsArgs && parameters.count > funcDef!.definition.parameters.count {
            throw ExpressionError.argumentCountNotMatching(token: functionToken)
        }
    }

    /// Find operator in Operator-repository for given token.
    /// - Parameter token: related token
    /// - Returns: Identifier of operator when found
    func lookupOperatorDefinition(_ token: Optional<Token>) -> Optional<ExpressionOperatorDefinition> {
        if token.isPresent == false {
            return Optional.none
        }
        let lookResult: Optional<any ExpressionOperator> = self.configuration.operators.findOperator(token!.operatorId)
        if lookResult.isPresent {
            return Optional.some(lookResult!.definition)
        }
        return Optional.none
    }

    /// Process operator.
    /// - Parameter token: related token
    /// - Throws: May throw the ``ExpressionError`` in case of errors
    func processOperator(_ currentToken: Token) throws(ExpressionError) {
        var nextToken: Optional<Token> = self.operatorStack.isEmpty ? Optional.none : self.operatorStack.last
        let currentOperatorDefinition: Optional<ExpressionOperatorDefinition> =
            nextToken.isPresent ? lookupOperatorDefinition(currentToken) : Optional.none
        var nextOperatorDefinition: Optional<ExpressionOperatorDefinition> = lookupOperatorDefinition(nextToken)

        while self.isOperator(nextToken)
                && self.isNextOperatorOfHigherPrecedence(currentOperatorDefinition!, nextOperatorDefinition) {
            let token: Optional<Token> = self.operatorStack.popLast()
            try self.createOperatorNode(token!)
            nextToken = self.operatorStack.isEmpty ? Optional.none : self.operatorStack.last
            nextOperatorDefinition = lookupOperatorDefinition(nextToken)
        }
        self.operatorStack.append(currentToken)
    }

    /// Process structure-separater.
    /// - Parameter token: related token
    /// - Throws: May throw the ``ExpressionError`` in case of errors
    func processStructureSeparator(_ currentToken: Token) throws(ExpressionError) {
        var nextToken: Optional<Token> = self.operatorStack.isEmpty ? Optional.none : self.operatorStack.last
        while nextToken != Optional.none && nextToken?.type == .separatorStructure {
            let token: Optional<Token> = self.operatorStack.popLast()
            try self.createOperatorNode(token!)
            nextToken = self.operatorStack.last
        }
        self.operatorStack.append(currentToken)
    }

    /// Process brace-open-token.
    /// If previous token was of type ``TokenType.function`` a special node will be added to indicate
    /// function-call.
    /// - Parameters:
    ///     - previousToken: previous token
    ///     - token: related token
    /// - Throws:May throw the ``ExpressionError`` in case of errors
    func processBraceOpen(_ previousToken: Optional<Token>, _ currentToken: Token) throws(ExpressionError) {
        if previousToken.isPresent && previousToken!.type == .function {
            // start of parameter list
            self.operandStack.append(ASTNode(Token.of(position: currentToken.position,
                                                      value: currentToken.value,
                                                      type: .functionParamStart)
            ))
        }
        self.operatorStack.append(currentToken)
    }

    /// Process brace-close-token.
    /// - Throws: May throw the ``ExpressionError`` in case of errors
    func processBraceClose() throws(ExpressionError) {
        try self.processOperatorsFromStackUntilTokenType(.braceOpen)
        self.operatorStack.removeLast() // throw away marker
        if !self.operatorStack.isEmpty && self.operatorStack.last!.type == .function {
            let functionToken: Token = self.operatorStack.popLast()!
            var parameters: [ASTNode] = []
            while true {
                // add all parameters in reverse order from stack
                let node: ASTNode = self.operandStack.popLast()!
                if node.token.type == .functionParamStart {
                    break
                }
                parameters.insert(node, at: 0)
            }
            try self.validateFunctionParameters(functionToken, parameters: parameters)
            self.operandStack.append(ASTNode(functionToken, parameters: parameters))
        }
    }

    /// Process array-open-token.
    /// - Parameter token: related token
    /// - Throws: May throw the ``ExpressionError`` in case of errors
    func processArrayOpen(_ currentToken: Token) throws(ExpressionError) {
        var nextToken: Optional<Token> = self.operatorStack.isEmpty ? Optional.none : self.operatorStack.last
        while nextToken.isPresent && nextToken!.type == .separatorStructure {
            let token: Optional<Token> = self.operatorStack.popLast()
            try self.createOperatorNode(token!)
            nextToken = self.operatorStack.isEmpty ? Optional.none : self.operatorStack.last
        }
        // create ARRAY-index operator
        let arrayIndex: Token = Token.of(position: currentToken.position,
                                         value: currentToken.value,
                                         type: .arrayIndex)
        self.operatorStack.append(arrayIndex)
        self.operatorStack.append(currentToken)
    }

    /// Process array-close-token.
    /// - Parameter token: related token
    /// - Throws: May throw the ``ExpressionError`` in case of errors
    func processArrayClose(_ token: Token) throws(ExpressionError) {
        try self.processOperatorsFromStackUntilTokenType(.arrayOpen)
        _ = self.operatorStack.popLast() // throw away marker (array open)
        let arrayToken: Optional<Token> = self.operatorStack.popLast()
        if arrayToken.isPresent == false {
            throw ExpressionError.internalError(error: "processArrayClose(\(token)): #1 arrayToken is unexpectedly null")
        }
        var operands: [ASTNode] = []
        // second parameter of array_index is the index
        let index: Optional<ASTNode> = self.operandStack.popLast()
        if index.isPresent == false {
            throw ExpressionError.internalError(error: "processArrayClose(\(token)): #2 arrayIndex is unexpectly null")
        }
        operands.insert(index!, at: 0)
        // first parameter of array_index is the array
        let array: Optional<ASTNode> = self.operandStack.popLast()
        if array.isPresent == false {
            throw ExpressionError.useOfArrayWithoutVariable(token: token)
        }
        operands.insert(array!, at: 0)
        self.operandStack.append(ASTNode(arrayToken!, parameters: operands))
    }

    /// Pop all tokens from operator-stack and add them as ``ASTNode`` on operand-stack until specified
    /// token-type is reached.
    /// - Parameter untilTokenTpen: related token-type
    /// - Throws: May throw the ``ExpressionError`` in case of errors
    func processOperatorsFromStackUntilTokenType(_ untilTokenTpen: TokenType) throws(ExpressionError) {
        while !self.operatorStack.isEmpty && self.operatorStack.last!.type != untilTokenTpen {
            let token: Optional<Token> = self.operatorStack.popLast()
            try self.createOperatorNode(token!)
        }
    }

    /// Create new ``ASTNode`` for current token and add to operand-stack.
    /// - Parameter token: related token
    /// - Throws: May throw the ``ExpressionError`` in case of errors
    func createOperatorNode(_ token: Token) throws(ExpressionError) {
        if self.operandStack.isEmpty {
            throw ExpressionError.missingOperandForOperator(token: token)
        }
        let operand1: Optional<ASTNode> = self.operandStack.popLast()
        if token.type == .operatorPrefix || token.type == .operatorPostfix {
            self.operandStack.append(ASTNode(token, parameters: [operand1!]))
        } else {
            if operandStack.isEmpty {
                throw ExpressionError.missingSecondOperandForOperator(token: token)
            }
            let operand2: Optional<ASTNode> = self.operandStack.popLast()
            self.operandStack.append(ASTNode(token, parameters: [operand2!, operand1!]))
        }
    }

    /// Check for highed precedende of next operator.
    /// - Parameters:
    ///   - currentOperator: the current operator
    ///   - nextOperator: the next operator
    /// - Returns: true if next operator has higher precende
    func isNextOperatorOfHigherPrecedence(_ currentOperator: ExpressionOperatorDefinition,
                                          _ nextOperator: Optional<ExpressionOperatorDefinition>
    ) -> Bool {
        if !nextOperator.isPresent {
            return true
        }
        if currentOperator.isLeftAssociative {
            return currentOperator.precedence.rawValue <= nextOperator!.precedence.rawValue
        } else {
            return currentOperator.precedence.rawValue < nextOperator!.precedence.rawValue
        }
    }

    /// Check of current token is an operator
    /// - Parameter token: token to check
    /// - Returns: true if token ios an operator
    func isOperator(_ token: Optional<Token>) -> Bool {
        if !token.isPresent {
            return false
        }
        return self.isOperator(token!.type)
    }

    /// Check of current token-type is an operator
    /// - Parameter type: token-type to check
    /// - Returns: true if token ios an operator
    func isOperator(_ type: TokenType) -> Bool {
        return [.operatorInfix,
                .operatorPrefix,
                .operatorPostfix,
                .separatorStructure].contains(type)
    }

}
