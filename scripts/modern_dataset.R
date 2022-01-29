#Modern dataset construction

library(tidyverse)
library(fs)
library(stringr)
library(plyr)

file_paths <- dir_ls("./datasets/Image Analysis output modern")
chemicals <- list()

for(i in seq_along(file_paths)){
  chemicals[[i]]<-read.csv(file = file_paths[[i]]
  )
}
chemicals <- setNames(chemicals, file_paths)


producing.metrics <- function(x){
  Area <- x %>% group_by (Label) %>% dplyr::summarize(area = sum(Area)) 
  Numbers <-x %>% group_by (Label) %>% dplyr::summarize(number =n())
  Circularity <- x %>% group_by (Label) %>%  dplyr::summarize(circ = mean(Circ.))
  AR <- x %>% group_by (Label) %>%  dplyr::summarize(AR = mean(AR))
  results <- cbind(Area,Numbers[,2], Circularity[2], AR[2])
}


results <- lapply(chemicals, producing.metrics)
df <- ldply(results, data.frame)

df$Label <- as.character(df$Label)
df <- df %>% mutate(timestep = Label, treatment = Label)
df$timestep <- substr(df$timestep, 0,1)
df$treatment <- gsub("^(?:[^_]+_){1}([^_]+).*", "\\1", df$treatment)
#you have forgotten the replicate...insert here

  df$treatment = case_when(
    df$treatment == "15pc" ~ "NaClO 12.5%",
    df$treatment == "2pc" ~ "NaClO 2.5%",
    df$treatment == "8pc" ~ "H2O2 8%",
    df$treatment == "33pc" ~ "H2O2 33%",
    df$treatment == "Hex" ~ "Na6PO18 10%",
    df$treatment == "KOH" ~ "KOH 10%",
    df$treatment == "HNO3" ~ "HNO3 50%",
    df$treatment == "Wat12" ~ "H2O 12h",
    df$treatment == "Wat" ~ "H2O 6h"
    )

str(df)

df <- df %>% select(treatment, timestep, area, number, circ, AR)
#add also treatment, timestep, replicate to be factors. For best practice look to add ID too.

cols <- c("treatment", "timestep")
df[cols] <- lapply(df[cols], factor) 
str(df)

#Writing the results
#write.csv(df, file = "Modern_Dataset.csv")


rm(chemicals, results, file_paths, i, producing.metrics, cols)

