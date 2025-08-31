//
//  Expression.swift
//  MMExpressionSolver
//

import Foundation
import Darwin

/// The ``MMExpression``-object is a container to store data to solve a expression.
/// 
/// ```swift
/// let expr = MMExpression.build(expression: "100 * (4+5)",
///                            configuration: ExpressionConfiguration.createDefault())
/// let context = ...
/// let result = expr.evaluate(context)
/// ```
/// 
/// @Small { Available since <doc:MMExpressionSolver-Release-History#Release-1.0.0>. }
public struct MMExpression: CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: - Factories
    
    /// Description
    /// - Parameters:
    ///   - expression: 'source code' of expression
    ///   - configuration: configuration to use
    /// - Returns: resulting ``MMExpression`` or detected ``ExpressionError``
    public static func build(expression: String,
                             configuration: ExpressionConfiguration) -> Result<MMExpression, ExpressionError> {
        let expr: ExpressionTokenizer = ExpressionTokenizer(
            configuration: configuration,
            expression: expression
        )
        let resultParser: Result<[Token], ExpressionError> = expr.parseExpression()
        switch resultParser {
        case .failure(let error):
            return Result.failure(error)
        case .success(let tokens):
            let builder: ExpressionSyntaxTreeBuilder = ExpressionSyntaxTreeBuilder(
                expression: expression,
                configuration: configuration,
                expressionTokens: tokens
            )
            let resultBuilder: Result<ASTNode, ExpressionError>  = builder.buildSyntaxTree()
            switch resultBuilder {
            case .failure(let error):
                return Result.failure(error)
            case .success(let nodes):
                return Result.success(MMExpression(expression, configuration, nodes))
            }
        }
    }
    
    // MARK: - Properties
    
    /// AST root-node
    let rootNode: Optional<ASTNode>
    /// 'source code' of expression
    let expression: String
    /// configuration for expression
    let configuration: ExpressionConfiguration
    
    // MARK: - Initialization
    
    /// Initialization of this object.
    /// - Parameters:
    ///   - expression: expression-source
    ///   - configuration: configuration
    ///   - rootNode: root-node of AST
    init(_ expression: String,
         _ configuration: ExpressionConfiguration,
         _ rootNode: Optional<ASTNode>
    ) {
        self.expression = expression
        self.configuration = configuration
        self.rootNode = rootNode
    }
    
    // MARK: - API
    
    /// Evaluate expression by processing AST-nodes beginnig by root-node.
    /// - Parameter context: evaluation context
    /// - Returns: evaluated ``ExpressionValue`` value or detected ``ExpressionError``
    public func evaluate(context: any ExpressionEvaluationContext) -> Result<ExpressionValue, ExpressionError> {
        do {
            return try Result.success(evaluateNode(context: context, node: self.rootNode!))
        } catch {
            return Result.failure(error)
        }
    }
    
    /// Evaluate expression by processing AST-nodes beginnig by root-node.
    /// - Parameter context: evaluation context
    /// - Returns: evaluated ``ExpressionValue`` value
    /// - Throws: ``ExpressionError`` in case of errors
    func evaluateRootNode(context: any ExpressionEvaluationContext) throws(ExpressionError) -> ExpressionValue {
        return try evaluateNode(context: context, node: self.rootNode!)
    }
    
    /// Evaluate given AST-node.
    /// - Parameters:
    ///   - context: evaluation context
    ///   - node: current AST-node
    /// - Returns: evaluated ``Value``
    /// - Throws: ``ExpressionError`` in case of errors
    func evaluateNode(context: any ExpressionEvaluationContext, node: ASTNode) throws(ExpressionError) -> ExpressionValue {
        switch node.token.type {
        case .literalNumber:
            return try self.evaluateLiteralNumber(context: context, node: node)
        case .literalString:
            return try self.evaluateLiteralString(context: context, node: node)
        case .variable:
            return try self.evaluateVariableOrConstant(context: context, node: node)
        case .operatorPrefix, .operatorPostfix:
            return try self.evaluateOperatorPrePostFix(context: context, node: node)
        case .operatorInfix:
            return try self.evaluateOperatorInfix(context: context, node: node)
        case .arrayIndex:
            return try self.evaluateArray(context: context, node: node)
        case .separatorStructure:
            return try self.evaluateStructure(context: context, node: node)
        case .function:
            return try self.evaluteFunction(context: context, node: node)
        default:
            throw ExpressionError.unexpectedToken(token: node.token)
        }
    }
    
    /// Evaluate number-literal (eg. 123).
    /// - Parameters:
    ///   - context: evaluation context
    ///   - node: current AST-node
    /// - Returns: evaluated ``Value``
    /// - Throws: ``ExpressionError`` in case of errors
    func evaluateLiteralNumber(context: any ExpressionEvaluationContext, node: ASTNode) throws(ExpressionError) -> ExpressionValue {
        if (node.token.value.isHexadecimal()) {
            return ExpressionValue.of(node.token.value.fromHexadecimal()!)!
        }
        if node.token.value.contains(".") {
            return ExpressionValue.of(node.token.value.toDouble()!)!
        }
        return ExpressionValue.of(node.token.value.toInt()!)!
    }
    
    /// Evaluate string-literal (eg. "Hello").
    /// - Parameters:
    ///   - context: evaluation context
    ///   - node: current AST-node
    /// - Returns: evaluated ``Value``
    /// - Throws: ``ExpressionError`` in case of errors
    func evaluateLiteralString(context: any ExpressionEvaluationContext, node: ASTNode) throws(ExpressionError) -> ExpressionValue {
        return ExpressionValue.of(node.token.value)!
    }
    
    /// Evaluate prefix/postix-operator.
    /// - Parameters:
    ///   - context: evaluation context
    ///   - node: current AST-node
    /// - Returns: evaluated ``Value``
    /// - Throws: ``ExpressionError`` in case of errors
    func evaluateOperatorPrePostFix(context: any ExpressionEvaluationContext, node: ASTNode) throws(ExpressionError) -> ExpressionValue {
        let opFix: Optional<any ExpressionOperator> = self.configuration.operators.findOperator(node.token.operatorId)
        if !opFix.isPresent {
            throw ExpressionError.unknownOperator(start: node.token.position,
                                                  end: node.token.position + node.token.value.count,
                                                  symbol: node.token.value)
        }
        return try opFix!.evaluateOperator(context: context,
                                           operatorToken: node.token,
                                           arguments: [
                                            self.evaluateNode(context: context, node: node.parameters.first!)
                                           ]
        )
    }
    
    /// Evaluate infix-operator.
    /// - Parameters:
    ///   - context: evaluation context
    ///   - node: current AST-node
    /// - Returns: evaluated ``Value``
    /// - Throws: ``ExpressionError`` in case of errors
    func evaluateOperatorInfix(context: any ExpressionEvaluationContext, node: ASTNode) throws(ExpressionError) -> ExpressionValue {
        let opFix: Optional<any ExpressionOperator> = self.configuration.operators.findOperator(node.token.operatorId)
        if !opFix.isPresent {
            throw ExpressionError.unknownOperator(start: node.token.position,
                                                  end: node.token.position + node.token.value.count,
                                                  symbol: node.token.value)
        }
        var left: ExpressionValue
        var right: ExpressionValue
        if opFix!.definition.isLazy {
            left = ExpressionValue.of(node.parameters[0])!
            right = ExpressionValue.of(node.parameters[1])!
            let opResult: ExpressionValue = try opFix!.evaluateOperator(context: context,
                                                                        operatorToken: node.token,
                                                                        arguments: [left, right])
            return opResult
        } else {
            let left: ExpressionValue = try self.evaluateNode(context: context,node: node.parameters[0])
            let right: ExpressionValue = try self.evaluateNode(context: context, node: node.parameters[1])
            let opResult: ExpressionValue = try opFix!.evaluateOperator(context: context,
                                                                        operatorToken: node.token,
                                                                        arguments: [left, right])
            return opResult
        }
    }
    
    /// Evaluate variable (or constant).
    /// - Parameters:
    ///   - context: evaluation context
    ///   - node: current AST-node
    /// - Returns: evaluated ``Value``
    /// - Throws: ``ExpressionError`` in case of errors
    func evaluateVariableOrConstant(context: any ExpressionEvaluationContext, node: ASTNode) throws(ExpressionError) -> ExpressionValue {
        let constant: Optional<ExpressionValue> = try self.evaluateConstant(node.token.value.uppercased())
        if constant.isPresent {
            return constant!
        }
        let variable: Optional<ExpressionValue> = context.variables.getVariable(identifier: node.token.value)
        if variable.isPresent {
            return variable!
        }
        throw ExpressionError.unknownVariableOrConstant(token: node.token)
    }
    
    /// Evaluate constant.
    /// - Parameters:
    ///   - context: evaluation context
    ///   - node: current AST-node
    /// - Returns: evaluated ``Value``
    /// - Throws: ``ExpressionError`` in case of errors
    func evaluateConstant(_ symbol: String) throws(ExpressionError) -> Optional<ExpressionValue> {
        if symbol == "NULL" || symbol == "NIL" {
            return ExpressionValue.ofNil()
        } else if symbol == "PI" || symbol == "π" {
            return ExpressionValue.of(Double.pi)
        } else if symbol == "TRUE" {
            return ExpressionValue.of(true)
        } else if symbol == "FALSE" {
            return ExpressionValue.of(false)
        } else if symbol == "E" {
            return ExpressionValue.of(Darwin.M_E)
        }
        return Optional.none
    }

    /// Evaluate structure (class, struct or tupel).
    /// - Parameters:
    ///   - context: evaluation context
    ///   - node: current AST-node
    /// - Returns: evaluated ``Value``
    /// - Throws: ``ExpressionError`` in case of errors
    func evaluateStructure(context: any ExpressionEvaluationContext, node: ASTNode) throws(ExpressionError) -> ExpressionValue {
        let structure: ExpressionValue = try self.evaluateNode(context: context, node: node.parameters[0])
        let nameToken: Token = node.parameters[1].token
        let name = nameToken.value
        if structure.isStructureValue {
            let structureValue: Optional<ExpressionValue> = structure.getComponent(name)
            if structureValue.isPresent {
                return structureValue!
            } else {
                throw ExpressionError.invalidFieldInStructure(token: node.token, field: name)
            }

        } else if structure.isTupel {
            // Convert _x into .x to match (correct) internal tupel-name.
            let tupelName: String = name.replacingOccurrences(of: "_", with: ".")
            let tupelValue: Optional<ExpressionValue> = structure.getComponent(tupelName)
            if tupelValue.isPresent {
                return tupelValue!
            } else {
                throw ExpressionError.invalidFieldInStructure(token: node.token, field: name)
            }
        }
        throw ExpressionError.invalidTypeInStructure(token: node.token)
    }

    /// Evaluate number-literal (eg. 123).
    /// - Parameters:
    ///   - context: evaluation context
    ///   - node: current AST-node
    /// - Returns: evaluated ``Value``
    /// - Throws: ``ExpressionError`` in case of errors
    func evaluteFunction(context: any ExpressionEvaluationContext, node: ASTNode) throws(ExpressionError) -> ExpressionValue {
        // Check function is known
        var parameterResults: [ExpressionValue] = []
        let exprFunction: Optional<any ExpressionFunction> = context.functions.findFunction(identifier: node.token.functionId)
        if exprFunction.isPresent == false {
            throw ExpressionError.unknownFunction(start: node.token.position,
                                                  end: node.token.position + node.token.value.count,
                                                  symbol: node.token.value)
        }
        // Check arguments
        var withVargs: Bool = false
        for parameterLoop in 0..<exprFunction!.definition.parameters.count {
            if parameterLoop >= node.parameters.count {
                throw ExpressionError.argumentMissing(token: node.token)
            }
            let parameterDef: ExpressionFunctionParameter = exprFunction!.definition.parameters[parameterLoop]
            let parameterNode: ASTNode = node.parameters[parameterLoop]
            if parameterDef.isVarArg {
                // add trailing arguments
                for argLoop in parameterLoop..<node.parameters.count {
                    let varArgValue: ExpressionValue = try self.evaluateNode(context: context, node: node.parameters[argLoop])
                    try validateParameter(parameterDef, varArgValue)
                    parameterResults.append(varArgValue)
                }
                withVargs = true
                break
            } else if parameterDef.isLazy {
                parameterResults.append(ExpressionValue.of(parameterNode)!)
            } else {
                let paramValue: ExpressionValue = try self.evaluateNode(context: context, node: parameterNode)
                try validateParameter(parameterDef, paramValue)
                parameterResults.append(paramValue)
            }
        }
        if withVargs {
            if parameterResults.count < exprFunction!.definition.parameters.count {
                throw ExpressionError.argumentCountNotMatching(token: node.token)
            }
        } else {
            if node.parameters.count > parameterResults.count {
                throw ExpressionError.argumentCountNotMatching(token: node.token)
            }
            if parameterResults.count != exprFunction!.definition.parameters.count {
                throw ExpressionError.argumentCountNotMatching(token: node.token)
            }
        }
        return try exprFunction!.evaluateFunction(expression: self,
                                                  context: context,
                                                  functionToken: node.token,
                                                  arguments: parameterResults)
    }

    func validateParameter(_ parameterDef: ExpressionFunctionParameter, _ paramValue: ExpressionValue) throws(ExpressionError) {
        if paramValue.isNullValue && parameterDef.allowNull == false {
            throw ExpressionError.nillNotAllowed(paramName: parameterDef.name)
        }
        if parameterDef.strictTypes.isEmpty == false {
            if !parameterDef.strictTypes.contains(paramValue.type) {
                throw ExpressionError.invalidParameter(paramName: parameterDef.name,
                                                       recType: paramValue.type,
                                                       expType: paramValue.type,
                                                       value: paramValue.asStringForError())
            }
        }
    }

    /// Evaluate array.
    /// - Parameters:
    ///   - context: evaluation context
    ///   - node: current AST-node
    /// - Returns: evaluated ``Value``
    /// - Throws: ``ExpressionError`` in case of errors
    func evaluateArray(context: any ExpressionEvaluationContext, node: ASTNode) throws(ExpressionError) -> ExpressionValue {
        let arrayValue: ExpressionValue = try self.evaluateNode(context: context, node: node.parameters[0])
        let indexValue: ExpressionValue = try self.evaluateNode(context: context, node: node.parameters[1])
        let index: Optional<Int> = indexValue.asConvertedIntegerNumber()
        if index.isPresent == false {
            throw ExpressionError.invalidIndex(token: node.token)
        }
        if index! < 1 || index! > arrayValue.asArray()!.count {
            throw ExpressionError.invalidIndex(token: node.token)
        }
        return ExpressionValue.of(arrayValue.asArray()![index! - 1] as Any)!
    }

    // MARK: - Protocol CustomStringConvertible

    public var description: String {
        return "expression: '\(expression)'"
    }

    // MARK: - Protocol CustomDebugStringConvertible

    public var debugDescription: String {
        return "MMExpression(expression: '\(expression)')"
    }

}
