---
title: "Untitled"
author: "Davi Simon"
date: "20 de fevereiro de 2015"
output: html_document
---

## Course Project - Code Book

This is the code book describing the variables, the data, and any transformations or work performed to clean up the data for the Coursera's Getting and Cleaning Data Course.

The general dataset information (as provided on (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) is the following:

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person   >performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone   >(Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration >and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data >manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for >generating the training data and 30% the test data.

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed>-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has >gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and >gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff >frequency was used. From each window, a vector of features was obtained by calculating variables from the time and >frequency domain.

Check the README.txt file in this repo (sourced from UCI-HAR) for further details about this dataset. 

The treatment of the data in this projject can be detailed as follows:

1. the training and the test sets were merged in order to create one single data set.
2. Only the measurements on the mean and standard deviation for each measurement were considered. This was achieved through the following commands:

```{r}
index_features <- grep("-mean\\(\\)|-std\\(\\)", features$feat_name, ignore.case=T) 
xcomplete <- xcomplete[, index_features] 
```

Note that the parenthesis "()" after the variable names are also omitted, in order to simplify the interpretation 
 of variables by R.

Due to that, the complete dataset (object called AdjDataSet in the run_analysis.R script) was formed with the following specs: 

```{r}
dim(AdjDataSet)
# [1] 10299    68
```

The subject variable is an integer (1-30) identifying the subject of the experiment.

The activity variable included its name with the following possible values.

'laying',
'sitting',
'standing',
'walking',
'walking_downstairs'
'walking_upstairs'

Considering that the two initial columns of the dataset were identifiers of Subject and Activity, the merged data set included 10299 observations of 66 variables, being these variables listed below:

```{r}
names(AdjDataSet[,c(-1,-2)])

#[1] "Subject"                   "Activity"                  "tBodyAcc-mean-X"           "tBodyAcc-mean-Y"          
#[5] "tBodyAcc-mean-Z"           "tBodyAcc-std-X"            "tBodyAcc-std-Y"            "tBodyAcc-std-Z"           
#[9] "tGravityAcc-mean-X"        "tGravityAcc-mean-Y"        "tGravityAcc-mean-Z"        "tGravityAcc-std-X"        
#[13] "tGravityAcc-std-Y"         "tGravityAcc-std-Z"         "tBodyAccJerk-mean-X"       "tBodyAccJerk-mean-Y"      
#[17] "tBodyAccJerk-mean-Z"       "tBodyAccJerk-std-X"        "tBodyAccJerk-std-Y"        "tBodyAccJerk-std-Z"       
#[21] "tBodyGyro-mean-X"          "tBodyGyro-mean-Y"          "tBodyGyro-mean-Z"          "tBodyGyro-std-X"          
#[25] "tBodyGyro-std-Y"           "tBodyGyro-std-Z"           "tBodyGyroJerk-mean-X"      "tBodyGyroJerk-mean-Y"     
#[29] "tBodyGyroJerk-mean-Z"      "tBodyGyroJerk-std-X"       "tBodyGyroJerk-std-Y"       "tBodyGyroJerk-std-Z"      
#[33] "tBodyAccMag-mean"          "tBodyAccMag-std"           "tGravityAccMag-mean"       "tGravityAccMag-std"       
#[37] "tBodyAccJerkMag-mean"      "tBodyAccJerkMag-std"       "tBodyGyroMag-mean"         "tBodyGyroMag-std"         
#[41] "tBodyGyroJerkMag-mean"     "tBodyGyroJerkMag-std"      "fBodyAcc-mean-X"           "fBodyAcc-mean-Y"          
#[45] "fBodyAcc-mean-Z"           "fBodyAcc-std-X"            "fBodyAcc-std-Y"            "fBodyAcc-std-Z"           
#[49] "fBodyAccJerk-mean-X"       "fBodyAccJerk-mean-Y"       "fBodyAccJerk-mean-Z"       "fBodyAccJerk-std-X"       
#[53] "fBodyAccJerk-std-Y"        "fBodyAccJerk-std-Z"        "fBodyGyro-mean-X"          "fBodyGyro-mean-Y"         
#[57] "fBodyGyro-mean-Z"          "fBodyGyro-std-X"           "fBodyGyro-std-Y"           "fBodyGyro-std-Z"          
#[61] "fBodyAccMag-mean"          "fBodyAccMag-std"           "fBodyBodyAccJerkMag-mean"  "fBodyBodyAccJerkMag-std"  
#[65] "fBodyBodyGyroMag-mean"     "fBodyBodyGyroMag-std"      "fBodyBodyGyroJerkMag-mean" "fBodyBodyGyroJerkMag-std"
```

All of these variables represent mean and standard deviation measures. 

More information on these variables can be seen passing the str() function:

```{r}
str(AdjDataSet)
summary(AdjDataSet)
````

These are the variables included in the tidydata.txt and tidydatamean.txt files yielded by the script run_analysis.R. Note that these are all numerical variables, and no transformation or change of any sort was applied to the variables. 

The variable names are the same as the ones in the original dataset, with the exception of the parenthesis "()" after the variable names, which were dropped in order to simplify the interpretation of variables by R.

The object "MeanAdjDataSet" represents an independent tidy data set with the average of each variable for each activity and each subject based on the "AdjDataSet" object. It was constructed with the following code:

```{r}
MeanAdjDataSet <- AdjDataSet %>% group_by(Activity,Subject) %>% summarise_each(funs(mean))
dim(MeanAdjDataSet) # [1] 180  68 - Consistent with 30 subjects each performing 6 activities, yielding 180 observations.
```

As required by the project instructions, the object "MeanAdjDataSet" was written into the tidydatamean.txt file, and the object "AdjDataSet" was written into the tidydata.txt file.


## Variables Complete description


The thorough description of the variables in the complete dataset is available in the "features_info.txt" file that is provides along with the dataset. I opt to transcript the text of that file fur further clarity on the actual meaning of the variables in the complete dataset. Please note that only the variables of mean and standard deviation were selected as part of this assignment.  

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro -XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

> These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

 tBodyAcc-XYZ
 tGravityAcc-XYZ
 tBodyAccJerk-XYZ
 tBodyGyro-XYZ
 tBodyGyroJerk-XYZ
 tBodyAccMag
 tGravityAccMag
 tBodyAccJerkMag
 tBodyGyroMag
 tBodyGyroJerkMag
 fBodyAcc-XYZ
 fBodyAccJerk-XYZ
 fBodyGyro-XYZ
 fBodyAccMag
 fBodyAccJerkMag
 fBodyGyroMag
 fBodyGyroJerkMag

> The set of variables that were estimated from these signals are: 

 mean(): Mean value
 std(): Standard deviation
 mad(): Median absolute deviation 
 max(): Largest value in array
 min(): Smallest value in array
 sma(): Signal magnitude area
 energy(): Energy measure. Sum of the squares divided by the number of values. 
 iqr(): Interquartile range 
 entropy(): Signal entropy
 arCoeff(): Autorregresion coefficients with Burg order equal to 4
 correlation(): correlation coefficient between two signals
 maxInds(): index of the frequency component with largest magnitude
 meanFreq(): Weighted average of the frequency components to obtain a mean frequency
 skewness(): skewness of the frequency domain signal 
 kurtosis(): kurtosis of the frequency domain signal 
 bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
 angle(): Angle between to vectors.

> Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

 gravityMean
 tBodyAccMean
 tBodyAccJerkMean
 tBodyGyroMean
 tBodyGyroJerkMean

> The complete list of variables of each feature vector is available in 'features.txt'
