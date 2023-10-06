# Packages used

install.packages(c("tidyverse",
                 "rstatix",
                 "ggpubr",
                 "fitdistrplus",
                 "lme4",
                 "car"))


# Part 1 - Modern Charcoal

source("./scripts/1_modern_dataset.R")
source("./scripts/2_modern_dataset_statistics.R")

# Part 2 - Fossil Charcoal

source("./scripts/fossil_dataset.R")
source("./scripts/fossil_stats.R")
