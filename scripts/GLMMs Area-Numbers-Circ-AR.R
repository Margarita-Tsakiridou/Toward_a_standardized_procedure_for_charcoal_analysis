####GENERALIZED LINEAR MIXED MODEL####
#Nested ANOVA - nesting treated as the random effect in order to get significance of Treatment
#on AREA, NUMBERS, CIRC, AR

setwd("G:\\My Drive\\3. Paper no. 2 - Chemicals\\4. Sluggan Bog\\2. Data Analysis\\2. Statistical Analysis\\2. GLMM")
data <- read.csv("SB_data.csv", header = TRUE, sep = ",") ##reading the data
str(data)


########1.AREA########
Area <- data$Area ##extracting variable of interest - Area, to determine distr
library(fitdistrplus)
descdist(Area, discrete = TRUE) ##negative binomial distribution it is (discrete = TRUE, finite values)
#Building the GLMM
library(lme4)
kariolIIna <- Area ~ Treatment + (1|Treatment/Seq/Level)    ##random effect --> seq:Treatment & Treatment 
theta <- glm.nb(kariolIIna, data=data)
summary(theta)
GLMM <- glmer.nb(kariolIIna, data=data, verbose=TRUE)
GLMM
#To get the significance of the fixed factors
library(car)
Anova(GLMM, test = "Chisq")
#When nesting the climatic interval --> SO MUCH BETTER
kariolIIna_Area <- Area ~ Treatment + (1|Treatment/Seq/INTERVAL/Level)    ##random effect --> seq:Treatment & Treatment 
theta <- glm.nb(kariolIIna, data=data)
summary(theta)
GLMM <- glmer.nb(kariolIIna, data=data, verbose=TRUE)
GLMM
Anova(GLMM, test = "Chisq")


########2.NUMBERS########
Numbers <- data$Numbers ##extracting variable of interest - Numbers, to determine distr
descdist(Numbers, discrete = TRUE) ##numbers also negative binomial
#Building the GLMM with the climatic interval nested
kariolIIna_Numbers <- Numbers ~ Treatment + (1|Treatment/Seq/INTERVAL/Level)    ##random effect --> seq:Treatment & Treatment 
theta <- glm.nb(kariolIIna, data=data)
summary(theta)
GLMM <- glmer.nb(kariolIIna, data=data, verbose=TRUE)
GLMM
Anova(GLMM, test = "Chisq")


########3.CIRCULARITY########
circ <- data$Circ ##extracting variable of interest - Numbers, to determine distr
descdist(circ, discrete = TRUE) ##this is bad...it's not negative binomial but beta? it is discrete!
#Building the GLMM with the climatic interval nested
kariolIIna_circ <- circ ~ Treatment + (1|Treatment/Seq/INTERVAL/Level)    ##random effect --> seq:Treatment & Treatment 
theta <- glm.nb(kariolIIna, data=data)
summary(theta)
GLMM <- glmer.nb(kariolIIna, data=data, verbose=TRUE)
GLMM
Anova(GLMM, test = "Chisq")


########4.Aspect Ratio########
AR <- data$AR ##extracting variable of interest - Numbers, to determine distr
descdist(AR, discrete = TRUE) ##this is bad...it's not negative binomial but beta? it's not discrete!
#Building the GLMM with the climatic interval nested
kariolIIna_AR <- AR ~ Treatment + (1|Treatment/Seq/INTERVAL/Level)    ##random effect --> seq:Treatment & Treatment 
theta <- glm.nb(kariolIIna, data=data)
summary(theta)
GLMM <- glmer.nb(kariolIIna, data=data, verbose=TRUE)
GLMM
Anova(GLMM, test = "Chisq")

