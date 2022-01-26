####GENERALIZED LINEAR MIXED MODEL####
#Nested ANOVA - nesting treated as the random effect in order to get significance of Treatment

setwd("G:/My Drive/3. Paper no. 2 - Chemicals/4. Sluggan Bog/2. Data Analysis/2. Statistical Analysis/2. GLMM")
data <- read.csv("SB_data.csv", header = TRUE, sep = ",") ##reading the data
str(data)
Area <- data$Area ##extracting variable of interest - Area, to determine distr

####To determine the distribution####
library(fitdistrplus)
descdist(Area, discrete = TRUE) ##negative binomial distribution it is (discrete = TRUE, finite values)

####Building the GLMM####

kariolIIna <- Area ~ Treatment + (1|Treatment/Seq/INTERVAL/Level)    ##random effect --> seq:Treatment & Treatment 
theta <- glm.nb(kariolIIna, data=data)
summary(theta)

library(lme4)
GLMM <- glmer.nb(kariolIIna, data=data, verbose=TRUE)
GLMM


####To get the significance of the fixed factors####
install.packages("car")
library(car)
Anova(GLMM, test = "Chisq")
