
'#This code reproduces many of the analysis steps carried out for the paper 
"Toward a standardized procedure for charcoal analysis" doi:10.1017/qua.2020.56.
It includes all the steps labeled as carried out in R in the paper.
It is split in two main parts

Part 1 - Modern Charcoal

The code produces the the modern charcoal dataset from the output 
of the batch processing of charcoal images on ImageJ.'

source("./scripts/modern_dataset.R")

'#It then plots the above standardized dataset to showcase differences on the effects of chemicals.'

source("./scripts/modern_plotting.R")

'#Note:
The mixed between within subject ANOVA used in the paper is not included in this code, for now,
as at the time it was carried out in SPSS.


Part 2 - Fossil Charcoal

The code produces the fossil charcoal dataset from the output 
of the batch processing of charcoal images on ImageJ.'

source("./scripts/fossil_dataset.R")

'#Finally, the code tests the significance of the effect of different treatments on the fossil sequences.'

source("./script/fossil_stats.R")


'##Still to fix
1.Modern dataset - have forgotten the replicate column - needs to look like the other ds
2.Df_st - make this come straight from df + fix boxplots to look more pretty
3.df_fossil - make it look like the other ID, treatment, depth, etc.
4.Significance - make it come out as a list 
Turn to RMarkDown for viva
testing renaming with connections

