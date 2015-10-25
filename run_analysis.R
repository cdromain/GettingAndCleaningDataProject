## GETTING AND CLEANING DATA - PROJECT
## Analysis script

## Loading packages
library(dplyr)

## Reading the training and test data sets into 2 data frames
print("Reading in the training set...")
trainSet <- read.table(file = "./UCI HAR Dataset/train/X_train.txt", sep = "")
trainSubject <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt")
trainActivity <- read.table(file = "./UCI HAR Dataset/train/y_train.txt")
trainSet <- cbind("subject" = trainSubject[,1], "activity" = trainActivity[,1], 
                  trainSet)
print("Done !")
cat("\n")

print("Reading in the test set...")
testSet <- read.table(file = "./UCI HAR Dataset/test/X_test.txt", sep = "")
testSubject <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt")
testActivity <- read.table(file = "./UCI HAR Dataset/test/y_test.txt")
testSet <- cbind("subject" = testSubject[,1], "activity" = testActivity[,1], 
                 testSet)
print("Done !")
cat("\n")

## STEP 1 : Merging the training and test data sets into a single data frame
suppressMessages(mergedSet <- full_join(trainSet, testSet))
print("STEP 1 : Merging the training and test data sets - done !")
print(c("trainSet dimensions :", dim(trainSet)))
print(c("testSet dimensions :", dim(testSet)))
print(c("mergedSet dimensions :", dim(mergedSet)))
cat("\n")

## Reading the features names and adding them to the merged data set
featuresNames <- read.table(file = "./UCI HAR Dataset/features.txt")
names(mergedSet)[3:563] <- as.character(featuresNames[,2])

## Removing columns with duplicated names
mergedSet <- mergedSet[, !duplicated(names(mergedSet))]
print("Removed colums with duplicated names !")
print(c("mergedSet new dimensions :", dim(mergedSet)))
cat("\n")

## STEP 2 : Extracting the relevant columns into a new data frame
selectedSet <- select(mergedSet, subject, activity, contains("mean()"), 
                      contains("std()"))
print("STEP 2 : Selecting only the subject, activity, mean() and std() columns - done !")
print(c("selectedSet dimensions :", dim(selectedSet)))
cat("\n")

## STEP 3 : Naming the activities using the appropriate labels
activityLabels <- read.table(file = "./UCI HAR Dataset/activity_labels.txt")

print("STEP 3 : Naming the activities using the appropriate labels...")

for(i in 1:nrow(selectedSet)) {
        temp <- selectedSet[i, 2] 
        selectedSet[i, 2] <- as.character(activityLabels[temp, 2])
}

selectedSet$activity <- factor(selectedSet$activity, levels = c("WALKING", 
                                                        "WALKING_UPSTAIRS", 
                                                        "WALKING_DOWNSTAIRS", 
                                                        "SITTING", "STANDING", 
                                                        "LAYING"))
print("Done !")
cat("\n")

## STEP 4 : Renaming the data set variables to make them more descriptive
print("STEP 4 : Renaming the data set variables to make them more descriptive...")

replaceDF <- data.frame("before" = c("\\()", "\\-", "\\bt", "\\bf", "X\\b", "Y\\b", 
                                     "Z\\b", "Acc", "Mag", "Gyro", "std", "Body", 
                                     "Gravity", "Jerk", "bodybody"), 
                         "after" = c("", "", "time", "frequency", "x", "y", "z", 
                                     "acceleration", "magnitude", "gyroscope", 
                                     "standarddeviation", "body", "gravity", 
                                     "jerk", "body"), 
                        stringsAsFactors = FALSE)

for(i in 1:nrow(replaceDF)) {
        names(selectedSet)[3:68] <- gsub(replaceDF[i, 1], replaceDF[i, 2], 
                                   names(selectedSet)[3:68])
}

print("Done !")
cat("\n")

## STEP 5 : creating a tidy data set with the average of each variable 
## for each activity and each subject
print("STEP 5 : Creating a tidy data set with the average of each variable for each activity and each subject...")

groupedSet <- group_by(selectedSet, subject, activity)
tidySet <- summarise_each(groupedSet, funs(mean))

tidySet$subject <- factor(tidySet$subject)

print("Done !")
print(c("tidySet dimensions :", dim(tidySet)))
cat("\n")

write.table(tidySet, file = "tidySet.txt", row.names = FALSE)

print("Tidy data set created and exported as a text file ! End of the analysis. Bye !")
cat("\n")
