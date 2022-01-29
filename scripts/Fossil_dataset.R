#Fossil dataset construction

library(tidyverse)
library(plyr)

file_paths <- dir_ls("./datasets/Image Analysis output fossil")

sluggan <- list()

for(i in seq_along(file_paths)){
  sluggan[[i]]<-read.csv(file = file_paths[[i]]
  )
}
sluggan <- setNames(sluggan, file_paths)

df <- ldply(sluggan, data.frame)

producing.metrics <- function(x){
  Area <- x %>% group_by (.id) %>% dplyr::summarize(area = sum(Area)) 
  Numbers <-x %>% group_by (.id) %>% dplyr::summarize(number =n())
  Circularity <- x %>% group_by (.id) %>%  dplyr::summarize(circ = mean(Circ.))
  AR <- x %>% group_by (.id) %>%  dplyr::summarize(AR = mean(AR))
  results <- cbind(Area,Numbers[,2], Circularity[2], AR[2])
}


df_slug <- producing.metrics(df)

rm(sluggan, df, producing.metrics, i, file_paths)
