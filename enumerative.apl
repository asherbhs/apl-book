n*k    ⍝ number of ways to place k labelled balls in n labelled boxes
!n     ⍝ number of ways to place k←n labelled balls in n labelled boxes, with at most 1 per box (number of permutations)
k!n    ⍝ number of ways to place k unlabelled balls in n labelled boxes, with at most 1 per box (binomial coefficient)
k!n ←→ (!n)÷(!k)×!n-k
k!n ←→ (n-k)!n
0!n ←→ n!n ←→ 1
⍉∘.!⍨⍳n    ⍝ n rows of pascal's triangle
k!n ←→ (k!n-1)+(k-1)!n-1    ⍝ bijective proof
2*¯1+⍳7 ←→ +/⍉∘.!⍨⍳n        ⍝ bijective proof
(a+b)*n ←→ +/(!∘n × a∘* × b*n-⊢)0,⍳n    ⍝ binomial theorem
(!n)÷×/!ks   ⍝ multinomial coefficient with +/ks ←→ n
⍝ multinomial theorem?


