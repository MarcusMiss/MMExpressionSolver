[![Swift](https://github.com/MarcusMiss/MMExpressionSolver/actions/workflows/swift.yml/badge.svg)](https://github.com/MarcusMiss/MMExpressionSolver/actions/workflows/swift.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FMarcusMiss%2FMMExpressionSolver%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/MarcusMiss/MMExpressionSolver)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FMarcusMiss%2FMMExpressionSolver%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/MarcusMiss/MMExpressionSolver)

# MMExpressionSolver

A Swift-framework to solve (mathematical) expressions.

- Support of following types: `Int`, `Float`, `Double`, `Decimal`, `String`, `Date` and `Bool`.

- Support of additonal types: `Measurement`.

- Support for _structs_, _classes_ and _tupels_.

- Support for _arrays_.

- Support for _variables_ and _const_-values.

- Out-of the box Operators and Functions for mathematical, logarithmic, trigonometry and string-operations.

- [Docc-documentation](https://marcusmiss.github.io/MMExpressionSolver/documentation/mmexpressionsolver/) is included.

## Integration sample

```
let expression: String = "CSTR(var1)"

// Provide configuration
let config: ExpressionConfiguration = ExpressionConfiguration.createDefault()
let result: Result<MMExpression, ExpressionError> = MMExpression.build(
    expression: expression,
    configuration: config
)

// Provide context
let context: ExpressionEvaluationContextImpl = ExpressionEvaluationContextImpl(configuration: config)
context.variables.storeVariable(identifier: "var1", value: ExpressionValue.of(100))

// Evaluate expression
let evalResult: Result<ExpressionValue, ExpressionError>  = result.valueSuccess!.evaluate(context: context)

let evalValue: ExpressionValue = evalResult.valueSuccess!
print("evalValue: \(evalValue)")

#expect(evalValue.isStringValue)
#expect(evalValue.asString()! == "100")
```
