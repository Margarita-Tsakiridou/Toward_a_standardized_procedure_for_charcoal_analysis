
'#This code reproduces many of the analysis steps carried out for the paper 
"Toward a standardized procedure for charcoal analysis" doi:10.1017/qua.2020.56.
It includes all the steps labeled as carried out in R in the paper.
It is split in two main parts

Part 1 - Modern Charcoal

The code produces the the modern charcoal dataset from the output 
of the batch processing of charcoal images on ImageJ.'

source("./scripts/Modern_Dataset_Construction.R")

'#It them plots the above standardized dataset to showcase differences on the effects of chemicals.'

source("./scripts/Boxplotting.R")

'#Note:
The mixed between within subject ANOVA used in the paper is not included in this code, for now,
as at the time it was carried out in SPSS.


Part 2 - Fossil Charcoal

The code produces the fossil charcoal dataset from the output 
of the batch processing of charcoal images on ImageJ.'

source("./scripts/Fossil_dataset.R")

'#Finally, the code tests the significance of the effect of different treatments on the fossil sequences.'

source("./script/Fossil_stats.R")


