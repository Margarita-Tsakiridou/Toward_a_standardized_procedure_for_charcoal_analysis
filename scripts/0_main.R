# Packages used

'# install.packages(c("tidyverse",
                "rstatix",
                "ggpubr",
                 "fitdistrplus",
                 "lme4",
                 "car"))'

library(tidyverse)

# Part 1 - Modern Charcoal

source("./scripts/1_modern_dataset.R", echo = FALSE)
source("./scripts/2_modern_stats.R", echo = FALSE)

# Part 2 - Fossil Charcoal

source("./scripts/3_fossil_dataset.R", echo = FALSE)
source("./scripts/4_fossil_stats.R")
