##Housekeeping
library(tidyverse)
library(fs)
library(plyr)

file_paths <- dir_ls("./datasets/Image Analysis output")
chemicals <- list()

for(i in seq_along(file_paths)){
  chemicals[[i]]<-read.csv(file = file_paths[[i]]
  )
}
chemicals <- setNames(chemicals, file_paths)


#function_production
producing.metrics <- function(x){
  Area <- x %>% group_by (Label) %>% summarize(area = sum(Area)) 
  Numbers <-x %>% group_by (Label) %>% summarize(number =n())
  Circularity <- x %>% group_by (Label) %>%  summarize(circ = mean(Circ.))
  AR <- x %>% group_by (Label) %>%  summarize(AR = mean(AR))
  results <- cbind(Area,Numbers[,2], Circularity[2], AR[2])
}


results <- lapply(chemicals, producing.metrics)
df_results <- ldply(results, data.frame)

#Writing the results
write.csv(df_results, file = "Modern_Dataset.csv")
