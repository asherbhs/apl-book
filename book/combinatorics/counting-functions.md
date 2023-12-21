---
jupytext:
  formats: md:myst
  text_representation:
    extension:        .md
    format_name:      myst
    format_version:   0.13
    jupytext_version: 1.11.5
kernelspec:
  display_name: Dyalog APL
  language:     Dyalog APL
  name:         dyalog_apl
---

# Counting Functions

```{note}
This section assumes you're familiar with the notions of injective, surjective, and bijective functions.
```

- introduce balls and boxes analogy
- recall functions, injective, surjective, bijective
- `n*k` possible functions
- balls in boxes is function ball → box
- combinations are injective functions
- permutations are bijective functions
- next we'll count surjections

# Inclusion-Exclusion and Counting Partitions

- binary inclusion exclusion
    - `≢a∪b ←→ +/≢¨a b (a∩b)`
- n-ary inclusion exclusion and proof
    - `≢⊃∪/as ←→ +/(≢⍤(⊃∩/) × ¯1*¯1+≢)¨ ⊂⍤/∘as⍤1⍉2⊥⍣¯1⍳¯1+2*≢as`
- counting derangements
    - `(!n)-+/((¯1*¯1+⊢)×!∘n×(!n-⊢))⍳n ←→ +/(¯1∘* × !∘n × (!n-⊢))0,⍳n ←→ (!n)×+/(¯1∘*÷!)0,⍳n`
- counting surjections using inclusion-exclusion
    - `k Surj n ←→ +/(!∘n×¯1∘*×k*⍨n-⊢)0,⍳n`
- stirling numbers (of the second kind) - set partitions is unlabelling boxes, so divide by `!n`
    - `k S n ←→ (!n)÷⍨k Surj n`
- stirling triangle and bell numbers

# Stars and Bars

- diagramssss
- unlabelled balls into labelled boxes
    - `'*|**||*|' ←→ '*|**||*|'[7 2 4 1 5 6 3 8]`
- ways to generate
    - combinations of bars from string
    - `k!k+n-1 ←→ (n-1)!k+n-1` ways
- surjective stars and bars
    - first pick k-n, then add n to each one
    - `(k-n)!k-1 ←→ (n-1)!k-1` ways

# Integer Partitions

- unlabelled balls, unlabelled boxes, any or at least 1 per box
- no closed form, but we can still generate
- young diagram
- conjugate partitions - equivalent counts theorem
- self conjugate partitions
    - `7 6 4 4 4 2 2 1`
- self conjugate partitions ←→ distinct odd partitions
- proof using hook numbers in young tableaux

# Twelvefold Teaser

- some combinations of labelling and numbering we haven't tried
- this is the topic of the next section
