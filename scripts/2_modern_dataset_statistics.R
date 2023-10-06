
##############################################################
##             separating the two batches                  ##
#############################################################

separating <- function(data = st_df){
  
  batch_6h <- st_df %>% 
    filter(treatment %in% c("H2O 6h",
                            "NaClO 12.5%",
                            "NaClO 2.5%"))
  
  batch_12h <- st_df %>% 
    filter(!(treatment %in% c("H2O 6h",
                              "NaClO 12.5%",
                              "NaClO 2.5%")))
  
  
  batch_list <- list(batch6h = batch_6h, 
                     batch12h = batch_12h)
  
}

data_list <- separating()
rm(separating)



##############################################################
##                 Statistical Analysis                    ##
#############################################################



analysing <- function(df){
  
  #Visualizing the data
  
  bxp <- ggpubr::ggboxplot(df, x = "timestep", y = "area",
                           fill = "treatment", palette = "jco")
  
  #Identifying outliers
  
  # Outliers
  outliers <- df %>% group_by(treatment, timestep) %>% 
    rstatix::identify_outliers(area)
  
  # Shapiro test
  shappiro <- df %>% group_by(treatment, timestep) %>% 
    rstatix::shapiro_test(area)
  
  
  # Normality
  normality <- ggpubr::ggqqplot(df, "area", ggthem = theme_bw()) +
    facet_grid(timestep ~ treatment, labeller = "label_both")
  
  
  #Computation
  
  res.aov <- rstatix::anova_test(data = df,
                                 dv = area,
                                 wid = replicate,
                                 within = c(treatment, timestep))
  
  anv_tbl <- rstatix::get_anova_table(res.aov)
  
  
  # Post-hoc tests
  
  # Effect of treatment at each time point (aka effect of time)
  one.way <- df %>% 
    group_by(timestep) %>% 
    rstatix::anova_test(dv = area, wid = replicate, within = treatment) %>%
    rstatix::get_anova_table() %>% 
    rstatix::adjust_pvalue(method = "bonferroni")
  
  
  #Pairwise comparisons between treatment groups
  
  pwc <- df %>% 
    group_by(timestep) %>% 
    rstatix::pairwise_t_test(area ~ treatment, paired = TRUE,
                             p.adjust.method = "bonferroni") #where last column != "ns"
  # we have statistically significant differences
  
  
  #Visualizing
  
  pwc <- pwc %>% rstatix::add_xy_position(x = "timestep")
  viz <- bxp + 
    ggpubr::stat_pvalue_manual(pwc, tip.length = 0, hide.ns = TRUE) +
    labs(
      subtitle = rstatix::get_test_label(res.aov, detailed = TRUE),
      caption = rstatix::get_pwc_label(pwc)
    )
   
  
  results = list(bxp = bxp,
                 outliers = outliers,
                 normality = normality,
                 shappiro = shappiro,
                 anova_table = anv_tbl,
                 time_effect = one.way,
                 treatment_effect = pwc,
                 results_viz = viz)
  
  
}


statistical_results_modern <- lapply(data_list, analysing)


##############################################################
##                      tidying                            ##
#############################################################

rm(data_list,
   analysing)
