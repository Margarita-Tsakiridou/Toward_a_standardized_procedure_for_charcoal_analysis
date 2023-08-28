####GENERALIZED LINEAR MIXED MODEL####
#Nested ANOVA - nesting treated as the random effect in order to get significance of Treatment
#on AREA, NUMBERS, CIRC, AR

library(fitdistrplus)
library(lme4)
library(car)

setwd("G:\\My Drive\\3. Paper no. 2 - Chemicals\\4. Sluggan Bog\\2. Data Analysis\\2. Statistical Analysis\\2. GLMM")
data <- read.csv("SB_data.csv", header = TRUE, sep = ",") ##reading the data
#str(data) ##will need to make the previous code produce this data


producingGLMM <- function(x){
  descdist(x, discrete = TRUE)
  formula <- x ~ Treatment + (1|Treatment/Seq/Level) 
  theta <- glm.nb(formula, data=data)
  summary(theta)
  GLMM <- lme4::glmer.nb(formula, data=data, verbose=TRUE)
  significance <- Anova(GLMM, test = "Chisq")
  print(significance)
}

area.s <- producingGLMM(data$Area)
numbers.s <- producingGLMM(data$Numbers)
producingGLMM(data$Circ) #this has normal distribution
producingGLMM(data$AR) #also normal distribution

treatment.significane <- list(area.s, numbers.s)

rm(data, producingGLMM, area.s, numbers.s)
