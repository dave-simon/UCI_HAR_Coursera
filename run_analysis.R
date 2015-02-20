#You should create one R script called run_analysis.R that does the following. 

#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# The script assumes that the code is running on the UCI HAR Dataset source directory. 

#SetWD - you should add your own

setwd("~/Dropbox (Pagini)/Documentos/R Stats/2014/Coursera - Data Science Specialization/Geting Data/UCI HAR Dataset")

library(data.table)
library(reshape2)
library(dplyr)

## 1. Merges the training and the test sets to create one data set:
x_train <- read.table("./train/X_train.txt", header = FALSE)
x_test <- read.table("./test/X_test.txt", header = FALSE)
y_train <- read.table("./train/y_train.txt", header = FALSE)
y_test <- read.table("./test/y_test.txt", header = FALSE)
subject_train <- read.table("./train/subject_train.txt", header = FALSE)
subject_test <- read.table("./test/subject_test.txt", header = FALSE)

# Combines data table (train vs test) by rows
xcomplete <- rbind(x_train, x_test)
ycomplete <- rbind(y_train, y_test)
subjectcomplete <- rbind(subject_train, subject_test)

# Load: data column names
features <- read.table("./features.txt")
names(features) <- c('feat_id', 'feat_name')

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
index_features <- grep("-mean\\(\\)|-std\\(\\)", features$feat_name, ignore.case=T) 
xcomplete <- xcomplete[, index_features] 
names(xcomplete) <- gsub("\\(|\\)", "", (features[index_features, 2]))


## 3. Uses descriptive activity names to name the activities in the data set:
activity_labels <- read.table("./activity_labels.txt")
names(activity_labels) <- c('act_id', 'act_name')
ycomplete[, 1] = activity_labels[ycomplete[, 1], 2]

## 4. Appropriately labels the data set with descriptive activity names:
# Read activity labels
names(ycomplete) <- "Activity"
names(subjectcomplete) <- "Subject"

# Combines data table by columns
# length(ycomplete$Activity)  10299
# length(subjectcomplete$Subject) 10299
# dim(xcomplete) [1] 10299    66

AdjDataSet <- cbind(subjectcomplete, ycomplete, xcomplete)

# dim(AdjDataSet) [1] 10299    68

# 5. From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

MeanAdjDataSet <- AdjDataSet %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))
dim(MeanAdjDataSet) # [1] 180  68

# alternative code, abandoned due to being less elegant)
# tidyDataS5 <- AdjDataSet[, c(-1,-2)] 
# tidyDataAVGSet <- aggregate(tidyDataS5,list(AdjDataSet$Subject, AdjDataSet$Activity), mean)
# tidyDataAVGSet <- rename(tidyDataAVGSet, Subject = Group.1, Activity = Group.2)
# dim(tidyDataAVGSet) # [1] 180  68
# str(tidyDataAVGSet)

# Writing text files with the write.table function, as required.

write.table(AdjDataSet, "tidydata.txt", row.names=F)
write.table(MeanAdjDataSet, "tidydatamean.txt", row.names=F)

