# SVM_Gaussian

General Information
-------------------

This repository contains the R version and Python version of the SVM function from scratch. The SVM function constructed here only contains the linear SVM without the bias term and the SVM with the Gaussian Kernel. The opitmization algorithm here used is the Coordinate Ascent.

Mathmetica Background
---------------------

The SVM with L2 norm regularization has the loss function based on the hinge loss that

![Alt Text](https://github.com/nji3/SVM_Gaussian/blob/master/tex/function1.gif)

where the hinge loss could be represented by a continuous mathmatical function:

![Alt Text](https://github.com/nji3/SVM_Gaussian/blob/master/tex/function2.gif)

So we could minimize the new loss function:

![Alt Text](https://github.com/nji3/SVM_Gaussian/blob/master/tex/function3.gif)

This is the Primal problem we want to deal with.

By rotating the min and max, we could transfer the Primal problem to a Dual problem that

![Alt Text](https://github.com/nji3/SVM_Gaussian/blob/master/tex/function4.gif)

The kernel trick can be applied here that

![Alt Text](https://github.com/nji3/SVM_Gaussian/blob/master/tex/function5.gif)

Either way, if you want linear SVM, let

![Alt Text](https://github.com/nji3/SVM_Gaussian/blob/master/tex/function6.gif)

and if you want Kernel SVM, let

![Alt Text](https://github.com/nji3/SVM_Gaussian/blob/master/tex/function7.gif)

Now our loss function becomes

![Alt Text](https://github.com/nji3/SVM_Gaussian/blob/master/tex/function8.gif)

To solve this Dual problem, we would want to use the Coordinate Ascent.

Dual Coordinate Ascent
---------------------

Assume

![Alt Text](https://github.com/nji3/SVM_Gaussian/blob/master/tex/function9.gif)

![Alt Text](https://github.com/nji3/SVM_Gaussian/blob/master/tex/function10.gif)

As a result, the update could be

![Alt Text](https://github.com/nji3/SVM_Gaussian/blob/master/tex/function11.gif)

![Alt Text](https://github.com/nji3/SVM_Gaussian/blob/master/tex/function12.gif)

![Alt Text](https://github.com/nji3/SVM_Gaussian/blob/master/tex/function13.gif)

Linear SVM with Bias
---------------------

What if we want to include Bias term?
