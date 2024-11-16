# Assignment 2: Classify

## Part 1

### dot.s

#### Approach

In the dot.s file, I implemented a custom multiplication function named my_mul, located in the my_mul.s file. The my_mul function uses a straightforward bitwise multiplication approach. It works by iterating over the bits of the multiplicand (stored in register a1) from position 0 to 31. For each iteration, it checks if the least significant bit of a1 (after right-shifting by n positions) is set to 1. If this bit is 1, the multiplier (stored in register a2) is left-shifted by n positions and added to the result register.

---

For example:

```sudo=
a1 := multiplicand
a2 := multiplier

for n range(0, 31):
  if (a1 >> n) & 1:
    result += a2 << n
```

This approach effectively performs multiplication by summing shifted versions of the multiplier, based on the positions of the set bits in the multiplicand.

#### Issue

While implementing my_mul, I encountered issues with register passing. Specifically, in dot.s, only reused registers were saved to stack memory. However, due to the caller-callee convention, I needed to actively preserve registers a0 to a7 and t0 to t6. This caused a bug that took some time to resolve, but I eventually found a solution.
