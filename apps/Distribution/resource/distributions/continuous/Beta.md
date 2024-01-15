---
title: "Beta"
author: "Terence, Jun-Jie Liu"
date: "6/4/2021"
---

$\text{Beta Distribution: } X \sim Beta(\alpha, \beta)$

* p.d.f and Support: $f(x) = \frac{\Gamma(a+b)}{\Gamma(a)\Gamma(b)} x^{\alpha - 1} (1 - x)^{\beta - 1}, \ x \in (0, 1)$
* c.d.f $F(x) = \frac{B(x; \alpha, \beta)}{B(\alpha, \beta)}, \; x \in (0, 1)$ where $x \mapsto B(x;\alpha, \beta)$ is the incomplete beta function
* mean: $\mu = \frac{\alpha}{\alpha + \beta}$
* Variance: $\frac{\mu (1 - \mu)}{\alpha + \beta + 1}$