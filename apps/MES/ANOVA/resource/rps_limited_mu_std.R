#################################################
## Representative Point Computation of         ##
## Normal Distribution with Given mean and Std ##
## Author: Mr Moyuan Huang                     ##
## For more information of Rps, you can check  ##
## https://dst.uic.edu.cn/isci_en/             ##
#################################################


revisedfm <- function(n,mean=0,sd=1){
	p0 = sort(rnorm(n,mean,sd))
	
	myf<-function(b,fc,xL=-Inf,xR=Inf){
  	m = length(b)
  	sum = 0
  	if(m<1){
  		return(NA)
  	}
  	if(m==1){
  		return(integrate(function(x) (x-b[1])^2*fc(x),xL,xR)$value)
  	}
  	for(i in 1:m){
  		if(i==1){
  			sum = sum + integrate(function(x) (x-b[1])^2*fc(x),xL,(b[1]+b[2])/2)$value
  		}else if(i==m){
  			sum = sum + integrate(function(x) (x-b[m])^2*fc(x),(b[m-1]+b[m])/2,xR)$value
  
  		}else{
  			sum = sum + integrate(function(x) (x-b[i])^2*fc(x),(b[i-1]+b[i])/2,(b[i]+b[i+1])/2)$value
  		}
  	}
  	if(is.numeric(sum)==FALSE){
  		print("F")
  	}
  	return(sum)
	}

	
	heq <- function(x){
		h <- rep(NA, 1)
		h[1] <- mean(x)-mean
		h[2] <- var(x)-sd^2
	}

	out1= constrOptim.nl(par=p0, fn=function(x) myf(x,fc = function(i) dnorm(i,mean,sd)),heq=heq)

	return(out1)
}
