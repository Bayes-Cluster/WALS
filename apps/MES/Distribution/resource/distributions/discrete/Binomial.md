---
title: "Binomial"
author: "Terence, Jun-Jie Liu"
date: "6/4/2021"
---

$$\text{Binomial Distribution: } X\sim Bin(n, p)$$

* p.d.f and Support: $f(x) = {n \choose x} p^x (1 - p)^{n - x}, \; x \in \{0, 1, \ldots, n\}$
* c.d.f: $F(x) = B(1 - p; n - x, x + 1), \; x \in \{0, 1, \ldots, n\}$
* mean: $\displaystyle \mu_x = \sum_{k=0}^n k \cdot P(X = k) = np$
* Variance: $\displaystyle \sigma^2 = \sum_{k=0}^n (k - np)^2 \cdot P(X = k) = npq$