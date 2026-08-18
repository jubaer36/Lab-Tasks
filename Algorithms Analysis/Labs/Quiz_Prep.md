# CSE 4810 Algorithm Engineering — Lab Quiz Prep
### Comprehensive MCQ + Short Question Bank (with Answers & Explanations)

Covers Labs 1–6: Divide & Conquer / Master Method, Randomized Algorithms, Hashing, Amortized Analysis, Greedy, Dynamic Programming, Graph Algorithms.

---

## LAB 1 — Divide & Conquer, Master Method

**Quick theory recap**
- Master Theorem for `T(n) = aT(n/b) + f(n)`: compare `f(n)` to `n^(log_b a)`.
  - Case 1: `f(n) = O(n^(log_b a − ε))` → `T(n) = Θ(n^(log_b a))`
  - Case 2: `f(n) = Θ(n^(log_b a)·log^k n)` → `T(n) = Θ(n^(log_b a)·log^(k+1) n)`
  - Case 3: `f(n) = Ω(n^(log_b a + ε))` + regularity → `T(n) = Θ(f(n))`
- Rotated sorted array min → modified binary search, O(log n), key invariant: one half is always strictly sorted.
- Max Subarray (D&C) → three cases (left/right/crossing midpoint), combine step is O(n) linear scan from mid.
- Inversion Count → piggybacks on merge-sort's merge step; when `R[j] < L[i]`, add `len(L) - i` inversions at once (not +1).

### MCQs

1. **For `T(n) = 2T(n/2) + Θ(n)`, which Master Theorem case applies and what is the result?**
   a) Case 1, Θ(n)
   b) Case 2, Θ(n log n)
   c) Case 3, Θ(n²)
   d) Case 2, Θ(n²)
   **Answer: b.** `n^(log_2 2) = n`, and `f(n)=Θ(n)=Θ(n^1 log^0 n)` → Case 2 with k=0 → `Θ(n log^1 n)`.

2. **Finding the minimum in a rotated sorted array of distinct elements via modified binary search has what complexity, and why?**
   a) O(n), must check every element
   b) O(log n), because one half of any subarray is always sorted, letting you discard half each step
   c) O(n log n), same as merge sort
   d) O(1), constant time lookup
   **Answer: b.**

3. **In the Max Subarray D&C algorithm, what does `Find-Max-Crossing-Subarray` do?**
   a) Recursively solves both halves
   b) Scans outward from the midpoint in both directions to find the best sum touching the midpoint, in O(n)
   c) Sorts the array
   d) Runs in O(log n)
   **Answer: b.** This linear "combine" step is exactly what makes the recurrence `T(n)=2T(n/2)+Θ(n)` → Case 2 → O(n log n).

4. **`left_sum` and `right_sum` in the crossing-subarray step are initialized to −∞ rather than 0. Why?**
   a) To speed up computation
   b) To correctly handle the case where all elements are negative (the max subarray still must be non-empty)
   c) It's a bug in the pseudocode
   d) To avoid integer overflow
   **Answer: b.**

5. **In the inversion-counting merge step, when `R[j] < L[i]`, why is `inversions += (length(L) - i)` correct, and what happens if you instead do `inversions += 1`?**
   **Short answer:** Since `L` is sorted, if `R[j] < L[i]`, then `R[j]` is smaller than *all* remaining elements in `L` from index `i` onward — so `R[j]` inverts with all of them simultaneously. Adding just `+1` would undercount inversions and, if you tried to fix it by looping over remaining L elements one at a time, you'd degrade the algorithm back toward O(n²) (defeats the purpose of doing it during the O(n) merge).

6. **What is the time complexity of the naive Maximum Subarray algorithm (checking all subarrays), and what recurrence/complexity does the D&C version achieve?**
   **Short answer:** Naive: O(n²) (nested loops over all (i,j) pairs). D&C: `T(n)=2T(n/2)+Θ(n)` → Θ(n log n) via Master Case 2.

7. **Why must timing code never include `cout`/`printf` inside the measured region?**
   a) It causes compiler errors
   b) I/O is thousands of times slower than arithmetic and corrupts timing measurements
   c) It changes the algorithm's correctness
   d) It's a style preference only
   **Answer: b.**

8. **Which C++ clock is recommended for benchmarking, and why not `clock()`?**
   **Short answer:** `std::chrono::high_resolution_clock` — it's a proper monotonic high-resolution timer; `clock()` measures CPU time and is inaccurate/unreliable on multi-core systems.

9. **A rotated-array worst case for the O(n) linear boundary scan is engineered by rotating the array by how much, and why?**
   a) Rotate by n/2, splits work evenly
   b) Rotate by 1, so the minimum sits at the very last index, forcing a full scan
   c) Rotate by n, no change
   d) It doesn't matter, all rotations are equally bad
   **Answer: b.**

10. **True/False: The "one half is always sorted" invariant used in rotated-array binary search can break if the array contains duplicate elements.**
    **Answer: True.** With duplicates, `A[mid]==A[high]` creates ambiguity about which half is sorted — a classic gotcha even though these specific labs use distinct integers.

---

## LAB 2 — Randomized Algorithms (Quicksort / Quickselect)

**Quick theory recap**
- Deterministic Quicksort worst case O(n²): triggered by consistently picking min/max as pivot (e.g., first/last element) on sorted/reverse-sorted input.
- Average/best case (balanced splits): Θ(n log n), via `T(n)=2T(n/2)+Θ(n)`.
- Randomized Quicksort: worst case still O(n²) *possible* but **expected** O(n log n) for *any* input, because pivot choice is randomized rather than input-dependent.
- Randomized-Select (Quickselect): expected O(n) — because expected subproblem size shrinks geometrically after each partition.
- Median-of-three: a deterministic heuristic (not true randomization) that reduces the *likelihood* of worst case but doesn't eliminate it.

### MCQs

1. **Deterministic Quicksort using the first element as pivot has its worst case triggered by:**
   a) A reverse-sorted array
   b) An already-sorted (ascending) array
   c) A random array
   d) An array of all equal elements only
   **Answer: b.** Picking `A[low]` on an ascending array always yields the min as pivot → maximally unbalanced partitions (0, n−1) each call.

2. **What is the expected running time of Randomized Quicksort on *any* input, including already-sorted arrays?**
   a) O(n²), same as deterministic
   b) O(n log n) expected
   c) O(n), always linear
   d) O(log n)
   **Answer: b.** Randomization defends against adversarial input structure; worst case O(n²) is still *possible* but not tied to any specific input.

3. **Randomized-Select's expected time complexity is:**
   a) O(n log n)
   b) O(n²)
   c) O(n)
   d) O(log n)
   **Answer: c.** Because the expected subproblem size shrinks geometrically (n + n/2 + n/4 + ... = O(n)) — unlike Quicksort, which must recurse into *both* sides.

4. **Median-of-three pivot selection is:**
   a) A true randomization technique
   b) A deterministic heuristic that reduces (without eliminating) the chance of hitting worst-case input
   c) Guaranteed O(n log n) worst case
   d) Equivalent to random pivot selection in every respect
   **Answer: b.** It's still deterministic — an adversary can still construct a worst-case input, just one that's harder to construct than for fixed-endpoint pivoting.

5. **Why must both random *and* adversarial/worst-case test data be benchmarked for each deterministic/randomized algorithm pair in Lab 2?**
   **Short answer:** To expose that the deterministic algorithm suffers O(n²) blowup specifically on adversarial input, while the randomized version's performance stays close to O(n log n)/O(n) regardless of input arrangement — this contrast is the core lesson (why randomize).

6. **Shuffling an array with Fisher-Yates before running a deterministic Quicksort is asymptotically equivalent in expectation to:**
   a) Running Bubble Sort
   b) Running randomized Quicksort directly (randomizing input vs. randomizing pivot choice achieve the same expected effect)
   c) Nothing — it has no effect
   d) Merge Sort
   **Answer: b.**

7. **Besides wall-clock time, what other metric should be tracked to get an implementation-independent efficiency measure?**
   **Short answer:** An explicit comparison counter, incremented at each comparison operation inside the sort/select — hardware/timing-independent, unlike wall-clock time.

8. **What is the recurrence and complexity for deterministic Quicksort's worst case?**
   **Short answer:** `T(n) = T(n−1) + Θ(n)` (maximally unbalanced split) → Θ(n²).

---

## LAB 3 — Hashing

**Quick theory recap**
- Load factor `α = n/m`. Open addressing requires **α < 1** strictly (unlike chaining, where α can exceed 1).
- Linear Probing: `h(k,i) = (h1(k)+i) mod m` — suffers **primary clustering**.
- Double Hashing: `h(k,i) = (h1(k)+i·h2(k)) mod m` — avoids clustering, but has worse cache locality (jumps around memory) vs. LP's contiguous scan.
- Division method: `h(k)=k mod m`, needs **m prime**. Multiplication method: `h(k)=⌊m(kA mod 1)⌋` with Knuth's `A≈0.618`, works for any m (commonly paired with power-of-2 m).
- Theoretical bounds (uniform hashing assumption): unsuccessful search ≈ `1/(1-α)`; successful search (DH) ≈ `(1/α)·ln(1/(1-α))`.
- Deletion in open addressing can't just null a slot (breaks probe chains for later searches) — two fixes: **lazy deletion** (DELETED tombstone sentinel) or **re-hashing the rest of the cluster**.

### MCQs

1. **Why can't you simply set a slot to "empty" (null) when deleting a key from an open-addressing hash table?**
   a) It's fine to do so
   b) It would break probe chains — later searches for keys that probed *past* the deleted slot would incorrectly stop and report "not found"
   c) It causes a memory leak
   d) It violates the load factor constraint
   **Answer: b.**

2. **In double hashing with table size m (power of 2), why must the secondary hash function `h2(k)` always return an odd number?**
   a) Odd numbers hash faster
   b) To guarantee `h2(k)` is coprime to m, ensuring the probe sequence visits every slot (a full permutation) instead of only even-indexed slots
   c) It's an arbitrary convention
   d) To avoid negative numbers
   **Answer: b.**

3. **Similarly, when table size m is prime and `h2(k) = 1+(k mod (m-1))`, why does this guarantee a full probing permutation?**
   **Short answer:** Since m is prime, any value in [1, m−1] is automatically coprime to m — so the step size `h2(k)` never divides evenly into m, forcing the linear congruential probe sequence to eventually visit all m slots before repeating.

4. **What is the key trade-off between Linear Probing and Double Hashing observed empirically in the lab?**
   a) LP always wins on both probe count and time
   b) DH generally achieves lower probe counts (avoids clustering) but LP can be faster in wall-clock time due to cache locality (contiguous memory access) — probe-count superiority ≠ time superiority
   c) They are identical in all respects
   d) DH always wins on both metrics
   **Answer: b.**

5. **Under the idealized/uniform-hashing assumption, the expected number of probes for an unsuccessful search in linear probing is approximately:**
   a) `log(n)`
   b) `1/(1-α)`
   c) `α²`
   d) `n/2`
   **Answer: b.**

6. **In "lazy deletion," what must a `search()` operation do differently compared to a table with no deletions?**
   a) Nothing changes
   b) It must continue probing past DELETED (tombstone) slots — only a true EMPTY slot or a key match stops the search
   c) It should stop as soon as it hits a DELETED slot
   d) It must rehash the whole table first
   **Answer: b.**

7. **Can an `insert()` reuse a slot marked DELETED?**
   **Answer: Yes** — insertion can safely place a new key into a DELETED slot (unlike search, which must keep scanning past it).

8. **Why does accumulating many tombstones (DELETED markers) degrade search performance even if the *active* load factor α (live keys / table size) stays low?**
    **Short answer:** Searches must scan past tombstones to find an EMPTY slot or a match, so effective probe cost tracks the *historical* occupancy (active + deleted), not just the current active load factor — probe counts no longer match `1/(1-α)` computed from active α alone.

9. **Why is the Division Method's table size required to be prime?**
    **Short answer:** To avoid poor key distribution when keys share common factors with a non-prime m (e.g., all-even keys mod an even m collide heavily) — prime m minimizes systematic clustering from patterned input.

10. **What does chaining allow that open addressing does not, with respect to load factor?**
    a) Chaining requires α < 1 too
    b) Chaining allows α > 1 (more elements than table slots), since each slot holds a linked list
    c) Chaining has no load factor concept
    d) Chaining is always faster
    **Answer: b.**

---

## LAB 4 — Amortized Analysis & Greedy Algorithms

**Quick theory recap**
- Amortized analysis gives a **worst-case guarantee averaged over a sequence of operations** (not a probabilistic/average-case claim).
- Three standard methods: **Aggregate** (total cost of n ops / n), **Accounting/Banker's** (assign amortized "credit" per op, prepaying for future expensive ops), **Potential method** (define a potential function Φ, amortized cost = actual cost + ΔΦ).
- Dynamic table doubling: resizes only at powers of 2 → total copy work ≤ `1+2+4+...+N ≤ 2N` → amortized O(1) per insert (aggregate method).
- Two-Stack Queue: each element does at most 4 units of work over its lifetime (push-in, pop-in, push-out, pop-out) → O(1) amortized per op (banker's method intuition).
- Greedy correctness needs **greedy-choice property + optimal substructure**, typically proven via an **exchange argument**.
- Coin change: greedy is optimal only for "canonical" denomination systems (e.g., {1,5,10,25}); fails (overshoots) on non-canonical systems (e.g., {1,4,5,15,20}) — this is a property of the coin system, not of how "smart" the greedy heuristic is.
- Huffman coding: the greedy choice (always merge two lowest-frequency nodes) is *always* provably optimal — but implementation efficiency varies: naive linear scan O(N²) vs. min-heap O(N log N).

### MCQs

1. **What does "amortized O(1)" mean for dynamic table doubling insertions?**
   a) Every single insertion takes exactly O(1) time
   b) Some individual insertions can cost O(n) (during a resize), but the *total* cost over N insertions is O(N), so the average cost per operation is O(1)
   c) It means the operation is probabilistically fast on average inputs
   d) It's a lower bound, not an upper bound
   **Answer: b.** Crucial distinction: amortized ≠ average-case (probabilistic); it's a worst-case-sequence guarantee.

2. **In dynamic table doubling, resizes happen when size crosses a power of 2. What is the total copying work across N insertions, and why?**
   a) O(N²), each resize copies all previous elements
   b) O(N) — because `1+2+4+...+N ≤ 2N`, a geometric series
   c) O(N log N)
   d) O(log N)
   **Answer: b.** This aggregate-method argument is the standard proof of O(1) amortized insert.

3. **In the Two-Stack Queue implementation, when does the "transfer" (moving all elements from `stack_in` to `stack_out`) occur?**
   a) On every `dequeue()` call
   b) Only when `dequeue()` is called AND `stack_out` is currently empty
   c) On every `enqueue()` call
   d) Never — it's a fixed cost model
   **Answer: b.** If `stack_out` already has elements, dequeue just pops from it directly (O(1), no transfer).

4. **Using the banker's/accounting method, how much total work does a single element in a Two-Stack Queue do over its entire lifetime?**
   a) 1 unit
   b) 2 units
   c) 4 units (push to stack_in, pop from stack_in, push to stack_out, pop from stack_out)
   d) O(n) units
   **Answer: c.**

5. **Name the three standard methods of amortized analysis.**
   **Short answer:** Aggregate method, Accounting (Banker's) method, Potential method.

6. **True/False: Amortized analysis provides a guarantee about the average-case (expected, probabilistic) running time.**
    **Answer: False.** It's a deterministic worst-case-over-a-sequence guarantee, not a probabilistic average-case statement (a common point of confusion, explicitly noted in the manuals).

7. **What two conditions must a problem satisfy for a greedy algorithm to be provably optimal?**
    **Short answer:** The **greedy-choice property** (a locally optimal choice leads to a globally optimal solution) and **optimal substructure** (an optimal solution contains optimal solutions to subproblems). Correctness proofs typically use an exchange argument.

8. **For the coin change problem, which of the following best describes when greedy (always take the largest coin ≤ remaining amount) is guaranteed optimal?**
    a) Always, for any set of denominations
    b) Only when the denomination system has the greedy-choice property (a "canonical" system, e.g. {1,5,10,25})
    c) Only when there's a 1-cent coin
    d) Never — DP is always required
    **Answer: b.** On non-canonical systems (e.g., {1,4,5,15,20}), greedy can overshoot into an inefficient remainder.

9. **A "remainder-aware" greedy heuristic for coin change (looks ahead one step to avoid awkward remainders) is:**
    a) Guaranteed optimal on all coin systems
    b) Still fundamentally greedy — it can improve on naive greedy for some non-canonical systems but is not guaranteed optimal in general; only full DP guarantees the true optimum
    c) Equivalent to dynamic programming
    d) Always worse than naive greedy
    **Answer: b.**

10. **In Huffman coding, is the greedy choice (always merge the two lowest-frequency nodes) always optimal?**
    a) No, it depends on the input like coin change
    b) Yes — always provably optimal via an exchange argument, regardless of frequency distribution
    c) Only for balanced frequency distributions
    d) Only if implemented with a heap
    **Answer: b.** This is the key contrast with coin change: Huffman's greedy optimality is a property of the *problem*, not the input structure.

11. **What is the time complexity difference between naive Huffman (linear scan for two smallest each merge) and heap-based Huffman?**
    a) Both are O(N log N)
    b) Naive: O(N²); Heap-based (min-priority-queue): O(N log N)
    c) Naive: O(N log N); Heap: O(N)
    d) Both are O(N²)
    **Answer: b.** N−1 merges; naive does two O(N) linear scans per merge → O(N²); heap does O(log N) pop/push per merge → O(N log N).

12. **True/False: If naive Huffman and heap-based Huffman are both implemented correctly, they must produce the exact same `total_internal_cost`, even though they may build differently-shaped trees.**
    **Answer: True.** This is an explicit correctness invariant — the greedy choice made is identical, only the efficiency of finding the two smallest values differs.

13. **A std::priority_queue is a max-heap by default. How is it turned into a min-heap for Huffman coding (needed to always extract the two lowest-frequency nodes)?**
    **Short answer:** By supplying a custom comparator that inverts the default ordering (e.g., `a->freq > b->freq` returns true when `a` should be considered "lower priority" than `b`, making the smallest frequency pop first).

---

## LAB 5 — Dynamic Programming

**Quick theory recap**
- DP requires **optimal substructure** + **overlapping subproblems**. Top-down = memoization (recursion + cache); bottom-up = tabulation (iterative).
- **Rod Cutting:** `r(n) = max over i=1..n of {price[i] + r(n-i)}`. Naive recursion: O(2ⁿ). Memoized/Bottom-up: **Θ(n²)** (n subproblems × O(n) transition work each). Memoized retains O(n) call-stack depth (can stack-overflow at large n); bottom-up has no recursion (safer at scale).
- **Coin Change (bounded supply):** greedy can become *infeasible* (not just suboptimal) when supply is limited; DP required. Complexity ≈ O(amount × Σcounts).
- **0/1 Knapsack:** `dp[i][w] = max(dp[i-1][w], dp[i-1][w-wt[i]]+val[i])`. Time O(n·W) either way; Space O(n·W) for 2D table vs **O(W)** for 1D rolling array. 1D version's capacity loop **must iterate descending** — ascending iteration accidentally turns it into Unbounded Knapsack (reuses items).
- **OBST:** `cost[i][j] = min over r in [i,j] of {cost[i][r-1]+cost[r+1][j]+freq_sum(i,j)}`. Naive (recomputes freq_sum inside root loop): **O(n⁴)**. Optimized (prefix-sum freq_sum, O(1) lookup): **O(n³)**. Knuth's optimization (exploiting root monotonicity, a further/separate technique): O(n²).

### MCQs

1. **What is the time complexity of naive (non-memoized) recursive Rod Cutting, and why?**
   a) O(n²), two nested loops
   b) O(2ⁿ), exponential — it recomputes identical subproblems repeatedly without caching
   c) O(n log n)
   d) O(n), single pass
   **Answer: b.**

2. **Both memoized and bottom-up Rod Cutting achieve Θ(n²) time. What's the key *practical* difference between them?**
   a) They have different time complexities
   b) Memoized (top-down) retains O(n) recursion call-stack depth and can stack-overflow for very large n; bottom-up (iterative) has no such recursion risk
   c) Bottom-up is asymptotically faster
   d) There is no difference
   **Answer: b.** This threshold is OS/stack-size dependent, not a fixed language constant.

3. **Why is Θ(n²) the complexity for both DP variants of rod cutting?**
   **Short answer:** There are n subproblems (`r(0)` through `r(n)`), and each requires an O(n) loop (`max over i=1..n`) to compute — n subproblems × O(n) work each = Θ(n²).

4. **In bounded-supply coin change, why can a pure greedy approach (always take the largest coin the amount and remaining supply allow) fail more severely than in the unlimited-supply case?**
   a) It can't fail — greedy always works
   b) With limited supply, greedy can become entirely infeasible (returns "no solution" / -1) even when a valid solution exists, not merely suboptimal
   c) It only fails when amount is odd
   d) Greedy always finds the exact same answer as DP
   **Answer: b.**

5. **In the 1D space-optimized 0/1 Knapsack DP, why must the capacity loop iterate in descending order?**
   a) It's just a stylistic choice
   b) Descending order ensures `dp[w - weight[i]]` still refers to the *previous item's* value (not already updated for the current item), preventing an item from being counted more than once
   c) Ascending order is actually faster
   d) It has no effect on correctness
   **Answer: b.**

6. **What happens if you mistakenly run the 1D 0/1 Knapsack capacity loop in ascending order?**
   a) Nothing changes
   b) It silently transforms the algorithm into the Unbounded Knapsack problem (items can be reused)
   c) It causes a runtime crash
   d) It makes the algorithm faster with the same result
   **Answer: b.**

7. **What are the time and space complexities of 2D vs. 1D (space-optimized) 0/1 Knapsack?**
   **Short answer:** Both have time O(n·W). Space: 2D table is O(n·W); 1D rolling array is O(W) — dramatic savings at scale (e.g., ~1GB vs. tens of KB for n=5000, W=50000).

8. **In the OBST recurrence, what does `freq_sum(i,j)` represent, and why does recomputing it inside the root-selection loop `r` inflate complexity?**
   **Short answer:** `freq_sum(i,j)` is the sum of key probabilities in range [i,j] — added because attaching a subtree at a new root increases the depth (and thus comparison cost) of every key in that range by one level. It does **not** depend on the choice of root `r`, so recomputing it via a fresh O(n) loop for every candidate `r` adds a redundant O(n) factor, inflating O(n³) → O(n⁴).

9. **What is the complexity of naive vs. optimized OBST, and what change fixes the inflation?**
   a) Naive O(n³), Optimized O(n²), fixed via Knuth's monotonicity
   b) Naive O(n⁴), Optimized O(n³), fixed by precomputing freq_sum once via prefix sums (no monotonicity argument needed)
   c) Naive O(n²), Optimized O(n log n)
   d) Both are O(n³); no difference
   **Answer: b.** Knuth's optimization is a *separate*, further speedup (O(n³)→O(n²)) not implemented in this particular fix.

10. **What is Knuth's optimization for OBST, and what does it exploit?**
    a) Precomputing frequency sums
    b) The monotonicity of optimal roots: `root[i][j-1] ≤ root[i][j] ≤ root[i+1][j]`, which narrows the search range for each root, reducing O(n³) to O(n²)
    c) Using a hash table instead of a 2D array
    d) Sorting keys by frequency first
    **Answer: b.**

11. **What signature empirically distinguishes an O(n⁴) algorithm from an O(n³) algorithm when comparing their runtime curves as n grows?**
    a) The O(n⁴) curve is always exactly 10x slower
    b) The *ratio* between the two curves keeps growing as n increases (not a fixed constant multiple)
    c) They should have identical curves
    d) The O(n³) curve should eventually exceed the O(n⁴) curve
    **Answer: b.**

12. **For rod cutting with `prices = {1,5,8,9}` and n=4 (classic CLRS example), what is the optimal revenue and how is it achieved?**
    **Short answer:** 10, achieved by cutting into two pieces of length 2 each (5+5=10), better than not cutting (price[4]=9) or other combinations.

13. **True/False: Memoization (top-down DP) and tabulation (bottom-up DP) always have identical time complexity for a given problem, differing only in overhead/space characteristics.**
    **Answer: Generally True for these lab problems** — both solve the same set of subproblems; memoized retains recursive call-stack overhead while bottom-up doesn't, but the asymptotic subproblem count × transition cost is the same.

14. **Why does the 0/1 Knapsack 2D table risk running out of memory at large n and W (e.g., n=5000, W=50000), while the 1D version does not?**
    **Short answer:** The 2D table needs `(n+1)×(W+1)` cells (~1GB at that scale), while the 1D table only needs `(W+1)` cells (tens of KB) since each row only depends on the immediately preceding row and can be reused in place.

---

## LAB 6 — Graph Algorithms (MST, Max-Flow, Min-Cut, Matching)

**Quick theory recap**
- **Prim's MST:** grows a tree from one vertex, always adding the cheapest edge crossing the cut between the tree and the rest. Naive (array scan): **O(V²)** — wins on **dense** graphs. Heap-based (lazy deletion, no decrease-key): **O(E log V)** — wins on **sparse** graphs, but push overhead can make it lose to naive on dense graphs.
- **Kruskal's MST:** sorts all edges, adds each if it doesn't form a cycle (checked via Union-Find/DSU). Complexity: **O(E log E)** (sorting dominates), DSU ops with path compression + union by rank are amortized **O(α(n))** ≈ constant.
- Both MST algorithms rely on the **Cut Property** (min-weight edge crossing any cut is safe to add); Kruskal's also uses the **Cycle Property** (max-weight edge in any cycle is never in the MST). MST correctness is unaffected by negative weights.
- **Max-Flow (Ford-Fulkerson/Edmonds-Karp):** repeatedly finds augmenting paths in the residual graph, pushes bottleneck flow. Generic Ford-Fulkerson (any path-finding, e.g. DFS): **O(E·f)** — pseudo-polynomial, bad for large capacities. Edmonds-Karp (BFS-based, shortest augmenting path): **O(VE²)** — truly polynomial.
- **Max-Flow Min-Cut Theorem:** max flow value = min cut capacity (a proven theorem, not coincidence). Min cut = edges crossing from S (vertices reachable from source in the *residual* graph after max-flow) to V\S.
- **Bipartite Matching via Max-Flow:** super-source→left (capacity 1 each), left→right (capacity ∞, original edges), right→super-sink (capacity 1 each). Boundary edges must carry the capacity-1 constraint (not the middle edges) — this is the critical, commonly-flipped modeling detail.
- **Project Selection (closure problem):** source→profitable-block (cap = value), costly-block→sink (cap = |value|), precedence edges get **infinite** capacity (so min-cut never severs them, structurally enforcing "if i is selected, all its prerequisites are too"). Answer = total positive value − min-cut value.

### MCQs

1. **What is the time complexity of Prim's MST using a simple array (no heap), and on what kind of graphs does it perform best?**
   a) O(E log V); sparse graphs
   b) O(V²); dense graphs
   c) O(V + E); all graphs equally
   d) O(E²); sparse graphs
   **Answer: b.**

2. **What is the time complexity of heap-based Prim's MST, and why can it sometimes be *slower* than the naive array version in practice?**
   a) O(E log V); it's always faster than naive, no exceptions
   b) O(E log V); on dense graphs, lazy deletion causes many redundant heap pushes (one per edge relaxation, even for already-settled vertices), and the log V factor plus push/pop overhead can outweigh naive's simplicity
   c) O(V²); it's identical to naive
   d) O(V log V); heap-based is always slower
   **Answer: b.**

3. **What theorem justifies both Prim's and Kruskal's greedy correctness?**
   a) The Max-Flow Min-Cut Theorem
   b) The Cut Property (the minimum-weight edge crossing any cut belongs to some MST)
   c) König's Theorem
   d) The Master Theorem
   **Answer: b.**

4. **What is the time complexity of Kruskal's algorithm, and what dominates it?**
   a) O(V²), dominated by cycle checks
   b) O(E log E), dominated by sorting the edges; DSU operations are nearly O(1) amortized (O(α(n)))
   c) O(E), DSU dominates
   d) O(V + E), dominated by DFS
   **Answer: b.**

5. **What two techniques combine in a Union-Find (DSU) structure to achieve near-constant amortized time per operation, and is either one alone sufficient?**
   **Short answer:** Path compression (flattens the tree on `find`) and union by rank/size (keeps trees shallow on `unite`). Neither alone gives the near-constant O(α(n)) bound — path compression alone or union-by-rank alone still gives O(log n) amortized; **both together** are needed for the inverse-Ackermann bound.

6. **True/False: MST algorithms (Prim's, Kruskal's) require all edge weights to be non-negative.**
   **Answer: False.** Negative weights don't break correctness — only the *relative order* of weights matters for the cut/cycle property arguments.

7. **What does the Max-Flow Min-Cut Theorem state?**
   a) Max flow is always less than min cut
   b) Once a network's max flow is achieved, the max flow value equals the minimum cut capacity separating source and sink
   c) Min cut equals the number of edges in the graph
   d) Max flow only applies to bipartite graphs
   **Answer: b.**

8. **Why is generic Ford-Fulkerson (using DFS for augmenting paths) only pseudo-polynomial (O(E·f), f = max flow value), while Edmonds-Karp (BFS-based) is truly polynomial O(VE²)?**
   **Short answer:** DFS can pick arbitrarily long/inefficient augmenting paths, and with large integer capacities the number of augmentations needed can be proportional to the flow value f itself (not the graph size) — pseudo-polynomial. BFS always finds the *shortest* augmenting path, which bounds the total number of augmentations by O(VE), making the algorithm's complexity depend only on graph size (V, E), not on capacity magnitude.

9. **In a flow network's residual graph, why must every edge (u,v) with capacity C also have a reverse edge (v,u) with initial capacity 0?**
   a) It's optional, just a convention
   b) It allows the algorithm to "undo" a previously suboptimal flow assignment by routing flow back, without which the algorithm could fail to find the true max flow
   c) It doubles the memory usage for no reason
   d) It's required only for undirected graphs
   **Answer: b.**

10. **After running max-flow to completion, how do you find the min cut?**
    a) Try all possible vertex subsets
    b) Find the set S of vertices reachable from the source using edges with positive *residual* capacity in the final residual graph; the min cut consists of original edges crossing from S to V\S
    c) Find vertices reachable from the sink instead
    d) The min cut is always the single most expensive edge
    **Answer: b.** Using "reachable from source" (not "can reach sink") is the specific, commonly-tested subtlety.

11. **In modeling Bipartite Matching as a max-flow problem, where should the capacity-1 constraints go, and why is putting them elsewhere ("infinite at the boundary, unlimited in the middle") wrong?**
    a) Capacity-1 belongs on the left→right (middle) edges
    b) Capacity-1 belongs on the source→left and right→sink (boundary) edges; putting infinite capacity there instead would let one left vertex match multiple right vertices simultaneously, violating the definition of a matching
    c) All edges should have capacity 1
    d) It doesn't matter where capacities go
    **Answer: b.**

12. **True/False: Every bipartite graph has a perfect matching (every left vertex matched to some right vertex).**
    **Answer: False.** A "deficient" matching (not all vertices matched) is a valid, expected outcome for graphs that don't admit a perfect matching — the max-flow approach correctly reports the smaller matching size in that case.

13. **In the Project Selection (open-pit mining / closure) problem's max-flow reduction, why must precedence edges (block i requires block j) get *infinite* capacity rather than just a very large finite capacity?**
    a) Infinite capacity is just a coding convenience
    b) A finite (even if large) capacity could, in some cases, make it cheaper for the min-cut algorithm to sever the precedence edge (paying that finite cost) instead of respecting the constraint — infinite capacity guarantees the cut algorithm can never do this, making constraint violation mathematically impossible
    c) It has no effect on correctness, only performance
    d) It ensures the algorithm terminates faster
    **Answer: b.**

14. **In the Project Selection reduction, what is the formula for optimal net profit?**
    a) Just the min-cut value
    b) Total value of all positive-value blocks minus the min-cut value
    c) Sum of all block values regardless of sign
    d) Max flow value plus total cost
    **Answer: b.**

15. **What is the complexity of the max-flow-based bipartite matching and project-selection algorithms, and what dominates?**
    **Short answer:** O(VE²), dominated by the underlying Edmonds-Karp max-flow computation; the final extraction step (reading off the matching or selected set via one BFS/DFS over the residual graph) is only O(V+E), negligible in comparison.

16. **What is the relationship between maximum bipartite matching size and minimum vertex cover size, per König's Theorem (standard background knowledge for this topic)?**
    a) They are unrelated
    b) In bipartite graphs, they are equal
    c) Vertex cover is always exactly double the matching size
    d) Matching is always larger
    **Answer: b.**

17. **On a sparse graph (low edge density), which MST algorithm is generally preferred, and why?**
    a) Prim's naive (array-based), because it has no heap overhead
    b) Prim's heap-based or Kruskal's — both benefit from sparsity since their complexities (O(E log V), O(E log E)) scale with E, which is small; naive Prim's O(V²) doesn't benefit from sparsity at all
    c) Neither works on sparse graphs
    d) Only Kruskal's works on sparse graphs
    **Answer: b.**

18. **If you increase the capacity of an edge that is NOT part of the current min cut, what happens to the max flow value? Why?**
    **Short answer:** It stays exactly the same — the min cut (the true bottleneck) is unaffected, since only edges *in* the cut constrain the max flow; increasing capacity elsewhere doesn't relax the actual bottleneck.

---

## Answer Key Quick-Reference (Complexity Cheat Sheet)

| Algorithm | Time | Space | Notes |
|---|---|---|---|
| Rotated array min (binary search) | O(log n) | O(1) | one half always sorted |
| Max Subarray (D&C) | O(n log n) | O(n) recursion | vs O(n²) naive |
| Inversion Count (merge-based) | O(n log n) | O(n) | vs O(n²) naive |
| Randomized Quicksort | O(n log n) expected, O(n²) worst | O(log n) | any input |
| Randomized-Select | O(n) expected | O(log n) | |
| Hashing (open addressing) search | O(1/(1-α)) unsuccessful (LP, ideal) | O(m) | α<1 required |
| Dynamic table doubling insert | O(1) amortized, O(n) worst single op | O(n) | ≤3N total for N inserts |
| Two-Stack Queue ops | O(1) amortized, O(n) worst dequeue | O(n) | ≤4 units/element lifetime |
| Coin Change (bounded, DP) | O(amount × Σcounts) | O(amount) | greedy can be infeasible |
| 0/1 Knapsack | O(n·W) | O(n·W) 2D / **O(W) 1D** | descending loop required (1D) |
| OBST | O(n⁴) naive / **O(n³)** optimized / O(n²) Knuth | O(n²) | freq_sum redundancy bug |
| Rod Cutting | O(2ⁿ) naive / **Θ(n²)** DP | O(n) | memo has stack-depth risk |
| Prim's MST (naive / heap) | O(V²) / O(E log V) | O(V) / O(V+E) | naive wins dense, heap wins sparse |
| Kruskal's MST | O(E log E) | O(V+E) | DSU ≈ O(α(n)) amortized |
| Ford-Fulkerson (generic) | O(E·f) pseudo-poly | O(V+E) | f = max flow value |
| Edmonds-Karp | O(VE²) | O(V+E) | BFS augmenting paths |
| Min-Cut (via max-flow) | O(VE²) | O(V+E) | S = source-reachable in residual graph |
| Bipartite Matching (via max-flow) | O(VE²) generic | O(V+E) | boundary edges capacity 1 |
| Project Selection (via min-cut) | O(VE²) | O(V+E) | precedence edges capacity ∞ |

---

## Key Conceptual Contrasts (Frequently Tested)

- **Amortized ≠ Average-case**: amortized is a deterministic worst-case-over-a-sequence guarantee; average-case is a probabilistic claim over random inputs.
- **Greedy-choice property is a property of the problem/input structure, not the cleverness of the heuristic** (coin change: canonical vs. non-canonical systems; Huffman: always optimal regardless of input).
- **Correctness of a greedy choice vs. efficiency of implementing it are separate concerns** (Huffman naive O(N²) vs. heap O(N log N) — same correctness, different efficiency).
- **Theoretical probe-count optimality ≠ empirical wall-clock optimality** (Double Hashing has fewer probes but worse cache locality than Linear Probing).
- **Table dimensions vs. rolling array**: many DP problems (0/1 Knapsack) can drop a dimension via rolling arrays when only the previous row/state is needed — but loop *direction* becomes correctness-critical when doing so.
- **Redundant computation can silently inflate asymptotic complexity** (OBST naive O(n⁴) vs O(n³) — not a logic bug, a complexity bug from recomputing a root-independent value inside the root loop).
- **min-cut is defined by source-reachability in the *residual* graph**, not sink-reachability — a commonly flipped detail.
- **Infinite-capacity edges structurally enforce hard constraints** in flow-based reductions (precedence in Project Selection, per-vertex-once in Bipartite Matching) — this is why min-cut/max-flow are used to *model* combinatorial constraints, not just literal flow problems.
