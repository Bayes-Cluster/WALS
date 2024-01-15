---
title: "Hello World"
author: "Terence, Jun-Jie Liu"
date: "6/4/2021"
output: pdf_document
---

Let $\bar{\bar{X}} = \frac{\sum_{j=1}^c \sum_{i=1}^{n_j}X_{ij}}{n}$ is grand means, $X_{ij}$ is the $i$-th value in group $j$, $n_j$ is the number of   values in group $j$, $n$ is the total number of values in all groups combined, $c$ is the number of groups $\bar{X}_j$ is the sample mean of group $j$     

* Between Groups Sum of Squares (SSB): $\textbf{SSB} = \sum_{j=1}^{c}n_j \left(\bar{X}_j - \bar{\bar{X}}\right)^2$ and $\textbf{MSB} = \frac{\text{SSB}}{c - 1}$
* Within Groups Sum of Squares (SSW): $\textbf{SSW} = \sum_{j=1}^{c} \sum_{i=1}^{n_j} \left(X_{ij} - \bar{X}_j\right)^2$ and $\textbf{MSW} = \frac{\text{SSW}}{n - c}$
* Within Total Sum of Squares (SST): $\textbf{SST} = \sum_{j=1}^{c} \sum_{i=1}^{n_j} \left(X_{ij} - \bar{\bar{X}}\right)^2$
* Total variation can be split into two parts: $\textbf{SST} = \textbf{SSB} + \textbf{SSW}$

### One-Way ANOVA Assumption

* **Constant variance**: The $p$ populations of values of the response variable (associated with the p treatments) all have the same variance
* **Normality**: The $p$ populations of values of the response variable all have normal distributions
* **Independence**: The samples of experimental units are randomly selected, independent samples

### F Test for Difference Between Group Means

* $\mathbf{F}$ statistics: $\mathbf{F} = \frac{\textbf{MSB}}{\textbf{MSW}} = \frac{\textbf{SSB}/c-1}{\textbf{SSW}/n - c}$
* The p-value is the area under the $\mathbf{F}$ curve to the right of $\mathbf{F}$, where the $\mathbf{F}$ curve has $p – 1$ numerator and $n – p$ denominator degrees of freedom

### One-Way ANOVA Table

| Source of Variation 	|        SS       	| degree of freedom ($df$) 	|             MS             	|              $\mathbf{F}$ Statistic              	|
|:-------------------:	|:---------------:	|:------------------------:	|:--------------------------:	|:------------------------------------------------:	|
|    Between Group    	|       SSB       	|           c - 1          	| $\frac{\text{SSB}}{c - 1}$ 	| $\mathbf{F} = \frac{\textbf{MSB}}{\textbf{MSW}}$ 	|
|     Within Group    	|       SSW       	|           n - c          	| $\frac{\text{SSW}}{n - c}$ 	|                                                  	|

* $c$ is the number of groups
* $n$ is sum of the sample sizes from all groups 
* $df$ is degree of freedom
