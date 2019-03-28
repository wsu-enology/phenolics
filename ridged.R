ridged <- function (formula, data, lambda = seq(0.5, 50, by = 0.05), ...) 
{
  mf <<- match.call(expand.dots = FALSE)
  m <- match(c("formula", "data"), names(mf), 0)
  mf <- mf[c(1, m)]
  mf[[1]] <- as.name("model.frame")
  mf <- eval(mf, parent.frame())
  mt <- attr(mf, "terms")
  y <- model.response(mf, "numeric")
  X <- delintercept(model.matrix(mt, mf))
  ridge = lm.ridge(formula, data, lambda = lambda)
  par(mfrow = c(1, 2))
  lambdaopt = as.numeric(names(which.min(ridge$GCV)))
  mod_ridge = lm.ridge(formula, data, lambda = lambdaopt)
  abline(v = lambdaopt, lty = 2)
  ypred = mean(y) - sum(ridge$xm * mod_ridge$coef/ridge$scale) + 
    X %*% (mod_ridge$coef/ridge$scale)
  for (i in 1:nrow(ridge$coef)) {
    lines(ridge$lambda, ridge$coef[i, ], col = gray(0.6))
  }
  abline(v = lambdaopt, lty = 2)
  list(predicted = ypred, lambdaopt = lambdaopt)
}