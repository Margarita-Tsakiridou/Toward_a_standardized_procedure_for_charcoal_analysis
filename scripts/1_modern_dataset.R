# Modern Data Set
# The script below takes the image analysis output 
# turns it into a long properly formatted data frame,
# standardizes it and plots is

library(tidyverse)


##############################################################
##            bringing in the data needed                  ##
#############################################################

file_paths <- fs::dir_ls("./datasets/Image Analysis output modern")


chemicals <- list()

for(i in seq_along(file_paths)){
  chemicals[[i]]<-read.csv(file = file_paths[[i]]
  )
}

chemicals <- setNames(chemicals, file_paths)


producing.metrics <- function(x){
  
  area <- x %>% 
    group_by (Label) %>% 
    dplyr::summarize(area = sum(Area)) 
  
  numbers <-x %>% 
    group_by (Label) %>% 
    dplyr::summarize(number =n())
  
  circularity <- x %>% 
    group_by (Label) %>%
    dplyr::summarize(circ = mean(Circ.))
  
  AR <- x %>% 
    group_by (Label) %>%  
    dplyr::summarize(AR = mean(AR))
  
  results <- cbind(area, numbers[,2], circularity[2], AR[2])
}

results <- lapply(chemicals, producing.metrics)


##############################################################
##        creating and formatting the data frame           ##
#############################################################


df <- plyr::ldply(results, data.frame)

df$Label <- str_replace_all(df$Label, " \\(RGB\\)", "")

df <- df %>% mutate(timestep = Label,
                    treatment = Label, 
                    replicate = Label)

df$timestep <- substr(df$timestep, 0,1)

df$treatment <- gsub("^(?:[^_]+_){1}([^_]+).*", "\\1", df$treatment)

df$replicate <-  str_sub(df$Label, -5, -5)


  df$treatment = case_when(
    df$treatment == "12.5pc" ~ "NaClO 12.5%",
    df$treatment == "2.5pc" ~ "NaClO 2.5%",
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

raw_df <- df

rm(df,
   chemicals,
   results,
   factor_vars,
   file_paths,
   i,
   producing.metrics)


##############################################################
##                      Standardizing                      ##
#############################################################

raw_list <- split(raw_df, raw_df$treatment)

scaling <- function(df){
  
  df <- df %>% 
    dplyr::select(treatment,
                      timestep,
                      replicate,
                      area) %>% 
    pivot_wider(id_cols = c(treatment, replicate),
                names_from = timestep,
                values_from = area)
  
  T0_mean <- mean(df$T0)
  T0_var <- var(df$T0)
  
  df <- df %>% 
    mutate(across(3:7, 
                  ~ (. - T0_mean) / sqrt(T0_var)))
  
  return(df)
}


st_list <- lapply(raw_list, scaling) 

st_df <- bind_rows(st_list) %>% 
  pivot_longer(3:7,
               names_to = "timestep",
               values_to = "area")

rm(raw_list, scaling, st_list)



##############################################################
##                 tidying and exporting                   ##
#############################################################


if (!dir.exists("./output")){
  dir.create("./output")
}

datasets_list <- list(raw_data = raw_df,
                      standardized_data = st_df) 

writexl::write_xlsx(datasets_list,
                    "./output/charcoal_experiment.xlsx")


rm(datasets_list)


##############################################################
##                        Plotting                         ##
#############################################################

st_df$treatment <- factor(st_df$treatment , levels = c("Na6PO18 10%",
                            "KOH 10%",
                            "HNO3 50%",
                            "H2O2 33%",
                            "H2O2 8%",
                            "H2O 12h",
                            "NaClO 12.5%",
                            "NaClO 2.5%",
                            "H2O 6h"))

modernplot_area <- ggplot(st_df, aes(x=area, y=timestep)) +
  geom_boxplot() + 
  coord_flip() + 
  facet_wrap(st_df$treatment) + 
  xlim(-3,5) + theme_bw()


if (!dir.exists('./figures')) {
  dir.create('./figures')
}

