# RPN Calculator

## Topics

  * arrays
  * arithmetic
  * strings

"RPN" stands for [Reverse Polish Notation](http://en.wikipedia.org/wiki/Reverse_Polish_notation). Briefly, in an RPN world,
instead of using normal "infix" notation, e.g.

```
2 + 2
```

you use "postfix" notation, e.g.

    2 2 +

While this may seem bizarre, there are some advantages to doing
things this way. For one, you never need to use parentheses, since
there is never any ambiguity as to what order to perform operations
in. The rule is, you always go from the back, or the left side.

    1 + 2 * 3 =>
    (1 + 2) * 3 or
    1 + (2 * 3)

    1 2 + 3 * => (1 + 2) * 3
    1 2 3 * + => 1 + (2 * 3)

Another advantage is that you can represent any mathematical formula
using a simple and elegant data structure, called a
[stack](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)).

## Hints

Ruby doesn't have a built-in stack, but the standard Array has all
the methods you need to emulate one (namely, `push` and `pop`, and
optionally `size`).

## References

* <http://en.wikipedia.org/wiki/Reverse_Polish_notation>
* <http://www.calculator.org/rpn.aspx>
