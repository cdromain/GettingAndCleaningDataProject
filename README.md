---
title: "Getting and Cleaning Data - Project's README"
author: "Romain Faure"
date: "October 2015"
output: 
  html_document:
    toc: yes 
    toc_depth: 2 
    number_sections: true 
    highlight: tango
---

# Project description

This project is part of the [Getting and Cleaning Data](https://class.coursera.org/getdata-033/) 4-weeks online course offered by the [Johns Hopkins Bloomberg School of Public Health](http://www.jhsph.edu/) (Baltimore, USA) on [Coursera](https://www.coursera.org). [Getting and Cleaning Data](https://class.coursera.org/getdata-033/) is the third course of the 11-months [JH Data Science Specialization](https://www.coursera.org/specialization/jhudatascience/1). 

The purpose of this project is to demonstrate our ability to collect, work with and clean a data set. The goal is to prepare a tidy data set that can be used for later analysis. We were asked to submit : 

1. a tidy data set
2. a link to the [Github repository](https://github.com/cdromain/GettingAndCleaningDataProject) with our script for performing the analysis
3. a [Codebook](https://github.com/cdromain/GettingAndCleaningDataProject/blob/master/CodeBook.md) (called CodeBook.md) describing the variables, the data, and any transformations or work that we performed to clean up the data 
4. **a README.md (this file)** in the repo, explaining how our script works

The data linked to from the course website represent data collected from the Samsung Galaxy S smartphone's accelerometers : "Human Activity Recognition Using Smartphones Dataset" (Version 1.0) by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto, Smartlab - Non Linear Complex Systems Laboratory, DITEN - Università degli Studi di Genova, Italy. A full description is available at [this website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). Please see the accompanying Codebook for more info about the original raw data and the way they were collected. 

# The analysis script

## General information

The analysis script is called "run_analysis.R" and is documented inside the code. It should be placed into the working directory and can then be ran using the ``source("run_analysis.R")`` command. The script expects the original raw data (the folder "UCI HAR Dataset") to be present inside the working directory. The analysis script requires the [dplyr package](https://cran.r-project.org/web/packages/dplyr/index.html) to be installed as it is loaded by the script right at the the beginning.

## Tasks description
   
The script performs the following tasks :

1. Reads the training and test data sets (including their different components, 3 files to be read per set) into 2 data frames using the ``read.table`` function (I specified the ``sep = ""`` argument to read the "X_train.txt" and "X_test.txt" data files).
 
2. Merges the training and test data sets into a single data frame using dplyr's ``full_join`` function. The ``suppressMessages`` command is used to mute dplyr information messages and keep the script output as clean as possible.

3. Reads the features names from the "features.txt" file using the ``read.table`` function and adds them to the merged data set columns names, coercing them into characters with the ``as.character`` command.

4. Removes columns with duplicated names to avoid any issue down the line (duplicated columns names can create problems with dplyr), subsetting the data set with the logical statement ``!duplicated(names(mergedSet))``.

5. Extracts the relevant columns (*subject*, *activity*, mean and standard deviation measurements) into a new data frame. Using the ``contains("mean()"), contains("std()"`` arguments of dplyr's ``select``function, I decided to look for the "mean()" and "std()" strings patterns as it seemed the most reliable way to extract the required measurements, according to the project instructions. This step resulted in the selection of 66 measurements from the original 561 ones.

6. Names the activities using a ``for`` loop which extracts the appropriate descriptive labels from the "activity_labels.txt" file, coerces them into characters with the ``as.character`` command and uses them to replace the activity numeric IDs in the *activity* column. The *activity* variable is then turned into a factor using the ``factor`` command, specifiying the right order with the ``levels`` argument.

7. Renames the data set variables to make them more descriptive (removing brackets, dash, as well as capital letters, and replacing abbreviated words with full words - see the codebook for more info about the variables names) using the ``gsub`` function inside a ``for`` loop.

8. Creates a tidy data set with the average of each variable for each activity and each subject, using dplyr's ``group_by`` and ``summarise_each`` functions. Like *activity* previously, the *subject* column is also turned into a factor using the ``factor`` command as this seems to be the tidiest way to prepare this type of data for downstream analysis. **The resulting set has only one observation per row and one variable per column, respecting the tidy data principes** (see [Hadley Wickham's *Tidy Data* paper](http://vita.had.co.nz/papers/tidy-data.pdf)).

9. Exports the tidy data set as a text file ("tidySet.txt") into the working directory using the ``write.table``function with the ``row.names = FALSE`` argument as required in the project instructions.

## Console output

Once started using the ``source("run_analysis.R")`` command, the script should output the following info on the console :

    > source("run_analysis.R")

    [1] "Reading in the training set..."
    [1] "Done !"

    [1] "Reading in the test set..."
    [1] "Done !"

    [1] "STEP 1 : Merging the training and test data sets - done !"
    [1] "trainSet dimensions :" "7352"                  "563"                  
    [1] "testSet dimensions :" "2947"                 "563"                 
    [1] "mergedSet dimensions :" "10299"                  "563"                   

    [1] "Removed colums with duplicated names !"
    [1] "mergedSet new dimensions :" "10299"                      "479"                       

    [1] "STEP 2 : Selecting only the subject, activity, mean() and std() columns - done !"
    [1] "selectedSet dimensions :" "10299"                    "68"                      

    [1] "STEP 3 : Naming the activities using the appropriate labels..."
    [1] "Done !"

    [1] "STEP 4 : Renaming the data set variables to make them more descriptive..."
    [1] "Done !"

    [1] "STEP 5 : Creating a tidy data set with the average of each variable for each activity and each subject..."
    [1] "Done !"
    [1] "tidySet dimensions :" "180"                  "68"                  

    [1] "Tidy data set created and exported as a text file ! End of the analysis. Bye !"
   
## Reading the exported text data set back into R

The code for reading the tidySet textfile back into R and then taking a look at it would be :

        tidyData <- read.table(file_path, header = TRUE)
        View(tidyData)
        
# Additional information

- This analysis was done in RStudio 0.99.467 (R version 3.2.2 (2015-08-14) -- "Fire Safety") on Mac OSX 10.10.5.

- Please refer to the accompanying [Codebook](https://github.com/cdromain/GettingAndCleaningDataProject/blob/master/CodeBook.md) for more information about the data and the variables.

- Thanks and respect to the following sources authors who helped me completing this analysis :

    + The [blog of David Hood aka THOUGHTFULBLOKE](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) has proved to be very useful to work on the project.

    + The [*Tidy Data*](http://vita.had.co.nz/papers/tidy-data.pdf) paper by Hadley Wickham, the author of the dplyr package.



