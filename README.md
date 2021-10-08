# SmoothOperator

Coding Challenge:

Write a command-line program in the language of your choice that will take operations on fractions as an input and produce a fractional result. 

Legal operators shall be *, /, +, - (multiply, divide, add, subtract)

Operands and operators shall be separated by one or more spaces

Mixed numbers will be represented by whole_numerator/denominator. e.g. "3_1/4"

Improper fractions and whole numbers are also allowed as operands 

Example run:

> ? 1/2 * 3_3/4

= 1_7/8

> 2_3/8 + 9/8

= 3_1/2

### Notes

The smooth-operator-app is just there as a reference implementation if wanting to consume smooth-operator-lib. All test cases can be found within the library/sdk project nested under smooth-operator-libTests. 


#### How to evaluate an expression using library?

Import the library 
```
import smooth_operator_lib
```

Example usage

```
let smoothOperatorLibExample = SmoothOperatorCLI()
        
do {
    let result = try smoothOperatorLibExample.evaluateExpression(expression: "1/2 * 3_3/4")
    print("Result of 1/2 * 3_3/4 --> \(result)")
} catch {
    print("Error: \(error)")
}

```



