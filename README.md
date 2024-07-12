# How to do some things in Dyalog APL

[Read the book here](https://asherbhs.github.io/apl-maths/intro.html)

- `⎕io←1` unless otherwise specified, since most maths starts counting at 1
- `array` `Function` `_monadicOperator` `_dyadicOperator_`
- `←→` means apl expressions are equivalent
- `..` means pattern continues
- both apl and tmn are used
    - apl for concrete algorithms and doing work
    - tmn for abstract concepts and understanding other literature
- arrays are used liberally as sets with `∪`, `∩`, etc
- a custom fork of the dyalog jupyter kernel is used to pass multiline cells directly to a 19.0 (conference edition) interpreter, no `]dinput` business

## handy

```
┌─┬
│
└─┴
```

## TODO

- [ ] enumerative combinatorics
    - [x] implementation of the whole twelvefold way
    - [ ] write
        - [x] outline
        - [ ] enumerative
            - [x] combinations
            - [ ] counting functions
        - [ ] twelvefold
        - [ ] catalan
- [ ] trees
- [ ] graphs
