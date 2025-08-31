# DataTypes

@Metadata {
    @PageColor(red)
    @PageImage(purpose: icon, source: "function") 
    @SupportedLanguage(swift)
}

Use of simple and complex types.

## Overview

``MMExpressionSolver`` support various native Swift-data types. All types will be wrapped in ``MMExpressionSolver/ExpressionValue``.

### Simple types

``MMExpressionSolver`` supports following primitives types:

- `String`
- `Double`
- `Float`
- `Int`
- `Decimal`
- `Bool`
- `Date`

These types can be used directly in expressions by their textual representation or by using _variables_.

### Complex types

Aside from simple types also _complex_ types are supported:

- `Structs`
- `Classes`
- `Tupels`
- `Arrays`

Like _simple_ types _complex_ types can easily be used as variables.
Use _[]_ to access elements of an array. Array-indicies starts at 1, eg. `list[3]`.
To access properties of an `Struct` or `Class` the dot must be used, eg. `name.property`.
To address anonymous components in a `Tupel` use the name `_0`, `_1` and so on. 

### Predefined constants

Following constants are predefined. They are case-insensitive.

- `pi`, `π`
- `null`, `nil`
- `true`, `false`
- `e`
