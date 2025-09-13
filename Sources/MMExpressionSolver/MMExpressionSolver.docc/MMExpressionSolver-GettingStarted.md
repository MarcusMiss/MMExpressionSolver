# GettingStarted

@Metadata {
    @PageColor(red)
    @PageImage(purpose: icon, source: "function") 
    @SupportedLanguage(swift)
    @TechnologyRoot
}

How to use MMExpressionSolver?

## Overview

Use of ``MMExpressionSolver`` is pretty simple.

### Add dependency

Add dependency to your application:

```swift
.package(url: "https://github.com/MarcusMiss/MMExpressionSolver.git", .upToNextMajor(from: "1.2.0"))
```

### Integrate in your code

**Step 1**: Provide expression

```swift
let expression: String = "CSTR(var1)"
```

Formalize your expression in a `String`.

**Step 2**: Create a ``MMExpressionSolver/ExpressionConfiguration``.

```swift
let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
```

In this case a default configuration will be created including all _Operators_ and _Functions_.

**Step 3**: Build the expression.

```swift
let result: Result<MMExpression, ExpressionError> = MMExpression.build(
    expression: expression,
    configuration: config
)
```

The given expression will be transformed into an Abstract Syntax Tree.
An Abstract Syntax Tree (AST) is a tree-structured representation of source code that shows the
syntactic structure of a program according to the grammar of a programming language.
It’s called abstract because it leaves out unnecessary details (like parentheses or commas)
that don’t affect the hierarchical structure of the code, unlike a concrete syntax tree (or parse tree).

**Step 4**: Setup evaluation context

```swift
let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(configuration: config)
context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of(100))
```

The evaluation context is required while evaluating the AST. It contains references to _Operators_ and _Functions_.
Also the storage for variables is managed within the evaluation context.
A variable with name `var1` will be assigned to evaluation context.

> Tip: Default implementation of variable-storage is case-sensitive.

**Step 5**: Evaluate the expression

```swift
let evalResult: Result<ExpressionValue, ExpressionError>  = result.valueSuccess!.evaluate(context: context)
```

The AST will be traversed and evaluated.

#### Complete code

```swift
let expression: String = "CSTR(var1)"
let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
let result: Result<MMExpression, ExpressionError> = MMExpression.build(
    expression: expression,
    configuration: config
)

let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(configuration: config)
context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of(100))

let evalResult: Result<ExpressionValue, ExpressionError>  = result.valueSuccess!.evaluate(context: context)

let evalValue: ExpressionValue = evalResult.valueSuccess!
print("evalValue: \(evalValue)")

#expect(evalValue.isStringValue)
#expect(evalValue.asString()! == "100")
```

After evaluation of an expression it can be reused later use.
For exampel in case of variable-value changes the expression just needs to be evaluated again (Step 4).

The result may contains a evaluated value or a concrete error.
The error of type ``MMExpressionSolver/ExpressionError`` supports the property ``MMExpressionSolver/ExpressionError/errorDescription``.
Currently only as english-localization available.
