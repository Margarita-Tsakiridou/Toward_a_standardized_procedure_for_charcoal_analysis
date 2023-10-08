
##############################################################
##            bringing in the data needed                  ##
#############################################################


file_paths <- fs::dir_ls("./datasets/Image Analysis output fossil")

sluggan <- list()

for(i in seq_along(file_paths)){
  sluggan[[i]]<-read.csv(file = file_paths[[i]]
  )
}

sluggan <- setNames(sluggan, file_paths)

df <- plyr::ldply(sluggan, data.frame)


rm(sluggan,
   file_paths,
   i)




##############################################################
##         summarizing and arranging the data              ##
#############################################################


producing.metrics <- function(x){
  
  Area <- x %>% 
    group_by (.id) %>% 
    dplyr::summarize(area = sum(Area))
  
  Numbers <- x %>%
    group_by (.id) %>% 
    dplyr::summarize(number =n())
  
  Circularity <- x %>% 
    group_by (.id) %>%
    dplyr::summarize(circ = mean(Circ.))
  
  AR <- x %>% 
    group_by (.id) %>%  
    dplyr::summarize(AR = mean(AR))
  
  results <- cbind(Area,Numbers[,2], Circularity[2], AR[2])

}


df_slug <- producing.metrics(df)

rm(df,
   producing.metrics)


##############################################################
##              formatting the data set                    ##
#############################################################

sluggan <- df_slug %>% 
  mutate(pic_label = gsub( "./datasets/Image Analysis output fossil/",
                           "",
                           .id)) %>% 
  separate(pic_label, into = c("sequence", "levels"), sep = "_") %>% 
  mutate(treatment = case_when(
    sequence %in% c("A", "H", "I") ~ "H2O2",
    sequence %in% c("B", "G", "J") ~ "NaClO",
    sequence %in% c("C", "F", "K") ~ "HNO3"
  )
  ) %>% 
  rename(pic_label = .id) %>% 
  select(pic_label,
         sequence,
         levels,
         treatment,
         area,
         number,
         circ,
         AR)


sluggan$sequence <- as.factor(sluggan$sequence)
sluggan$treatment <- as.factor(sluggan$treatment)
sluggan$levels <- as.factor(sluggan$levels)

rm(df_slug)
