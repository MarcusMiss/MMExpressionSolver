//
//  MMExpressionTests.swift
//  MMExpressionSolver
//

import Foundation
import Testing
@testable import MMExpressionSolver

@Suite("MMExpression", .serialized)
class MMExpressionTests {
    
    class EmptyContext: ExpressionEvaluationContext {
        var variables: any ExpressionVariableStorage = ExpressionVariableStorageImpl()
        var functions: any ExpressionFunctionRepository = ExpressionFunctionRepositoryImpl([])
        var operators: any ExpressionOperatorRepository = ExpressionOperatorRepositoryImpl([])
    }
    
    @Test("Invalid expression build",
          arguments: [
            "",
            "     ",
            "()",
            ".",
            "[10]",
            "[]",
            "[",
            "]",
          ]
    )
    func invalidExpressionBuilds(source: String) async throws {
        let expr: Result<MMExpression, ExpressionError> = MMExpression.build(expression: source,
                                                                             configuration: ExpressionConfiguration.createDefault())
        print("\(expr)")
        try #require(expr.isFailure)
    }
    
    @Test("Valid expression build",
          arguments: [
            "\"hello\"",
            "100 + 200",
            "100 * (15 + 25)",
            "ABS(100)",
            "-5.5 / +1.1",
            "theArray[1] + var1",
            "-var2 - var1",
            "10 * 20 + theArray[1+1] + 200",
            "10 * 20 * (30 + (40 * 50))",
          ]
    )
    func validExpressionBuilds(source: String) async throws {
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault();
        let evaluationContext: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: config.functions,
            operators: config.operators
        )
        let struct1: FooStruct = FooStruct(attribute1: "Lorem", attribute2: 1234)
        let class1: FooClazz = FooClazz(attribute1: "Ipsum", attribute2: 4321)
        
        evaluationContext.variables.storeVariable(identifier: "var1", value: ExpressionValue.of(100))
        evaluationContext.variables.storeVariable(identifier: "var2", value: ExpressionValue.of(200))
        evaluationContext.variables.storeVariable(identifier: "theArray", value: ExpressionValue.of([100, 200, 300]))
        evaluationContext.variables.storeVariable(identifier: "struct1", value: ExpressionValue.of(struct1)!)
        evaluationContext.variables.storeVariable(identifier: "class1", value: ExpressionValue.of(class1)!)
        
        let expr: Result<MMExpression, ExpressionError> = MMExpression.build(expression: source,
                                                                             configuration: config)
        print("\(expr)")
        
        try #require(expr.isSuccess)
        _ = expr.map {
            let evalResult: Result<ExpressionValue, ExpressionError> = $0.evaluate(context: EmptyContext())
            print("evalResult = \(evalResult)")
            return evalResult
        }
        #expect(try expr.get().description.contains(source) == true)
        #expect(try expr.get().debugDescription.contains(source) == true)
    }
    
    @Test("Validate evaluateLiteralString")
    func evaluateLiteralString() async throws {
        let root: ASTNode = ASTNode(Token.of(position: 1, value: "\"Hello\"", type: .literalString))
        let expr: MMExpression = MMExpression.init("",
                                                   ExpressionConfiguration.createDefault(),
                                                   root)
        let result: ExpressionValue = try expr.evaluateLiteralString(context: EmptyContext(), node: root)
        print("result=\(result)")
        #expect(result.isStringValue)
        #expect("\"Hello\"" == result.asString())
    }
    
    @Test("Validate evaluateLiteralNumber")
    func evaluateLiteralNumber() async throws {
        let root: ASTNode = ASTNode(Token.of(position: 1, value: "100", type: .literalNumber))
        let expr: MMExpression = MMExpression.init("",
                                                   ExpressionConfiguration.createDefault(),
                                                   root)
        let result: ExpressionValue = try expr.evaluateLiteralNumber(context: EmptyContext(), node: root)
        print("result=\(result)")
        #expect(result.isIntegerValue)
        #expect(100 == result.asInteger())
    }
    
    @Test("Validate evaluateLiteralNumber (2)")
    func evaluateLiteralNumber2() async throws {
        let root: ASTNode = ASTNode(Token.of(position: 1, value: "0xFFFF", type: .literalNumber))
        let expr: MMExpression = MMExpression.init("",
                                                   ExpressionConfiguration.createDefault(),
                                                   root)
        let result: ExpressionValue = try expr.evaluateLiteralNumber(context: EmptyContext(), node: root)
        print("result=\(result)")
        #expect(Decimal(65535) == result.asDecimal())
    }
    
    @Test("Validate evaluateVariableOrConstant")
    func evaluateVariableOrConstant() async throws {
        let ctxt: ExpressionEvaluationContext = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
            
        )
        ctxt.variables.storeVariable(identifier: "var1", value: ExpressionValue.of("Hello"))
        let root: ASTNode = ASTNode(Token.of(position: 1, value: "var1", type: .variable))
        let expr: MMExpression = MMExpression.init("",
                                                   ExpressionConfiguration.createDefault(),
                                                   root)
        let result: ExpressionValue = try expr.evaluateVariableOrConstant(context: ctxt, node: root)
        print("result=\(result)")
        #expect(result.isStringValue)
        #expect("Hello" == result.asString())
    }
    
    @Test("Validate evaluateVariableOrConstant (2)")
    func evaluateVariableOrConstant2() async throws {
        let ctxt: ExpressionEvaluationContext = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
            
        )
        let root: ASTNode = ASTNode(Token.of(position: 1, value: "var1", type: .variable))
        let expr: MMExpression = MMExpression.init("",
                                                   ExpressionConfiguration.createDefault(),
                                                   root)
        let error: ExpressionError? = #expect(throws: ExpressionError.self) {
            try expr.evaluateVariableOrConstant(context: ctxt, node: root)
        }
        print("error=\(String(describing: error))")
    }
    
    @Test("Function ABS")
    func evaluteFunctionValidFunction() async throws {
        let ctxt: ExpressionEvaluationContext = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([
                FunctionABS()
            ]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let root: ASTNode = ASTNode(Token.of(position: 1, value: "var1", ident: FunctionIdentifier("FunctionABS")),
                                    parameters: [ASTNode(Token.of(position: 1, value: "-100", type: .literalNumber))]
        )
        let expr: MMExpression = MMExpression.init("",
                                                   ExpressionConfiguration.createDefault(),
                                                   root)
        let result: ExpressionValue = try expr.evaluteFunction(context: ctxt, node: root)
        #expect(result.asInteger() == 100)
    }
    
    @Test("Function ABS with missing registration")
    func evaluteFunctionWithMissingFunction() async throws {
        let ctxt: ExpressionEvaluationContext = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let root: ASTNode = ASTNode(Token.of(position: 1, value: "var1", ident: FunctionIdentifier("FunctionABS")),
                                    parameters: [ASTNode(Token.of(position: 1, value: "100", type: .literalNumber))]
        )
        let expr: MMExpression = MMExpression.init("",
                                                   ExpressionConfiguration.createDefault(),
                                                   root)
        let error: ExpressionError? = #expect(throws: ExpressionError.self) {
            try expr.evaluteFunction(context: ctxt, node: root)
        }
        print("\(String(describing: error))")
    }

    @Test("Array evaluation")
    func evaluteArray() async throws {
        let ctxt: ExpressionEvaluationContext = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        ctxt.variables.storeVariable(identifier: "index", value: ExpressionValue.of(1))
        ctxt.variables.storeVariable(identifier: "var1", value: ExpressionValue.of(["1", "2", "3"]))
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: "var1[index]",
            configuration: ExpressionConfiguration.createDefault()
        )
        print("\(String(describing: result))")
        try #require(result.isSuccess)
        let expr: MMExpression = try result.get()
        // Check access to index 1 (1-based, not zero-based)
        try #require(try expr.evaluate(context: ctxt).get() == ExpressionValue.of("1"))
        // Check access to index 3
        ctxt.variables.storeVariable(identifier: "index", value: ExpressionValue.of(3))
        try #require(try expr.evaluate(context: ctxt).get() == ExpressionValue.of("3"))
        // Check access to index 2
        ctxt.variables.storeVariable(identifier: "index", value: ExpressionValue.of(2))
        try #require(try expr.evaluate(context: ctxt).get() == ExpressionValue.of("2"))
        // Now test index-violation (with invalid type)
        ctxt.variables.storeVariable(identifier: "index", value: ExpressionValue.of("murks"))
        let error1: ExpressionError? = #expect(throws: ExpressionError.self) {
            try expr.evaluate(context: ctxt).get()
        }
        print("\(String(describing: error1))")
        // Now test index-violation (index 0)
        ctxt.variables.storeVariable(identifier: "index", value: ExpressionValue.of(0))
        let error2: ExpressionError? = #expect(throws: ExpressionError.self) {
            try expr.evaluate(context: ctxt).get()
        }
        print("\(String(describing: error2))")
        // Now test index-violation (index 10)
        ctxt.variables.storeVariable(identifier: "index", value: ExpressionValue.of(10))
        let error3: ExpressionError? = #expect(throws: ExpressionError.self) {
            try expr.evaluate(context: ctxt).get()
        }
        print("\(String(describing: error3))")
    }

    @Test("Structure evaluation",
      arguments: [
        "base.a1",
        "base.a2",
        "base.a3.b1",
        "base.a3.b2",
        "base.a3.b3.c1",
        "base.a3.b3.c2",
        "base.a3.b3.c3.d1",
        "base.a3.b3.c3.d2",
        "base.a3.b3.c3.d3._0",
        "base.a3.b3.c3.d3._1",
        "base.a3.b3.c3.d3._2",
        "base.a3.b3.c3.d3._3",
      ]
    )
    func evaluteStructure(source: String) async throws {
        let ctxt: ExpressionEvaluationContext = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let base: TypeAStruct = TypeAStruct(
            a1: 1,
            a2: "a",
            a3: TypeBStruct(
                b1: 2,
                b2: "b",
                b3: TypeCStruct(
                    c1: 3,
                    c2: "c",
                    c3: TypeDStruct(
                        d1: 4,
                        d2: "d",
                        d3: ("hello", 10, "Lorem", true)
                    )
                )
            )
        )
        ctxt.variables.storeVariable(identifier: "base", value: ExpressionValue.of(base)!)
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: source,
            configuration: ExpressionConfiguration.createDefault()
        )
        try #require(result.isSuccess)
        let expr: MMExpression = try result.get()
        let evalResult: ExpressionValue = try expr.evaluate(context: ctxt).get()
        print("\(source): \(String(describing: evalResult))")
    }

    @Test("Structure evaluation with failures",
      arguments: [
        "base.a4",
        "base.a3.b3.c4",
        "base.a3.b3.c3.d3._4",
      ]
    )
    func evaluteStructure2(source: String) async throws {
        let ctxt: ExpressionEvaluationContext = ExpressionEvaluationContextImpl(
            variables: ExpressionVariableStorageImpl(),
            functions: ExpressionFunctionRepositoryImpl([]),
            operators: ExpressionOperatorRepositoryImpl([])
        )
        let base: TypeAStruct = TypeAStruct(
            a1: 1,
            a2: "a",
            a3: TypeBStruct(
                b1: 2,
                b2: "b",
                b3: TypeCStruct(
                    c1: 3,
                    c2: "c",
                    c3: TypeDStruct(
                        d1: 4,
                        d2: "d",
                        d3: ("hello", 10, "Lorem", true)
                    )
                )
            )
        )
        ctxt.variables.storeVariable(identifier: "base", value: ExpressionValue.of(base)!)
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: source,
            configuration: ExpressionConfiguration.createDefault()
        )
        try #require(result.isSuccess)
        let expr: MMExpression = try result.get()
        let error: ExpressionError? = #expect(throws: ExpressionError.self) {
            try expr.evaluate(context: ctxt).get()
        }
        print("\(String(describing: error))")
    }

    @Test("Validate 'true and true'")
    func validateBoolean() async throws {
        let expression: String = "true and true"
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(configuration: config)
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expression,
            configuration: config
        )
        try #require(result.isSuccess)
        let evalResult: Result<ExpressionValue, ExpressionError>  = result.valueSuccess!.evaluate(context: context)
        try #require(evalResult.isSuccess)
        let evalValue: ExpressionValue = evalResult.valueSuccess!
        print("evalValue: \(evalValue)")
        #expect(evalValue.isBooleanValue)
        #expect(evalValue.asBoolean()! == true)
    }

    @Test("Validate 'true and false")
    func validateBoolean2() async throws {
        let expression: String = "true and false"
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(configuration: config)
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expression,
            configuration: config
        )
        try #require(result.isSuccess)
        let evalResult: Result<ExpressionValue, ExpressionError>  = result.valueSuccess!.evaluate(context: context)
        try #require(evalResult.isSuccess)
        let evalValue: ExpressionValue = evalResult.valueSuccess!
        print("evalValue: \(evalValue)")
        #expect(evalValue.isBooleanValue)
        #expect(evalValue.asBoolean()! == false)
    }

    @Test("Validate 'true xor false")
    func validateBoolean23() async throws {
        let expression: String = "true xor false"
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(configuration: config)
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expression,
            configuration: config
        )
        try #require(result.isSuccess)
        let evalResult: Result<ExpressionValue, ExpressionError>  = result.valueSuccess!.evaluate(context: context)
        try #require(evalResult.isSuccess)
        let evalValue: ExpressionValue = evalResult.valueSuccess!
        print("evalValue: \(evalValue)")
        #expect(evalValue.isBooleanValue)
        #expect(evalValue.asBoolean()! == true)
    }

    @Test("Validate from documentation")
    func validateFromDocumentation() async throws {
        let expression: String = "\"Hello World: \" + CSTR(1000 + 50 * 20 + 25)"
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(configuration: config)
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expression,
            configuration: config
        )
        try #require(result.isSuccess)
        let evalResult: Result<ExpressionValue, ExpressionError>  = result.valueSuccess!.evaluate(context: context)
        try #require(evalResult.isSuccess)
        let evalValue: ExpressionValue = evalResult.valueSuccess!
        print("evalValue: \(evalValue)")
        #expect(evalValue.isStringValue)
        #expect(evalValue.asString()! == "Hello World: 2025")
    }

    @Test("Validate from documentation")
    func validateFromDocumentation2() async throws {
        let data: TypeAStruct = TypeAStruct(
            a1: 1000,
            a2: "LevelA",
            a3: TypeBStruct(
                b1: 2000,
                b2: "LevelB",
                b3: TypeCStruct(
                    c1: 3000,
                    c2: "LevelC",
                    c3: TypeDStruct(
                        d1: 4000,
                        d2: "LevelD",
                        d3: ("Tupel", 0, "", false)
                    )
                )
            )
        )
        let expression: String = "UPPER(data.a3.b3.c3.d3._0) + ':' + CSTR(data.a1 + data.a3.b1 + data.a3.b3.c1 + data.a3.b3.c3.d1)"
        let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
        let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(configuration: config)
        let result: Result<MMExpression, ExpressionError> = MMExpression.build(
            expression: expression,
            configuration: config
        )
        try #require(result.isSuccess)
        context.variables.storeVariable(identifier: "data", value: ExpressionValue.of(data)!)
        let evalResult: Result<ExpressionValue, ExpressionError>  = result.valueSuccess!.evaluate(context: context)
        try #require(evalResult.isSuccess)
        let evalValue: ExpressionValue = evalResult.valueSuccess!
        print("evalValue: \(evalValue)")
        #expect(evalValue.isStringValue)
        #expect(evalValue.asString()! == "TUPEL:10000")
    }

}
