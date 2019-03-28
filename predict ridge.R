

pred <- function(y)
{
  require(chemometrics)
  require(MASS)
  master <- read.csv('data/winewashed.csv',header = T,check.name = F)
  master <- master[1:200,]
  master.spec <- master[, -1:-3]
  m3g.standard <- read.csv("data/m3g standard.csv", header = T, check.name = F)
  tip.standard <- read.csv("data/Qu + CA standard.csv", header = T, check.name = F)
  
  m3g <- data.frame(master$M3Gs, master[, 274:319])
  colnames(m3g) <- c("M3Gs", c(500:545))
  
  m3g.prime <- master.spec$'520' / m3g.standard$'520'
  m3g.standard <- as.matrix(m3g.standard)
  m3g.prime <- as.matrix(m3g.prime)
  m3g.spec <- data.frame(m3g.prime %*% m3g.standard[, 1:289], master.spec[, 290:471])
  colnames(m3g.spec) <- c(c(230:700))
  
  tip.spec <- master.spec[, 1:200] - m3g.spec[, 1:200]
  tip <- data.frame(master$TIPs, tip.spec)
  colnames(tip) <- c("TIPs", c(230:429))
  
  pc <- data.frame(master$PCs, tip.spec)
  colnames(pc) <- c("PCs", 230:429)
  
  m3g.cal <- lm.ridge(M3Gs~., data = m3g,  lambda = seq(0.01, 50, by = 0.01))
  tip.cal <- lm.ridge(TIPs~., data = tip,  lambda = seq(0.01, 50, by = 0.01))
  pc.cal <- lm.ridge(PCs~., data = pc,  lambda = seq(0.01, 50, by = 0.01))
  
  m3g.opt <- diag(271)*min(m3g.cal$GCV)
  tip.opt <- diag(200)*min(tip.cal$GCV)
  pc.opt <- diag(81)*min(pc.cal$GCV)
  
  m3g.prime.new <- y[290] / m3g.standard[290]
  m3g.standard <- as.matrix(m3g.standard)
  m3g.prime.new <- as.matrix(m3g.prime.new)
  m3g.spec.new <- data.frame(m3g.prime.new %*% m3g.standard[, 1:289], y[, 290:471])
  m3g.spec.new.final <- m3g.spec.new[,201:471]
  colnames(m3g.spec.new.final) <- c(c(430:700))
  
  tip.spec.new <- y[, 1:200] - m3g.spec.new[, 1:200]
  colnames(tip.spec.new) <- c(c(230:429))
  
  pc.prime.new <- tip.spec.new[93] / tip.standard[93]
  tip.standard <- as.matrix(tip.standard)
  pc.prime.new <- as.matrix(pc.prime.new)
  pc.spec.new <- data.frame(tip.spec.new[, 1:81] - pc.prime.new %*% tip.standard[, 1:81])
  colnames(pc.spec.new) <- c(230:310)
  
  m3g.spec.new.final <- as.matrix(m3g.spec.new.final)
  tip.spec.new <- as.matrix(tip.spec.new)
  pc.spec.new <- as.matrix(pc.spec.new)
  
  m3g <- as.matrix(m3g)
  tip <- as.matrix(tip)
  pc <- as.matrix(pc)
  
  m3g.predict <- m3g.spec.new.final%*%(solve(crossprod(m3g[,-1]) + m3g.opt))%*%(t(m3g[,-1])%*%m3g[,1])
  tip.predict <- tip.spec.new%*%(solve(crossprod(tip[,-1]) + tip.opt))%*%(t(tip[,-1])%*%tip[,1])
  pc.predict <- pc.spec.new%*%(solve(crossprod(pc[,-1]) + pc.opt))%*%(t(pc[,-1])%*%pc[,1])
  
  sum.test <- data.frame(m3g.predict, pc.predict, tip.predict)
  colnames(sum.test) <- c('Anthocyanins (mg/L Malv EQ)', 'Tannins (mg/L CE)', 'Total Iron Reactive phenolics (mg/L CE)')
  
  sum.test
}