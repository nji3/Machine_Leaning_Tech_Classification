README
================

General Information
-------------------

This repository contains the R version and Python version of the SVM function from scratch. The SVM function constructed here only contains the linear SVM without the bias term and the SVM with the Gaussian Kernel. The opitmization algorithm here used is the Coordinate Ascent.

Mathmetica Background
---------------------

The SVM with *L*<sub>2</sub> norm regularization has the loss function based on the hinge loss that
$$
L(\\beta)=\\sum\_{i=1}^nmax(0,1-y\_ix\_i^T\\beta)+\\frac{\\lambda}{2}|\\beta|^2
$$
 where the hinge loss could be represented by a continuous mathmatical function:
*m**a**x*(0, 1 − *y*<sub>*i*</sub>*x*<sub>*i*</sub><sup>*T*</sup>*β*)=*m**a**x*<sub>*α*<sub>*i*</sub> ∈ \[0, 1\]</sub>*α*<sub>*i*</sub>(1 − *y*<sub>*i*</sub>*x*<sub>*i*</sub><sup>*T*</sup>*β*)
 We could extract the *λ* out and let $\\alpha\_i=\\frac{\\alpha\_i}{\\lambda}$. Now $\\alpha\_i\\in\[0,\\frac{1}{\\lambda}\]$

So to find the *β* we want, we could minimize the new loss function:
$$
\\hat{\\beta}=argmin\_{\\beta}L(\\beta)=argmin\_{\\beta}\\lambda\\sum\_{i=1}^nmax\_{\\alpha\_i\\in\[0,\\frac{1}{\\lambda}\]}\\alpha\_i(1-y\_ix\_i^T\\beta)+\\frac{1}{2}|\\beta|^2
$$
 This is the Primal problem we want to deal with.

By rotating the *m**i**n* and *m**a**x*, we could transfer the Primal problem to a Dual problem that
$$
\\begin{aligned}
F(\\alpha,\\beta) &= argmax\_{\\alpha\_i\\in\[0,\\frac{1}{\\lambda}\]}min\_\\beta\\sum\_{i=1}^n\\alpha\_i(1-y\_ix\_i^T\\beta)+\\frac{1}{2}|\\beta|^2\\\\
&=argmax\_{\\alpha\_i\\in\[0,\\frac{1}{\\lambda}\]}min\_\\beta\\frac{1}{2}|\\beta-\\sum\_{i=1}^n\\alpha\_iy\_ix\_i|^2+\\sum\_{i=1}^n\\alpha\_i-\\frac{1}{2}|\\sum\_{i=1}^n\\alpha\_iy\_ix\_i|^2\\\\
min\_\\beta&\\to\\beta=\\sum\_{i=1}^n\\alpha\_iy\_ix\_i\\\\
F(\\alpha,\\beta)&\\to q(\\alpha)\\\\
q(\\alpha)&=argmax\_{\\alpha\_i\\in\[0,\\frac{1}{\\lambda}\]}\\sum\_{i=1}^n\\alpha\_i-\\frac{1}{2}|\\sum\_{i=1}^n\\alpha\_iy\_ix\_i|^2\\\\
&=argmax\_{\\alpha\_i\\in\[0,\\frac{1}{\\lambda}\]}\\sum\_{i=1}^n\\alpha\_i-\\frac{1}{2}\\sum\_i^n\\sum\_j^n\\alpha\_i\\alpha\_j y\_iy\_j&lt;x\_i,x\_j&gt;
\\end{aligned}
$$

The kernel trick can be applied here that &lt;*x*<sub>*i*</sub>, *x*<sub>*j*</sub> &gt; → &lt; *h*(*x*<sub>*i*</sub>),*h*(*x*<sub>*j*</sub>)&gt; → *k*(*x*<sub>*i*</sub>, *x*<sub>*j*</sub>)

Either way, if you want linear SVM, let *y*<sub>*i*</sub>*y*<sub>*j*</sub> &lt; *x*<sub>*i*</sub>, *x*<sub>*j*</sub> &gt; =*Q*<sub>*i**j*</sub>, and if you want Kernel SVM, let *y*<sub>*i*</sub>*y*<sub>*j*</sub>*k*(*x*<sub>*i*</sub>, *x*<sub>*j*</sub>)=*Q*<sub>*i**j*</sub>.

Now out loss function becomes
$$
q(\\alpha) = max\_\\alpha\\alpha1\_n-\\frac{1}{2}\\alpha^TQ\\alpha
$$
 and $beta = \\sum\_{i=1}^n\\alpha\_iy\_ix\_i$

To solve this Dual problem, we would want to use the Coordinate Ascent.

Dual Coordinate Ascent
----------------------

Assume *e*<sub>*i*</sub> is the direction we want to update *α* in each step, then *e*<sub>*i*</sub> = (0, 0, ..., 1, ..., 0). Only the *i*<sup>*t**h*</sup> direction has 1 and the others are 0.

Then assume *δ* is the length we want to update *α*<sub>*i*</sub>, we would have
$$
\\begin{aligned}
q(\\alpha)&=1^T(\\alpha+\\delta e\_i)-\\frac{1}{2}(\\alpha+\\delta e\_i)^TQ(\\alpha+\\delta e\_i)\\\\
&=const+1^T\\delta e\_i-\\frac{1}{2}(\\delta e\_i)^TQ\\delta e\_i-(\\delta e\_i)^TQ\\alpha\\\\
&=const + 1^T\\delta e\_i - \\frac{1}{2}\\delta^2Q\_{ii}-(\\delta e\_i)^TQ\\alpha\\\\
&=-\\frac{1}{2}\\delta^2Q\_{ii}-(\\delta e\_i)^TQ(\\alpha-1)\\\\
&=-\\frac{1}{2}\\delta^2Q\_{ii}-\\delta(Q\_i^T\\alpha-1)\\\\
\\frac{dq(\\alpha)}{d\\delta}&=0\\\\
0&=-\\delta Q\_{ii}-(Q\_i^T\\alpha-1)\\\\
\\delta&=\\frac{1-Q\_i^T\\alpha}{Q\_{ii}}
\\end{aligned}
$$
 As a result, the update could be
$$
\\alpha\_i \\to\\alpha\_i+\\frac{1-Q\_i^T\\alpha}{Q\_{ii}}
$$

If *α*<sub>*i*</sub> &lt; 0, *α*<sub>*i*</sub> → 0, If $\\alpha\_i&gt;\\frac{1}{\\lambda},\\alpha\_i\\to\\frac{1}{\\lambda}$.

Linear SVM with Bias
--------------------

What if we want to include Bias term?
