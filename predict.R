
pred <- function(y)
{
  master <- read.csv('data/winewashed.csv', header = T, check.name = F)
  master.spec <- master[,-1:-3]
  m3g.standard <- read.csv("data/m3g standard.csv", header = T, check.name = F)
  tip.standard <- read.csv("data/Qu + CA standard.csv", header = T, check.name = F)

  m3g <- data.frame(master$M3Gs, master.spec[,201:471])
  colnames(m3g) <- c('M3Gs', c(430:700))
  
  m3g.prime <- master.spec$'520'/m3g.standard$'520'
  m3g.standard <- as.matrix(m3g.standard)
  m3g.prime <- as.matrix(m3g.prime)
  m3g.spec <- data.frame(m3g.prime%*%m3g.standard[,1:290], master.spec[,291:471])
  colnames(m3g.spec) <- c(c(230:700))
  
  tip.spec <- master.spec[,1:200] - m3g.spec[,2:201]
  tip <- data.frame(master$TIPs, tip.spec)
  colnames(tip) <- c("TIPs", c(230:429))

  pc <- data.frame(master$PCs, tip.spec)
  colnames(pc) <- c("PCs", c(230:429))
  
  pc.svm <- svm(PCs~., data = pc, cost = 0.004, kernel = "linear", type = "nu-regression")
  tip.svm <- svm(TIPs~., data = tip, cost = 0.004, kernel = "linear", type = "nu-regression")
  m3g.svm <- svm(M3Gs~., data = m3g, cost = 0.004, kernel = "linear", type = "nu-regression")
  
  predict.pc <- predict(pc.svm, y)
  predict.tip <- predict(tip.svm, y)
  predict.m3g <- predict(m3g.svm, y)
  
  sum.test <- data.frame(format(round(predict.m3g, 1), nsmall = 1), 
                         format(round(predict.pc, 1), nsmall = 1), format(round(predict.tip, 1), nsmall = 1))
  colnames(sum.test) <- c('Anthocyanins (mg/L Malv EQ)', 'Tannins (mg/L CE)', 'Total Iron Reactive phenolics (mg/L CE)')
  
  sum.test
}
