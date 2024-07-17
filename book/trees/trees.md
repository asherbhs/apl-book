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

# Trees

- depth vector representation
    - what you get out of ⎕xml
    - slow to work with subtrees
- path matrix representation
    - construction from depth vector
    - distances between nodes
    - oh no it's O(nd)
- parent vector representation
    - this is super great
    - basic operations
        - find children:    `⍸p∊i`
        - find leaves:      `p~⍨⍳≢p`
        - find roots:       `I⍣≡⍨p`
            - note forests are possible
        - select sub-trees: `I@{...}⍣≡⍨p`
        - snip:             `i@i⊢p`
    - ordering
        - don't need to maintain dfpt order
        - need to maintain sibling order if it matters for your operation
- relationship to depth vector
    - construction from depth vector
    - finding depths
    - imposing dfpt order
- forests
    - join multiple into a forest
    - split multiple into individual (deforest)
    - exercise: join all trees in a forest under 1 root: `{0,(⍵≠⍳≢⍵)×1+⍵}`
- deletion
- bottom-up acculumation
    - Lisp
        - using key
        - without using key
        - using a fold
    - PP as another example, copy and use me
    - challenges
        - sum each tree in a forest
            - sanity check: sum of trees should equal sum of all values
            - bonus: find `(I⍣≡⍨p)+/⍤⊢⌸v`
        - find height of every node in a tree
- top-down construction
    - Nary
        - challenge: find Mary
    - Collatz
    - Leet as an example
- leetcode problems
    - [invert](https://leetcode.com/problems/invert-binary-tree/)
    - [height balanced](https://leetcode.com/problems/balanced-binary-tree/)
    - [leaf similar](https://leetcode.com/problems/leaf-similar-trees/)
    - [diameter](https://leetcode.com/problems/diameter-of-binary-tree/)
- manipulating json with matrix import ⎕json
    - grouping astronauts example
    - mention that ⎕xml uses a similar format
- small calculator as a larger example
    - point to co-dfns for more
