# Some Maths in Dyalog APL

## Notation and Conventions

- `⎕io←1` unless otherwise specified, since most maths starts counting at 1
- `array` `Function` `_monadicOperator` `_dyadicOperator_`
- `←→` means apl expressions are equivalent
- both apl and tmn are used
    - apl for concrete algorithms and doing work
    - tmn for abstract concepts and understanding other literature
- arrays are used liberally as sets with `∪`, `∩`, etc

## TODO

- [x] setup jupyter book
- [x] get working with dyalog kernel
- [ ] enumerative combinatorics
    - [ ] simple counting problems (factorial, binomial, pascal's triangle, multinomial)
    - [ ] inclusion exclusion principle and consequences (derangements, surjections, bell numbers)
    - [ ] stars and bars
    - [ ] twelvefold way
    - [ ] implementation of the whole twelvefold way
        - for each of the twelve
            - count functions
            - result mapping balls -> boxes (if appropriate)
            - result mapping boxes -> balls (if appropriate)
            - implementation in terms of recurrences (reference knuth for imperative implementations)
            - edge cases handled
    - [ ] catalan numbers
    - [ ] generating functions?
    - [ ] multiset partitions?
    - [ ] exercises - some can be done by paper, but most should require using an interpreter
