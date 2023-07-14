#Modern dataset construction

library(tidyverse)

##creating the dataframe

#1. bringing in each file output

file_paths <- fs::dir_ls("./datasets/Image Analysis output modern")


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


##2. turing it into dataframe and fixing it

df <- plyr::ldply(results, data.frame)
df$Label <- as.character(df$Label)
df$Label <- str_replace_all(df$Label, " \\(RGB\\)", "")
df <- df %>% mutate(timestep = Label,
                    treatment = Label, 
                    replicate = Label)

df$timestep <- substr(df$timestep, 0,1)
df$treatment <- gsub("^(?:[^_]+_){1}([^_]+).*", "\\1", df$treatment)
df$replicate <-  str_sub(df$Label, -5, -5)


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
  
  
  df$timestep = case_when(
    df$timestep == "1" ~ "T0",
    df$timestep == "2" ~ "T1",
    df$timestep == "3" ~ "T2",
    df$timestep == "4" ~ "T3",
    df$timestep == "5" ~ "T4",
    
  )

df <- df %>% dplyr::select(treatment,
                    timestep,
                    replicate,
                    area,
                    number,
                    circ,
                    AR)


factor_vars <- c('treatment',
                 'timestep',
                 'replicate')

df[factor_vars] <- lapply(df[factor_vars], function(x) as.factor(x))

#3. tidying and exporting 

#Writing the results
#write.csv(df, file = "Modern_Dataset.csv")

rm(chemicals, results, factor_vars, file_paths, i, producing.metrics)


#4. Standatdizing it

df1 <- df %>% select(1:4)


test <- df1 %>% filter(treatment == "H2O 12h") %>% 
  pivot_wider(names_from = timestep, values_from = area)



standardize <- function(x){
  z <- (x-mean(x)) / sd(x)
  return(z)
}

test[3:6] <-
  apply(test[3:6], 2, standardize)
