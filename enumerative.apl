n*k    ⍝ number of ways to place k labelled balls in n labelled boxes, comparison to binary numbers as subset masks
!n     ⍝ number of ways to place k←n labelled balls in n labelled boxes, with at most 1 per box (number of permutations)
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
≢a∪b ←→ +/≢¨a b (a∩b)                                  ⍝ binary inclusion exclusion
≢⊃∪/as ←→ +/(≢⍤(⊃∩/) × ¯1*¯1+≢)¨ ⊂⍤/∘as⍤1⍉2⊥⍣¯1⍳¯1+2*≢as ⍝ general inclusion exclusion principle
(!n)-+/((¯1*¯1+⊢)×!∘n×(!n-⊢))⍳n ←→ +/(¯1∘* × !∘n × (!n-⊢))0,⍳n ←→ (!n)×+/(¯1∘*÷!)0,⍳n    ⍝ number of derangements of a size n set
k Surj n ←→ +/(!∘n×¯1∘*×k*⍨n-⊢)0,⍳n    ⍝ number of surjections [k]->[n], labelled balls, labelled boxes, at least 1 ball in each box
k S n ←→ (!n)÷⍨k Surj n                ⍝ stirling numbers of the second kind, labelled balls, unlabelled boxes, at least 1 ball in each box
Surj←{k n←⍺ ⍵ ⋄ +/(!∘n×¯1∘*×k*⍨n-⊢)0,⍳n}
S←{k n←⍺ ⍵ ⋄ (k Surj n)÷!n}
B←{k←⍵ ⋄ +/k S¨0,⍳k} ⍝ B k ←→ number of ways to partition [k] into any number of parts (can't be more than k clearly), Bell numbers
k!k+n-1   ←→ (n-1)!k+n-1    ⍝ k unlabelled balls into n labelled boxes, unrestricted numbers (how many ways to put stars in a stars and bars sequence)
(k-n)!k-1 ←→ (n-1)!k-1      ⍝ k unlabelled balls into n labelled boxes, at least one ball in each box (only pick k-n, then add 1 to each box at the end)
⍝ generate integer partitions by recurrence
⍴∘1⍤0      ⍝ young diagram of a partition
+⌿⍴∘1⍤0    ⍝ conjugate partition
{t-⍨(⌽+\⌽t)+⊖+⍀⊖t←⍴∘1⍤0⊢⍵} ⍝ conjugate partition to distinct odd partition
C n ←→ (n!2×n)-(n-1)!2×n ←→ (n+1)÷⍨n!2×n ⍝ catalan numbers

⍝ THE TWELVEFOLD WAY - reference sudley place

⍝ k unlabelled balls, n unlabelled boxes, at most 1 ball per box 
k≤n             ⍝ number of ways
n(k≤n)⍴n↑k⍴1    ⍝ all ways

⍝ k unlabelled balls, n unlabelled boxes, any number of balls per box - partitions of k
∇ r←C112 k    ⍝ all ways
  r←,⊂a←,k
  :While ∨/a≠1
     h t←(¯1++/1≠a)(↑,⍥⊂↓)a         ⍝ suffix (x+1),1,..,1
     x←¯1+⊃t
     s←+/t                          ⍝ sum of suffix
     r,←⊂a←h,(x⍴⍨⌊s÷x),(0∘≠⍴⊢)x|s   ⍝ h,x,..,x,r where s=x+..+x+r
  :EndWhile
∇

⍝ k unlabelled balls, n unlabelled boxes, at least 1 ball per box - partitions of k into exactly n parts
∇ r←k C113 n
  r←1 n⍴a←1+n↑k-n
  :While n≥j←1⍳⍨a<a[1]-1
     h t←j(↑,⍥⊂↓)a
     x←1+⊃⌽h
     r⍪←a←(h[1]++/x-⍨1↓h),(x⍴⍨¯1+≢h),t
  :EndWhile
∇

⍝ k unlabelled balls, n labelled boxes, at most 1 ball per box - combinations
k!n           ⍝ number of ways
P←{k n←⍺ ⍵    ⍝ all ways
    k=1: ⍪⍳n
    k>n: 0 k⍴⍬ 
    (k∇n-1)⍪n,⍨(k-1)∇n-1
}
