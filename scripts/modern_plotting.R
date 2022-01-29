
#Normalizing the modern dataset
#I need some code that will be able to do this for T1
#For now importing the dataset


'#1st_try_worked_but scaling is based on T0 rather than within each individual tt

slaed <- list()

for (i in 1:length(l)) {
  slaed[[i]] <- scale(l[[i]][3])
}
slaed <- setNames(slaed, names(l))


2nd_try_could not make it work-ideally list within a list and better indexing of the lists
df1 <- mutate(df, tt = paste(treatment, timestep))
df1$tt <- as.factor(df1$tt)
l<-split(df1, df1$tt)
list <- l

l <- split(df1, df1$tt)
m <- split(l, l[8] )#'

           
stdf <- read.csv("./datasets/standardization/data.csv") %>% pivot_longer(cols=4:8, names_to="timestep", values_to="area")
  
modernplot <- ggplot(stdf, aes(x=area, y=timestep))+
  geom_boxplot() + coord_flip() + facet_wrap(stdf$Treatment)

#split them in 6h vs 12h
#arrange them in the facets better
#lose the grid etc from behind
#note limits before where -3,5
