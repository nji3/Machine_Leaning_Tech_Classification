# Distance Function: L2 Norm
dist <- function(X1,X2) t(X1-X2)%*%(X1-X2)

# Gaussian Kernel 
Kernel_Gaussian <- function(X1,X2,tau=1) exp(-tau*dist(X1,X2))

# SVM for Classfication (-1,+1) with Guassian Kernel
SVM_Gaussian <- function(X_train,y_train,lambda=1,tau=1,stop_rate=10^(-6)){
  
  n <- length(y_train)
  
  ## Q is a matrix used to store what we learnt from the data. The combination of kernel and indicators of groups
  Q <- matrix(0,n,n)
  for(i in 1:n){
    for(j in 1:n){
      Q[i,j] <- y_train[i]*y_train[j]*Kernel_Gaussian(X_train[i,],X_train[j,],tau)
    }
  }
  
  ## Alpha is the combination of L2 regularization lambda and the parameter used to represent the hinge loss
  alpha <- runif(n,0,1/lambda)
  
  ## delta is what learnt from the data each time for the coordinate ascent process
  delta <- 1
  
  ## Coordinate ascent process: Each time choose one direction and update until the delta is smaller than the stop rate 
  while(abs(delta)>stop_rate){
    i <- sample(n,1)
    delta <- as.numeric((1-t(Q[i,])%*%alpha))/Q[i,i]
    if(alpha[i] + delta<0) {alpha[i]=0}
    else if(alpha[i] + delta>1/lambda) {alpha[i]=1/lambda}
    else {alpha[i] <- alpha[i] + delta}
    # print(delta)
  }
  
  ## Prediction by combining the supporting vectors
  f_pred <- c()
  for(i in 1:n){
    X1 <- split(X_train,c(row(X_train)))
    X2 <- split(rep(X_train[i,],n),rep(1:nrow(X_train), each = ncol(X_train)))
    K <- mapply(Kernel_Gaussian,X1,X2,tau)
    f_pred[i] <- sum(alpha*y_train*K)
  }
  
  ## The predicted groups
  y_pred <- sign(f_pred)
  
  return(list(alpha=alpha,f.prediction=f_pred,y.train=y_pred))
}

SVM_Prediction <- function(alpha,y_train,X_test,tau=1){
  
  ## Prediction by combining the supporting vectors and the test dataset
  f_pred <- c()
  
  for(i in 1:n){
    X1 <- split(X_test,c(row(X_test)))
    X2 <- split(rep(X_test[i,],n),rep(1:nrow(X_test), each = ncol(X_test)))
    K <- mapply(Kernel_Gaussian,X1,X2,tau)
    f_pred[i] <- sum(alpha*y_train*K)
  }
  
  ## The predicted groups
  y_pred <- sign(f_pred)
  
  return(list(f.pred=f_pred,y.pred=y_pred))
}



### Example

set.seed(123456)

## Training Data
n = 200
x_1 = runif(n)
x_2 = runif(n)
x_3 = runif(n)
X_train = cbind(x_1,x_2,x_3)
f_train = x_1^2+x_2^2+x_3^2-1
y_train = sign(f_train)

## Testing Data
n = 50
x_1 = runif(n)
x_2 = runif(n)
x_3 = runif(n)
X_test = cbind(x_1,x_2,x_3)
f_test = x_1^2+x_2^2+x_3^2-1
y_test = sign(f_test)

output <- SVM_Gaussian(X_train,y_train)
alpha <- output$alpha
table(output$y.train,y_train)
pred <- SVM_Prediction(alpha,y_train,X_test)
table(pred$y.pred,y_test)
