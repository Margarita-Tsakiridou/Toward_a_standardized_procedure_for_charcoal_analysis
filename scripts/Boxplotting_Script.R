library(stringr)

str(df_results)
df_results %>% mutate(Label_Timestep = Label, Label_Treatment = Label)


str_sub(df_results$Label_Timestep, 1)








data <- read.csv(file= "data.csv", header=TRUE, sep = ",")
Treatment <- data$Treatment
l<-split(data, Treatment)


H2O12h <- l[[1]]
H2O6h <- l[[2]]
H2O233pc <- l[[3]]
H2O28pc <- l[[4]]
HNO3 <- l[[5]]
KOH <- l[[6]]
Na6PO18 <- l[[7]]
NaCLO12.5 <- l[[8]]
NACLO2.5pc <- l[[9]]

H2O12h <- H2O12h[,4:8]               ###subsetting info from the lists because that's only how I know
H2O6h <- H2O6h[,4:8]
H2O233pc <- H2O233pc[,4:8]
H2O28pc <-H2O28pc[,4:8]
HNO3 <- HNO3[,4:8]
KOH <- KOH[,4:8]
Na6PO18 <- Na6PO18[,4:8]
NaCLO12.5 <- NaCLO12.5[,4:8]
NACLO2.5pc <- NACLO2.5pc[,4:8]


bxp_H2O12h <- boxplot(H2O12h, ylim=c(-3,5))
bxp_H2O6h <- boxplot(H2O6h, ylim=c(-3,5))
bxp_H2O233pc <- boxplot(H2O233pc, ylim=c(-3,5))
bxp_H2O28pc <- boxplot(H2O28pc, ylim=c(-3,5))
bxp_HNO3 <- boxplot(HNO3, ylim=c(-3,5))
bxp_KOH <- boxplot(KOH, ylim=c(-3,5))
bxp_Na6PO18 <- boxplot(Na6PO18, ylim=c(-3,5))
bxp_NaCLO12.5 <- boxplot(NaCLO12.5, ylim=c(-3,5))
bxp_NACLO2.5pc <- boxplot(NACLO2.5pc, ylim=c(-3,5))