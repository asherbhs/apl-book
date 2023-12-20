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

# Enumerative Combinatorics

```{code-cell}
⎕IO←1
]box on -style=max
```

## How to Count

Enumerative Combinatorics is, in essence, the study of counting. Of course, we all (hopefully) know how to count, but in this chapter we'll be using much more insightful techniques than you were taught as a child.

Let's start with a simple example. Say we have a group of people - Alice, Bob, and Charlie - and we ask them to pick their favourite from a group of colours - red, green, blue, and yellow. How many different ways can our hypothetical gang pick these colours? Well, Alice has $4$ choices, as do Bob and Charlie, so there are a total of `4×4×4 ←→ 4*3 ←→ 64` possibilities. This holds in general. Say we have `k` people and `n` colours, there are `n*k` ways for them to pick their favourite colours.

Consider another problem: we have a bookshelf nicely filled with $5$ books. How many ways are there to arrange our shelf? If we took all our books off the shelf and put them back on, one by one, we would have $5$ books to put the first place, then $4$ books to put the second, and so on. This means there are `5×4×3×2×1 ←→ 120` ways to rearrange the books. Such a rearrangement of items is called a *permutation*, so we can say that there are $120$ different permutations of $5$ books. For example, if our set of books is `'The Little Prince' 'Elements' 'Cosmos' 'A Programming Language' 'The Hobbit'`, a permutation of the books might be `'A Programming Language' 'Cosmos' 'Elements' 'The Hobbit' 'The Little Prince'`.

Our calculation to count the permutations nicely generalises - if we have $k$ books, then there are `k×(k-1)×(k-2)×...×2×1 ←→ ×/⍳k` permutations of them. In combinatorics, this quantity is used all the time, so it gets its own name: the *factorial*. APL has factorial built in as monadic `!`:

```{code-cell}
5×4×3×2×1
×/⍳5
!5
```

`!0` is defined as $1$, since that's the result of an empty product. We can also imagine the case of rearranging a bookshelf with no books on it. There's exactly one way to do this: doing nothing at all.

```{code-cell}
×/⍳0
!0
```

In traditional mathematical notation, the factorial is written postfix:

$$k!=n\times(n-1)\times(n-2)\times\cdots\times 2\times 1$$

Now let's consider a slightly more restricted scenario. We still want to put $5$ books onto our bookshelf, but now we're selecting from a larger collection of $8$ books. So, starting with an empty bookshelf, we have $8$ books which could go in the first place, $7$ books for the second, and so on until we have $4$ books remaining for the final place. This means there are `8×7×6×5×4 ←→ 6720` arrangments of $5$ books our of our collection of $8$ - a lot of choice! To calculate this, we want to take the whole product `8×7×6×5×4×3×2×1 ←→ !8` and chop off the trailing `3×2×1 ←→ !3`, which we can do by dividing them: `8×7×6×5×4 ←→ (!8)÷!3 ←→ (!8)×!8-5`. Since an arrangement of all our books is a permutation, an arrangement of only some of them is a *partial permutation* or *$k$-permutation* (for arrangements of $k$ books). For example, given out set of books `'The Little Prince' 'Elements' 'Cosmos' 'A Programming Language' 'The Hobbit'`, a $3$-permutation might be `'A Programming Language' 'The Little Prince'`. Once again, our counting calculation generalises, so we know there are `(!n)÷!n-k` *$k$-permutations* of $n$ items. 

These are the kinds of problems we're concerned with in enumerative combinatorics. Over the remainder of this chapter, we'll be returning to these problems as well as many more. Once we've covered enough ground, we're going to see a unified framework for looking at all sorts of counting problems called 'The Twelvefold Way'. At this point, we'll also look not just at counting all the possibilities for a problem, but also algorithms for generating them all.

```{important}
- Enumerative combinatorics is the study of counting finite structures.
- The factorial: `!k ←→ ×/⍳k ←→ k×(k-1)×(k-2)×...×2×1`, $k!$.
- A *permutation* is a rearrangement of a set.
- There are `!n` permutations of an $n$ element set.
- A *$k$-permutation* is an arrangement of exactly $k$ elements of a set.
- There are `(!n)÷!n-k` $k$-permutations of an $n$ element set.
```

## Combinations and Bijective Proofs

- derive (!n)÷(!k)×!n-k
- define `k!n`
- basic identities
    - `k!n ←→ (n-k)!n`
    - `0!n ←→ n!n ←→ 1`
- flipping partitions to show identities
- pascal's triangle
    - `⍉∘.!⍨¯1+⍳n`
- show above identities on pascal's triangle
- proof of each element being the sum of the two above
- highlight `2*¯1+⍳7 ←→ +/⍉∘.!⍨¯1+⍳n`
- bijective proof
- binomial theorem
- aside: multinomial coefficients and theorem
    - `(!n←+/ks)÷×/!ks`

In this section, we're going to encounter one of the most basic and useful concepts in combinatorics: *combinations*.

A *combination* is a selection distinct elements from a set, without repetition, where we don't care about the order we pick elements. For example, given the set `'apple' 'orange' 'pear' 'banana' 'kiwi'`, `'apple' 'banana'` is a combination of $2$ elements from the set. It is different to the combination `'orange' 'banana'`, but the same as the combination `'banana' 'apple'`, since we don't care about order. A *$k$-combination* is a combination of exactly $k$ elements from the set.

There are $10$ $2$-combinations of our set `'apple' 'orange' 'pear' 'banana' 'kiwi'`:

```
apple  orange
apple  pear
apple  banana
apple  kiwi
orange pear
orange banana
orange kiwi
pear   banana
pear   kiwi
banana kiwi
```

It's probably clear where we're going with this. If we have a set of $n$ elements, how many $k$-combinations of elements from that set are there? This is very similar to a question we've already answered. We've already seen that there are `(!n)÷!n-k` $k$-*permutations* of an $n$ element set, so this is a good starting point. There are more $k$-permutations of a set than there are $k$-combinations of the same set, since the order that we select elements matters in a permutation, but not in combinations: `'apple' 'pear'` and `'pear' 'apple'` are the same combination of items, but they are different permutations.

[diagram]

In fact, for each $k$-combination of items, there are `!k` permutations of that combination. So, in our formula `(!n)÷!n-k` for counting $k$-permutations, we are overcounting combinations by a factor of `!k`. This leads us to a formula for the number of $k$-combinations:

```
((!n)÷!n-k)÷!k ←→ (!n)÷(!k)×!n-k
```

By dividing by `!k`, we are undoing the overcounting in the partial permutations formula.

Along with the factorial, this is one of the most useful quantities in combinatorics, so it too gets it own name: the *binomial coefficient*. We'll see where this name comes from later. The binomial coefficient takes up the dyadic form of `!`:

```{code-cell}
k n←2 5           ⍝ 2-combinations of 5 items
(!n)÷(!k)×!n-k
k!n
```

You can read `k!n` as '$k$ from $n$', '$k$ of $n$', or similar. Note that our formula `(!n)÷(!k)×!n-k` will `DOMAIN ERROR` when `k>n`. This is because then `(n-k)<0`, so `!n-k` doesn't make any sense. This aligns with our intuition for combinations, since you can't take more elements from a set than there are. `k!n` will evaluate to `0` when `k>n`, rather than `DOMAIN ERROR`ing, meaning that are no ways to take $k$ elements from the set.

```{code-cell}
k n←6 5           ⍝ trying to take 6 things from a set of 5
(!n)÷(!k)×!n-k
k!n
```

In traditional mathematical notation, `k!n` is written as

$$
\binom{n}{k}=\begin{cases}
    \frac{n!}{k!(n-k)!} & k\le n \\
    0                   & k>n
\end{cases}
$$

This notation is usually read as '$n$ choose $k$'.

Here's an interesting thing to note about the binomial coefficient. `k!n` and `(n-k)!n` will always evaluate to the same number. To see why, let's view combinations from another perspective. Take our trusty set of fruits `'apple' 'orange' 'pear' 'banana' 'kiwi'`. Let's mark which of those we're choosing in the combination `'apple' 'pear'` with a $1$, and the rest with a $0$.

```{code-cell}
'apple' 'orange' 'pear' 'banana' 'kiwi'∊'apple' 'pear'
```

This is nice representation of a combination, since it doesn't matter what order we put our choices in:

```{code-cell}
⍝ reverse order of combination, same result
'apple' 'orange' 'pear' 'banana' 'kiwi'∊'pear' 'apple'
```

This representation gives us a new way to look at combinations - out of a sequence of $n$ $0$s, we choose $k$ to turn into ones. Equally, you can view this as a sequence of $n$ $1$s, where we choose $n-k$ to turn into $0$s. In other words, we're choosing $n-k$ to *not* select. Since there are the same number of ways to choose $k$ items as there are to discard $n-k$ items, it must be the case that `(k!n)≡(n-k)!n`.

To study the binomial coefficient in more detail, it will be helpful to look at its function table:

```{code-cell}
⍉∘.!⍨0,⍳7
```

Don't get tripped up! Note that `k!n` is defined for all $k$ and $n$ which are non-negative integers, including $0$. This means the value at `p[n;k]` is `(k-1)!n-1`.

The triangle in this table is called *Pascal's triangle*, and has been studied for centuries [^pascal] since it has many interesting patterns. First of all, we can easily see the property we just proved (`(k!n)≡(n-k)!n`) by the fact that each row is symmetrical (ignoring $0$s). Another thing to notice about the triangle is that each item is the sum of the item directly above it, and the item above and to the left of it. For example, the $6$ in the $5$th row is the sum of the two $3$s in the row above. So we could also generate the trangle by starting with the first row and repeatedly summing adjacent items:

[^pascal]: Although it is named after French Mathematician [Blaise Pascal](https://en.wikipedia.org/wiki/Blaise_Pascal), Pascal's triangle was discovered and studied for centuries before him.

```{code-cell}
⍪⊃{⍵,⊂1,(2+/⊃⌽⍵),1}/(⍳7),⊂,⊂,1    ⍝ ↑ing this would give the same matrix as we saw before
```

Stated more formally, we're saying that `k!n ←→ (k!n-1)+(k-1!n-1)`. There's more than one way we can prove this. We *could* go about it algebraically, but that would be long and unenlightening. You can find the algebraic proof in the footnotes if you're interested in it[^algebraic-proof]. Instead, it's equally valid to prove this by talking about what it's describing.

[^algebraic-proof]: $$\begin{aligned}
    \binom{n-1}{k}+\binom{n-1}{k-1}&=\frac{(n-1)!     }{k!((n-1)-k)!} +\frac{(n-1)! }{(k-1)!((n-1)-(k-1))!} \\
                                   &=\frac{(n-1)!     }{k!(n-k-1)!  } +\frac{(n-1)! }{(k-1)!(n-k)!        } \\
                                   &=\frac{(n-1)!(n-k)}{k!(n-k)!    } +\frac{(n-1)!k}{k!    (n-k)!        } \\
                                   &=\frac{(n-1)!((n-k)+k)}{k!(n-k)!} \\
                                   &=\frac{(n-1)!n        }{k!(n-k)!} \\
                                   &=\frac{n!             }{k!(n-k)!} \\
                                   &=\binom{n}{k}
\end{aligned}
$$

`k!n` is the number of ways to pick a combination of $k$ items from an $n$ element set. To pick a combination, for each item in the set, we have two options. We can either (1) pick it, and pick `k-1` more items from the remaining `n-1` elements of the set, or (2) not pick it, and instead pick all `k` items from the remaining `n-1` elements. There are `(k-1)!n-1` ways for (1), and `k!n-1` ways for (2). So, in total, there are `(k!n-1)+(k-1)!n-1` ways to pick a combination of $k$ items from an $n$ element set. Therefore, `k!n ←→ (k!n-1)+(k-1)!n-1`.

This kind of proof, where we show that two different expressions count the same thing (or, in general, the same number of things), is called a *bijective proof*, and they are used throughout combinatorics. Let's do another one to get a better feel of the process.

If you were playing around with Pascal's triangle, you might notice a pattern that arises from summing along its rows.

```{code-cell}
⊢p←⍉∘.!⍨0,⍳7
+/p
```

Those are all powers of $2$! Specifically, each `n+1`th row of the triangle sums to `2*n`, which we can write formally as `+/(0,⍳n)!n ←→ 2*n` (note that `!` is pervasive like `+`, `×` and friends, so `a b c!n ←→ (a!n) (b!n) (c!n)`).

Again, we can prove this alegebraically, but it's much more insightful to prove it bijectively. `+/(0,⍳n)!n` is the number of ways to pick a $1$-combination from $n$ items, plus the number of ways to pick a $2$-combination, and a $3$-combination, and so on until $n$-combination. In other words, it is the number of ways to pick a combination of any size. The number of ways to pick a combination of any size can also be described differently. For each item in the set, we have $2$ choices: either we can pick it or we can not pick it. Therefore there are `2*n` ways to pick a combination of any size from an $n$ element set. Since both `+/(0,⍳n)!n` and `2*n` count the number of ways to pick a combination of any size from an $n$ element set, the expressions must be equal for all $n$.

Now, we're ready to see the namesake of the binomial coefficient `k!n`. 

## Counting Functions

```{note}
This chapter assumes you're familiar with the notions of injective, surjective, and bijective functions.
```

- introduce balls and boxes analogy
- recall functions, injective, surjective, bijective
- `n*k` possible functions
- balls in boxes is function ball → box
- combinations are injective functions
- permutations are bijective functions
- next we'll count surjections

## Inclusion-Exclusion and Counting Partitions

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

## Stars and Bars

- diagramssss
- unlabelled balls into labelled boxes
    - `'*|**||*|' ←→ '*|**||*|'[7 2 4 1 5 6 3 8]`
- ways to generate
    - combinations of bars from string
    - `k!k+n-1 ←→ (n-1)!k+n-1` ways
- surjective stars and bars
    - first pick k-n, then add n to each one
    - `(k-n)!k-1 ←→ (n-1)!k-1` ways

## Integer Partitions

- unlabelled balls, unlabelled boxes, any or at least 1 per box
- no closed form, but we can still generate
- young diagram
- conjugate partitions - equivalent counts theorem
- self conjugate partitions
    - `7 6 4 4 4 2 2 1`
- self conjugate partitions ←→ distinct odd partitions
- proof using hook numbers in young tableaux

## Twelvefold Teaser

- some combinations of labelling and numbering we haven't tried
- this is the topic of the next section
