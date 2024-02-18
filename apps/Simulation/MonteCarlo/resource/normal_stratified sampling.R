stratifyNorm <- function(n,mean=0,sd=1)
{
  Rps = l2mseRps(n,fc = function(x) dnorm(x,mean,sd))
  lb = c(-Inf,Rps$b)
  #ub = c(Rps$b,Inf)
  u = runif(n)
  ps = Rps$p
  
  x = qnorm(u*ps+pnorm(lb,mean,sd),mean,sd)
  return(x)
}
