# Sample: Struct and Tupel

Integration of `Structs` and `Tupels`

## Overview

Demonstration how to navigate through _Structs_ (or _Objects_) and access content of _Tupels_.

### Section header

Assume following structure:

```swift

struct TypeDStruct {
    var d1: Int = 0
    var d2: String = ""
    var d3: (String, Int, String, Bool) = ("", 0, "", false)
}

struct TypeCStruct {
    var c1: Int = 0
    var c2: String = ""
    var c3: TypeDStruct
}

struct TypeBStruct {
    var b1: Int = 0
    var b2: String = ""
    var b3: TypeCStruct
}

struct TypeAStruct {
    var a1: Int = 0
    var a2: String = ""
    var a3: TypeBStruct
}
```

See how to navigate by dot-syntax from top-level-object down to tupel with four components.

```swift
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
let expression: String =
    "UPPER(data.a3.b3.c3.d3._0) + ':' + CSTR(data.a1 + data.a3.b1 + data.a3.b3.c1 + data.a3.b3.c3.d1)"

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
```

