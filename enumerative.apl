⍝ NOTE: this file will hit VALUE ERROR immediately, it's not meant to be run, it's meant to be a reference

n*k    ⍝ number of ways to place k labelled balls in n labelled boxes
!n     ⍝ number of ways to place k←n labelled balls in n labelled boxes, 1 per box (number of permutations)
k!n    ⍝ number of ways to place k unlabelled balls in n labelled boxes, with at most 1 per box (binomial coefficient)
k!n ←→ (!n)÷(!k)×!n-k
k!n ←→ (n-k)!n
0!n ←→ n!n ←→ 1
⍉∘.!⍨¯1+⍳n    ⍝ n rows of pascal's triangle
k!n ←→ (k!n-1)+(k-1)!n-1    ⍝ bijective proof, hockeystick identity
2*¯1+⍳7 ←→ +/⍉∘.!⍨¯1+⍳n     ⍝ bijective proof, binary numbers
(a+b)*n ←→ +/(!∘n × a∘* × b*n-⊢)0,⍳n    ⍝ binomial theorem
(!n)÷×/!ks   ⍝ multinomial coefficient with +/ks ←→ n
⍝ multinomial theorem?
≢a∪b ←→ +/≢¨a b (a∩b)                                    ⍝ binary inclusion exclusion
≢⊃∪/as ←→ +/(≢⍤(⊃∩/) × ¯1*¯1+≢)¨ ⊂⍤/∘as⍤1⍉2⊥⍣¯1⍳¯1+2*≢as ⍝ general inclusion exclusion principle
(!n)-+/((¯1*¯1+⊢)×!∘n×(!n-⊢))⍳n ←→ +/(¯1∘* × !∘n × (!n-⊢))0,⍳n ←→ (!n)×+/(¯1∘*÷!)0,⍳n    ⍝ number of derangements of a size n set
k Surj n ←→ +/(!∘n×¯1∘*×k*⍨n-⊢)0,⍳n    ⍝ number of surjections [k]->[n], labelled balls, labelled boxes, at least 1 ball in each box
k S n ←→ (!n)÷⍨k Surj n                ⍝ stirling numbers of the second kind, labelled balls, unlabelled boxes, at least 1 ball in each box
Surj←{k n←⍺ ⍵ ⋄ +/(!∘n × ¯1∘* × k*⍨n-⊢)0,⍳n}
S←{k n←⍺ ⍵ ⋄ (k Surj n)÷!n}
B←{k←⍵ ⋄ +/k S¨0,⍳k} ⍝ B k ←→ number of ways to partition [k] into any number of parts (can't be more than k clearly), Bell numbers
k!k+n-1   ←→ (n-1)!k+n-1    ⍝ k unlabelled balls into n labelled boxes, unrestricted numbers (how many ways to put stars in a stars and bars sequence)
(k-n)!k-1 ←→ (n-1)!k-1      ⍝ k unlabelled balls into n labelled boxes, at least one ball in each box (only pick k-n, then add 1 to each box at the end)
⍝ generate integer partitions by recurrence
⍴∘1⍤0      ⍝ young diagram of a partition
+⌿⍴∘1⍤0    ⍝ conjugate partition
{t-⍨(⌽+\⌽t)+⊖+⍀⊖t←⍴∘1⍤0⊢⍵} ⍝ hook numbers
C n ←→ (n!2×n)-(n-1)!2×n ←→ (n+1)÷⍨n!2×n ⍝ catalan numbers

⍝ THE TWELVEFOLD WAY - reference sudley place

⍝ permutations (aplcart)
P←{n←⍵
    0=n: 1 0⍴0
    ,[⍳2](⍒⍤1∘.=⍨⍳n)[;1,1+∇n-1]
}

⍝ k unlabelled balls, n unlabelled boxes, at most 1 ball per box 
k≤n             ⍝ number of ways
n(k≤n)⍴n↑k⍴1    ⍝ all ways

⍝ k unlabelled balls, n unlabelled boxes, any number of balls per box - integer partitions of k
⍝ knuth method (doesn't limit number)
∇ r←C112n k    ⍝ all ways
  r←,⊂a←,k
  :While ∨/a≠1
     h t←(¯1++/1≠a)(↑,⍥⊂↓)a         ⍝ suffix (x+1),1,..,1
     x←¯1+⊃t
     s←+/t
     r,←⊂a←h,(x⍴⍨⌊s÷x),(0∘≠⍴⊢)x|s   ⍝ h,x,..,x,r where s=x+..+x+r
  :EndWhile
∇

C112nk←{k n←⍺ ⍵
    (≢∘⌊⍨∨0 0∨.>⊢)k n: '⍺ and ⍵ must be non-negative integers'⎕signal 11
    _p←{k i n←⍺ ⍺⍺ ⍵                   ⍝ partitions of k into at most n parts no larger than i
        k=0:   ,⊂⍬                     ⍝ if k=0, there is exactly one partition: ⍬
        n=0: 0⍴,⊂⍬                     ⍝ if n=0, and k≠0, there are no boxes left
        ⊃,/{⍵,¨(k-⍵)(⍵ _p)n-1}¨⍳k⌊i    ⍝ choose candidates counts for first box, and call recursively for the rest
    }
    k(k _p)n
}

⍝ k unlabelled balls, n unlabelled boxes, at least 1 ball per box - integer partitions of k into exactly n parts
⍝ result is a matrix with rows of length n
∇ r←k C113n n
  r←1 n⍴a←1+n↑k-n
  :While n≥j←1⍳⍨a<a[1]-1
     h t←j(↑,⍥⊂↓)a
     x←1+⊃⌽h
     r⍪←a←(h[1]++/x-⍨1↓h),(x⍴⍨¯1+≢h),t
  :EndWhile
∇

C113nk←{k n←⍺ ⍵
    (≢∘⌊⍨∨0 0∨.>⊢)k n: '⍺ and ⍵ must be non-negative integers'⎕signal 11
    _p←{k i n←⍺ ⍺⍺ ⍵                     ⍝ partitions of k into exactly n parts no larger than i
        k<n:       0 n⍴0                 ⍝ if k<n, there are too many boxes
        k n∧.=0 0: 1 n⍴0                 ⍝ if k and n are both 0, there is exactly one partition: the empty partition
        n=0:       0 n⍴0                 ⍝ if n=0, there are not enough boxes (k≥n and if n=0 and k=0 we don't get here, so if n=0 then k≥1)
        ⊃⍪/{⍵,⍤1⊢(k-⍵)(⍵ _p)n-1}¨⍳k⌊i    ⍝ choose candidate counts for first box, and call recursively for the rest
    }
    k(k _p)n
}

⍝ k unlabelled balls, n labelled boxes, at most 1 ball per box - combinations
k!n    ⍝ number of ways
C121kn←{k n←⍺ ⍵
    (≢∘⌊⍨∨0 0∨.>⊢)k n: '⍺ and ⍵ must be non-negative integers'⎕signal 11
    k>n: 0 k⍴0              ⍝ if k>n, there are too many balls
    k=0: 1 0⍴0              ⍝ if k=0, there is one combination, which is choosing none. k≤n, so this case also catches all n=0
    (k∇n-1)⍪n,⍨(k-1)∇n-1    ⍝ pick the last box, or don't, and call recursively
}

C121nk←{k n←⍺ ⍵
    (≢∘⌊⍨∨0 0∨.>⊢)k n: '⍺ and ⍵ must be non-negative integers'⎕signal 11
    k>n: 0 n⍴0
    k=0: 1 n⍴0
    (0,k∇n-1)⍪1,(k-1)∇n-1    ⍝ pick the last box, or don't, and call recursively
}

⍝ k unlabelled balls, n labelled boxes, any number of balls per box - stars and bars/compositions
k!k+n-1    ⍝ number of ways
C122kn←{k n←⍺ ⍵
    (≢∘⌊⍨∨0 0∨.>⊢)k n: '⍺ and ⍵ must be non-negative integers'⎕signal 11
    (k C121kn k+n-1)-⍤1⊢¯1+⍳k
}

C122nk←{k n←⍺ ⍵
    (≢∘⌊⍨∨0 0∨.>⊢)k n: '⍺ and ⍵ must be non-negative integers'⎕signal 11
    ¯1+2-⍨/(0,⊢,k+n⍨)(n-1)C121kn k+n-1
}

⍝ k unlabelled balls, n labelled boxes, at least 1 ball per box - compositions
(n-1)!k-1 ⍝ number of ways
C123kn←{k n←⍺ ⍵
    (≢∘⌊⍨∨0 0∨.>⊢)k n: '⍺ and ⍵ must be non-negative integers'⎕signal 11
    (k C123nk n)/⍤1⍳n    ⍝ lazy but whatever
}

C123nk←{k n←⍺ ⍵    ⍝ ←→ 1+k C112nk n
    (≢∘⌊⍨∨0 0∨.>⊢)k n: '⍺ and ⍵ must be non-negative integers'⎕signal 11
    2-⍨/(0,⊢,k⍨)(n-1)C121kn k-1    ⍝ differences between indices of box walls ←→ size of boxes-1
}

⍝ k labelled balls, n unlabelled boxes, at most 1 ball per box - same as if balls were unlabelled (see above)
k≤n             ⍝ number of ways
n(k≤n)⍴n↑k⍴1    ⍝ all ways

⍝ k labelled balls, n unlabelled boxes, any number of balls per box - ≤n partitions of [k]
B k ←→ +/k S¨0,⍳k    ⍝ number of ways - ish
C212kn←{k n←⍺ ⍵
    (≢∘⌊⍨∨0 0∨.>⊢)k n: '⍺ and ⍵ must be non-negative integers'⎕signal 11
    ((⊃⍪/){⊂⍵∘,⍤0⍳n⌊1+⌈/⍵}⍤1)⍣(k-1)⊢1 1⍴1
}

C212nk←(⊂⊂⍤⊢⌸)⍤1 C212kn

⍝ k labelled balls, n unlabelled boxes, at least 1 ball per box - [k] into exactly n partitions
k S n              ⍝ number of ways
C213kn←{k n←⍺ ⍵    ⍝ labels of partitions
    (≢∘⌊⍨∨0 0∨.>⊢)k n: '⍺ and ⍵ must be non-negative integers'⎕signal 11
    p⌿⍨n=⌈/p←k C212 n
}
⊂⍤⊢⌸⍤1 C213nk

⍝ k labelled balls, n labelled boxes, at most 1 ball per box - partial permutations
(!k)×k!n          ⍝ number of ways
C221kn←{k n←⍺ ⍵    ⍝ all ways
    (≢∘⌊⍨∨0 0∨.>⊢)k n: '⍺ and ⍵ must be non-negative integers'⎕signal 11
    ,[⍳2](k C121kn n)[;P k]
}

⍝ k labelled balls, n labelled boxes, any number of balls per box - k tuples of n
n*k               ⍝ number of ways
C222kn←{k n←⍺ ⍵   ⍝ all ways
    (≢∘⌊⍨∨0 0∨.>⊢)k n: '⍺ and ⍵ must be non-negative integers'⎕signal 11
    ↑(,∘.,)⍣(k-1)⍨⍳n
}

⍝ k labelled balls, n labelled boxes, at least 1 ball per box
(!n)×k S n
C223nk←{k n←⍺ ⍵
    (≢∘⌊⍨∨0 0∨.>⊢)k n: '⍺ and ⍵ must be non-negative integers'⎕signal 11
    ,[⍳2](k C213nk n)[;P n]
}
