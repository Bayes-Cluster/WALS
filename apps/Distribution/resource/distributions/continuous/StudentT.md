---
title: "Student t distribution"
author: "Terence, Jun-Jie Liu"
date: "6/4/2021"
---

$\text{t distribution:} X \sim \chi^2(\nu)$

* pdf and Support: $f(x) = \frac{\Gamma \left(\frac{n + 1}{2} \right)} {\sqrt{n \pi} \Gamma \left(\frac{n}{2} \right)} \left(1 + \frac{x^2}{n} \right)^{-\frac{n + 1}{2}}, \; x \in (-\infty, \infty)$; $(-\infty, +\infty)$
* c.d.f: $F(x) = \frac{1}{2} + x \Gamma \left( \frac{n + 1}{2} \right) \frac{\,_2F_1 \left ( \frac{1}{2},\frac{n + 1}{2};\frac{3}{2}; - \frac{x^2}{n} \right)} {\sqrt{\pi n}\,\Gamma \left(\frac{n}{2}\right)}, \; x \in (-\infty, \infty)$
* mean: 0 for $n > 1$
* Variance: $\frac{n}{n - 2}$ for $n > 2$
