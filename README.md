README
================

General Information
-------------------

This repository contains the R version and Python version of the SVM function from scratch. The SVM function constructed here only contains the linear SVM without the bias term and the SVM with the Gaussian Kernel. The opitmization algorithm here used is the Coordinate Ascent.

Mathmetica Background
---------------------

The SVM with *L*<sub>2</sub> norm regularization has the loss function based on the hinge loss that
<p align="center"><img src="/tex/7661fa2b7aa519fd223d82cb0d76af3a.svg?invert_in_darkmode&sanitize=true" align=middle width=486.94671629999993pt height=18.7598829pt/></p>
 where the hinge loss could be represented by a continuous mathmatical function:
*m**a**x*(0, 1 − *y*<sub>*i*</sub>*x*<sub>*i*</sub><sup>*T*</sup>*β*)=*m**a**x*<sub>*α*<sub>*i*</sub> ∈ \[0, 1\]</sub>*α*<sub>*i*</sub>(1 − *y*<sub>*i*</sub>*x*<sub>*i*</sub><sup>*T*</sup>*β*)
 We could extract the *λ* out and let <img src="/tex/6230e8dbeb6459b78ed810826f1be65d.svg?invert_in_darkmode&sanitize=true" align=middle width=138.07312695pt height=85.29680939999997pt/>. Now <img src="/tex/60e2c9088020f577ef951ce8f0339c8b.svg?invert_in_darkmode&sanitize=true" align=middle width=94.36304954999999pt height=124.74886379999998pt/>

So to find the *β* we want, we could minimize the new loss function:
<p align="center"><img src="/tex/565ed6577eb997371970789086a27343.svg?invert_in_darkmode&sanitize=true" align=middle width=690.9551615999999pt height=131.50684965pt/></p>
 This is the Primal problem we want to deal with.

By rotating the *m**i**n* and *m**a**x*, we could transfer the Primal problem to a Dual problem that
<p align="center"><img src="/tex/8a7fd04ac93e8cbde38e8cc7efcc7afa.svg?invert_in_darkmode&sanitize=true" align=middle width=579.17624325pt height=1011.6895008pt/></p>

The kernel trick can be applied here that &lt;*x*<sub>*i*</sub>, *x*<sub>*j*</sub> &gt; → &lt; *h*(*x*<sub>*i*</sub>),*h*(*x*<sub>*j*</sub>)&gt; → *k*(*x*<sub>*i*</sub>, *x*<sub>*j*</sub>)

Either way, if you want linear SVM, let *y*<sub>*i*</sub>*y*<sub>*j*</sub> &lt; *x*<sub>*i*</sub>, *x*<sub>*j*</sub> &gt; =*Q*<sub>*i**j*</sub>, and if you want Kernel SVM, let *y*<sub>*i*</sub>*y*<sub>*j*</sub>*k*(*x*<sub>*i*</sub>, *x*<sub>*j*</sub>)=*Q*<sub>*i**j*</sub>.

Now out loss function becomes
<p align="center"><img src="/tex/d99e9918a7bce57a844c2710043e44ec.svg?invert_in_darkmode&sanitize=true" align=middle width=400.18573979999996pt height=18.7598829pt/></p>
 and <img src="/tex/ce961d780b7e78b3528f77bd527925bb.svg?invert_in_darkmode&sanitize=true" align=middle width=93.13566239999999pt height=85.29681270000002pt/>

To solve this Dual problem, we would want to use the Coordinate Ascent.

Dual Coordinate Ascent
----------------------

Assume *e*<sub>*i*</sub> is the direction we want to update *α* in each step, then *e*<sub>*i*</sub> = (0, 0, ..., 1, ..., 0). Only the *i*<sup>*t**h*</sup> direction has 1 and the others are 0.

Then assume *δ* is the length we want to update *α*<sub>*i*</sub>, we would have
<p align="center"><img src="/tex/caf5d2f59606a62b66a92c0057ee42fa.svg?invert_in_darkmode&sanitize=true" align=middle width=2940.67600695pt height=18.7598829pt/></p>
 As a result, the update could be
<p align="center"><img src="/tex/95c457ae25dbcaf9d07b51e0d912cd96.svg?invert_in_darkmode&sanitize=true" align=middle width=305.17780919999996pt height=17.8466442pt/></p>

If *α*<sub>*i*</sub> &lt; 0, *α*<sub>*i*</sub> → 0, If <img src="/tex/e9a6f526095a5311e2d4fd2bbf4e11ed.svg?invert_in_darkmode&sanitize=true" align=middle width=98.929182pt height=203.6529759pt/>.

Linear SVM with Bias
--------------------

What if we want to include Bias term?
