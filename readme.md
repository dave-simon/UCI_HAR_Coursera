---
title: "Readme.MD"
author: "Davi Simon"
date: "20 de fevereiro de 2015"
output: html_document
---


## Getting and Cleaning Data - Course Project

In order to complete the project, one had to go to the following URL for the source data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full discription of the dataset is available at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

According to the instructions provided by the course, the following activities are performed by the run_analysis.R script:

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 

    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

All of these steps are labeled accordingly in the .R script file.

## Notes

*  The script assumes that the UCIHAR dataset is unzipped in the current directory.

*  According to the course instructions, only variables of mean & standard deviation are selected, through the following commands:

```{r}
index_features <- grep("-mean\\(\\)|-std\\(\\)", features$feat_name, ignore.case=T) 
xcomplete <- xcomplete[, index_features] 
```
 
 Thus, the parenthesis "()" after the variable names are also omitted, in order to simplify the interpretation 
 of variables by R.

*  The script was constructed through testing different possibilities, and considers that the dplyr, data.table & reshape2 packages are installed and running.


Constructed with the following version of R

```{r}
> version
               _                           
platform       x86_64-apple-darwin13.4.0   
arch           x86_64                      
os             darwin13.4.0                
system         x86_64, darwin13.4.0        
status                                     
major          3                           
minor          1.2                         
year           2014                        
month          10                          
day            31                          
svn rev        66913                       
language       R                           
version.string R version 3.1.2 (2014-10-31)
nickname       Pumpkin Helmet 

at [1] "Fri Feb 20 18:04:18 2015"

```

The script file run_analysis.R results on tidydata.txt and tidydatamean.txt files. 