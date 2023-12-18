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
        - [x] unlabelled, unlabelled, ≤1
        - [x] unlabelled, unlabelled, any
        - [x] unlabelled, unlabelled, ≥1
        - [x] unlabelled,   labelled, ≤1
        - [x] unlabelled,   labelled, any
        - [x] unlabelled,   labelled, ≥1
        - [x]   labelled, unlabelled, ≤1
        - [ ]   labelled, unlabelled, any
        - [ ]   labelled, unlabelled, ≥1
        - [ ]   labelled,   labelled, ≤1
        - [ ]   labelled,   labelled, any
        - [ ]   labelled,   labelled, ≥1
        - [ ] improvements
            - [ ] comments
            - [ ] localisations
            - [ ] appendix implementation with ⎕io insensitivity and error handling
    - [ ] catalan numbers
    - [ ] maybe generating functions, but infinite sequences are not so easy to study in apl
    - [ ] exercises - some can be done by paper, but most should require using an interpreter
