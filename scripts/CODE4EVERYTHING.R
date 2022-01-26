setwd("G:\\My Drive\\3. Paper no. 2 - Chemicals\\4. Sluggan Bog\\2. Data Analysis\\1. Raw Data\\ImageJ outputs")
temp = list.files(pattern="*.csv") #telling it to create a list..class: CHARACTER
pic_names.df <- as.data.frame(temp, stringsAsFactors = default.stringsAsFactors()) ##DID IT CLASS: Dataframe, factors!
mydata = lapply(temp, read.csv) #here telling it to actually read it CLASS:LIST

########1.AREA########
area_column <- lapply(mydata, "[[" , 2) #here telling it to extract the second column aka AREA
sumarea <- lapply(area_column, sum) #here telling it to find the sums IT's A LIST
sumarea1 <- as.data.frame(sumarea) ##I made it a dataframe (dimsumarea 1,179)
AREA <- t(sumarea1)
final_area <- cbind(pic_names.df, AREA)
write.csv(final_area, file = "1.Area.csv", row.names = FALSE)


########2.NUMBERS########
number_column <- lapply(mydata, nrow) #here telling it to find the number of the rows
numbers.id <- as.data.frame(number_column) ##I made it a dataframe (dims 1,179)
numbers.id1 <- t(numbers.id) ##I transposed it to not be 179 columns but it becomes a matrix?
NUMBERS <- as.data.frame(numbers.id1) #data frame, 179 columns, DIM 179 rows 1 column ##SO IF I ADD A COLUMN WITH FOR NAMES
final_numbers <- cbind(pic_names.df, NUMBERS)
write.csv(final_numbers, file = "2.Numbers.csv", row.names = FALSE)


########3.CIRCULARITY########
circ_column <- lapply(mydata, "[[" , 7) #here telling it to extract the CIRC column
circ_list <- lapply(circ_column, mean) #here telling it to find the mean IT's A LIST
mean_circ.id <- as.data.frame(circ_list) ##I made it a dataframe (dimsumarea 1,179)
mean_circ.id1 <- t(mean_circ.id) ##I transposed it to not be 179 columns but it becomes a matrix?
CIRC <- as.data.frame(mean_circ.id1) #data frame, 179 columns, DIM 179 rows 1 column ##SO IF I ADD A COLUMN WITH FOR NAMES
final_circ <- cbind(pic_names.df, CIRC)
write.csv(final_circ, file = "3.CIRC.csv", row.names = FALSE )


########4.ASPECTRATIO########
AR_column <- lapply(mydata, "[[" , 13) #here telling it to extract the CIRC column
AR_list <- lapply(AR_column, mean) #here telling it to find the mean IT's A LIST
mean_AR.id <- as.data.frame(AR_list) ##I made it a dataframe (dimsumarea 1,179)
mean_AR.id1 <- t(mean_AR.id) ##I transposed it to not be 179 columns but it becomes a matrix?
AR <- as.data.frame(mean_AR.id1) #data frame, 179 columns, DIM 179 rows 1 column ##SO IF I ADD A COLUMN WITH FOR NAMES
final_AR <- cbind(pic_names.df, AR)
write.csv(final_AR, file = "4.AR.csv", row.names = FALSE )

########5.BIG DATASET########
SB_results <- cbind(pic_names.df, AREA, NUMBERS, CIRC, AR)
colnames(SB_results) <- c("SAMPLE_ID", "AREA", "NUMBERS", "CIRC", "AR")
write.csv(SB_results, file = "__SBresults__.csv", row.names = FALSE)
