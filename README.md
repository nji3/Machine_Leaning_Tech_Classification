---
title: "README"
output: 
  html_document:
    keep_md: true
---



## General Information

This repository contains the R version and Python version of the SVM function from scratch. The SVM function constructed here only contains the linear SVM without the bias term and the SVM with the Gaussian Kernel. The opitmization algorithm here used is the Coordinate Ascent.

## Mathmetica Background

The SVM with $L_2$ norm regularization has the loss function based on the hinge loss that
$$
L(\beta)=\sum_{i=1}^nmax(0,1-y_ix_i^T\beta)+\frac{\lambda}{2}|\beta|^2
$$
where the hinge loss could be represented by a continuous mathmatical function:
$$
max(0,1-y_ix_i^T\beta) = max_{\alpha_i\in[0,1]}\alpha_i(1-y_ix_i^T\beta)
$$
We could extract the $\lambda$ out and let $\alpha_i=\frac{\alpha_i}{\lambda}$. Now $\alpha_i\in[0,\frac{1}{\lambda}]$

So to find the $\beta$ we want, we could minimize the new loss function:
$$
\hat{\beta}=argmin_{\beta}L(\beta)=argmin_{\beta}\lambda\sum_{i=1}^nmax_{\alpha_i\in[0,\frac{1}{\lambda}]}\alpha_i(1-y_ix_i^T\beta)+\frac{1}{2}|\beta|^2
$$
This is the Primal problem we want to deal with.

By rotating the $min$ and $max$, we could transfer the Primal problem to a Dual problem that
$$
\begin{aligned}
F(\alpha,\beta) &= argmax_{\alpha_i\in[0,\frac{1}{\lambda}]}min_\beta\sum_{i=1}^n\alpha_i(1-y_ix_i^T\beta)+\frac{1}{2}|\beta|^2\\
&=argmax_{\alpha_i\in[0,\frac{1}{\lambda}]}min_\beta\frac{1}{2}|\beta-\sum_{i=1}^n\alpha_iy_ix_i|^2+\sum_{i=1}^n\alpha_i-\frac{1}{2}|\sum_{i=1}^n\alpha_iy_ix_i|^2\\
min_\beta&\to\beta=\sum_{i=1}^n\alpha_iy_ix_i\\
F(\alpha,\beta)&\to q(\alpha)\\
q(\alpha)&=argmax_{\alpha_i\in[0,\frac{1}{\lambda}]}\sum_{i=1}^n\alpha_i-\frac{1}{2}|\sum_{i=1}^n\alpha_iy_ix_i|^2\\
&=argmax_{\alpha_i\in[0,\frac{1}{\lambda}]}\sum_{i=1}^n\alpha_i-\frac{1}{2}\sum_i^n\sum_j^n\alpha_i\alpha_j y_iy_j<x_i,x_j>
\end{aligned}
$$

The kernel trick can be applied here that $<x_i,x_j>\to<h(x_i),h(x_j)>\to k(x_i,x_j)$

Either way, if you want linear SVM, let $y_iy_j<x_i,x_j>=Q_{ij}$, and if you want Kernel SVM, let $y_iy_jk(x_i,x_j)=Q_{ij}$.

Now out loss function becomes
$$
q(\alpha) = max_\alpha\alpha1_n-\frac{1}{2}\alpha^TQ\alpha
$$
and $beta = \sum_{i=1}^n\alpha_iy_ix_i$


To solve this Dual problem, we would want to use the Coordinate Ascent.

## Dual Coordinate Ascent

Assume $e_i$ is the direction we want to update $\alpha$ in each step, then $e_i=(0,0,...,1,...,0)$. Only the $i^{th}$ direction has 1 and the others are 0.

Then assume $\delta$ is the length we want to update $\alpha_i$, we would have
$$
\begin{aligned}
q(\alpha)&=1^T(\alpha+\delta e_i)-\frac{1}{2}(\alpha+\delta e_i)^TQ(\alpha+\delta e_i)\\
&=const+1^T\delta e_i-\frac{1}{2}(\delta e_i)^TQ\delta e_i-(\delta e_i)^TQ\alpha\\
&=const + 1^T\delta e_i - \frac{1}{2}\delta^2Q_{ii}-(\delta e_i)^TQ\alpha\\
&=-\frac{1}{2}\delta^2Q_{ii}-(\delta e_i)^TQ(\alpha-1)\\
&=-\frac{1}{2}\delta^2Q_{ii}-\delta(Q_i^T\alpha-1)\\
\frac{dq(\alpha)}{d\delta}&=0\\
0&=-\delta Q_{ii}-(Q_i^T\alpha-1)\\
\delta&=\frac{1-Q_i^T\alpha}{Q_{ii}}
\end{aligned}
$$
As a result, the update could be
$$
\alpha_i \to\alpha_i+\frac{1-Q_i^T\alpha}{Q_{ii}}
$$

If $\alpha_i<0,\alpha_i\to0$, If $\alpha_i>\frac{1}{\lambda},\alpha_i\to\frac{1}{\lambda}$.

## Linear SVM with Bias

What if we want to include Bias term?



