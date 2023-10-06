
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


df_slug$.id <- gsub("./datasets/Image Analysis output fossil/",
                    "", 
                    df_slug$.id)


df_slug1 <- df_slug %>% 
  mutate(pic_label = .id) %>% 
  separate(.id, into = c("sequence", "levels"), sep = "_")

df_slug1$levels <- gsub(".csv", "", df_slug1$levels)

df_slug2 <- df_slug1 %>%
  separate(levels, into = c("top", "bottom", sep = "-"))



