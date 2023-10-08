####GENERALIZED LINEAR MIXED MODEL####
#Nested ANOVA - nesting treated as the random effect in order to get significance of Treatment
#on AREA, NUMBERS, CIRC, AR


##############################################################
##                 building the function                   ##
#############################################################

producingGLMM <- function(x){
  
  fitdistrplus::descdist(x, discrete = TRUE)
  
  formula <- x ~ treatment + (1|treatment/sequence/levels) 
  
  theta <- MASS::glm.nb(formula, data=sluggan)
  
  summary(theta)
  
  GLMM <- lme4::glmer.nb(formula, data=sluggan, verbose=TRUE)
  
  significance <- car::Anova(GLMM, test = "Chisq")
  
  print(significance)

}


##############################################################
##                    results time!!                       ##
#############################################################


area.s <- producingGLMM(sluggan$area) #effect on area not significant

#checking the other proxies
numbers.s <- producingGLMM(sluggan$number)
#producingGLMM(sluggan$circ) #normal
#producingGLMM(sluggan$AR) #here there is some significance but distribution  

#outputting
statistical_results_fossil <- list(area.s, numbers.s)


rm(sluggan, producingGLMM, area.s, numbers.s)
