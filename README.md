# Machine_Leaning_Tech_Classification

Currently the repo contains:

1. [SVM_Gaussian](#svm_gaussian): SVM and SVM with Gaussian Kernel

2. [XGBoost](#xgboost): boosting tree regressor

## SVM_Gaussian
-------------------

### General Information

This repository contains the R version and Python version of the SVM function from scratch. The SVM function constructed here only contains the linear SVM without the bias term and the SVM with the Gaussian Kernel. The opitmization algorithm here used is the Coordinate Ascent.

### Mathmetica Background

The SVM with L2 norm regularization has the loss function based on the hinge loss that

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function1.gif" </img> 
</div>

where the hinge loss could be represented by a continuous mathmatical function:

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function2.gif" </img> 
</div>

So we could minimize the new loss function:

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function3.gif" </img> 
</div>

This is the Primal problem we want to deal with.

By rotating the min and max, we could transfer the Primal problem to a Dual problem that

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function4.gif" </img> 
</div>

The kernel trick can be applied here that

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function5.gif" </img> 
</div>

Either way, if you want linear SVM, let

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function6.gif" </img> 
</div>

and if you want Kernel SVM, let

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function7.gif" </img> 
</div>

Now our loss function becomes

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function8.gif" </img> 
</div>

To solve this Dual problem, we would want to use the Coordinate Ascent.

### Dual Coordinate Ascent

Assume

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function9.gif" </img> 
</div>

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function10.gif" </img> 
</div>

As a result, the update could be

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function11.gif" </img> 
</div>

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function12.gif" </img> 
</div>

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function13.gif" </img> 
</div>

### Linear SVM with Bias

What if we want to include Bias term?

One thing need to be taken care of is that if we include Bias, we won't want to penalize it. There is no information about the relation between the predictor variable and response variable in the bias term. Then we would see our modified loss function:

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function14.gif" </img> 
</div>

We will still minimize the inside part first. Because of the bias term, we have one new constrain now, which is

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/function15.gif" </img> 
</div>

The other part still the same. But in the optimization process, we need to maintain this constrain all the time. To do that, there is a simple way. We can just update a pair of the coordinates every step, one plus and one minus the same value. So that the constrain would be maintained.

## XGBoost
-------------------

### Background Information

Boosting technique is also called 'matching pursuit'. In a more intuitive way, the xgboost is a improvement of gradient boost. Though the Xgboost with regularization has a relatively complicated form, in this reopsitory, I will just introduce the form without the regularization terms.

### Mathmatical Derivation

The idea of boosting is to keep training weak classifiers and agreggate them into a strong classifier. The final result would be like a vote from all the selected weak classifiers. Generally, we could choose all different kinds of classifiers, but people would usually use the Tree regressor. Then the object score, which is used to do the final classification, will be in this form:

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/xgb_1.gif" </img> 
</div>

We could write the Loss function of the XGBoost Tree model as

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/xgb_2.gif" </img> 
</div>

We could expand the loss function by the Taylor expansion to the second derivative:

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/xgb_3.gif" </img> 
</div>

Assume

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/xgb_4.gif" </img> 
</div>

Then

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/xgb_5.gif" </img> 
</div>

As a result, the original minimizing problem becomes:

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/xgb_6.gif" </img> 
</div>

Which is just minimizing the weighted squared loss of choosing the Tree regressor classifier. We would notice that it is a kind of iterating reweighted least square where

<div align="center">
        <img src="https://github.com/nji3/Machine_Leaning_Tech_Classification/blob/master/tex/xgb_7.gif" </img> 
</div>

We could notice that if the second derivative is 1, then our loss function is going to be the loss function for the gradient boost.

