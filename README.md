TRACE
=====

This software is under development.  Please check back later.

Overview
--------

TRACE is a software package for solving continuous optimization problems.  It applies a gradient-based local-search algorithm to attemp to locate a minimizer of

```
min     f(x),
x ∈ Rⁿ
```

where ```f``` is twice-continuously differentiable.

TRACE is written in Matlab.  The main authors are [Frank E. Curtis](http://coral.ise.lehigh.edu/frankecurtis/), [Daniel P. Robinson](https://coral.ise.lehigh.edu/danielprobinson/), and [Qi Wang](https://coral.ise.lehigh.edu/qiw420/).  For a list of all contributors, please see the [AUTHORS file](TRACE/AUTHORS).

Citing TRACE
------------

TRACE is provided free of charge so that it might be useful to others.  Please send e-mail to [Frank E. Curtis](mailto:frank.e.curtis@lehigh.edu) with success stories or other feedback.  If you use TRACE in your research, then please cite the following papers:

- [Frank E. Curtis, Daniel P. Robinson, and Mohammadreza Samadi. "A Trust Region Algorithm with a Worst-Case Iteration Complexity of O(eps^(-3/2)) for Nonconvex Optimization." *Mathematical Programming*. 162:1–32, 2017.](https://link.springer.com/article/10.1007/s10107-016-1026-2)
- [Frank E. Curtis and Qi Wang.  "Worst-Case Complexity of TRACE with Inexact Subproblem Solutions for Nonconvex Smooth Optimization." arXiv preprint 2204.11322, 2022.](https://arxiv.org/abs/2204.11322)
