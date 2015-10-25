---
title: "Getting and Cleaning Data - Project's Codebook"
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
3. **a codebook (this file)**, called CodeBook.md, describing the variables, the data, and any transformations or work that we performed to clean up the data 
4. a [README.md](https://github.com/cdromain/GettingAndCleaningDataProject/blob/master/README.md) in the repo, explaining how our script works

The data linked to from the course website represent data collected from the Samsung Galaxy S smartphone's accelerometers  : "Human Activity Recognition Using Smartphones Dataset" (Version 1.0) by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto, Smartlab - Non Linear Complex Systems Laboratory, DITEN - Università degli Studi di Genova, Italy. A full description is available at [this website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). 

# Study design  

## Collection of the raw data

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% for the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of 561 features was obtained by calculating variables from the time and frequency domain.

## Data download

The following R script was used to download and unzip the raw data archive programatically :

    ## Data downloading script

    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

    download.file(fileUrl, "UCIHARDataset.zip", method = "curl")

    unzip("UCIHARDataset.zip")

    downloadedDate <- date()

    print("File downloaded and unzipped on :")
    print(downloadedDate)

    ## the script was ran using source("download.R")
    ## [1] "File downloaded and unzipped on :"
    ## [1] "Thu Oct 22 20:05:32 2015"

## Notes on the original raw data 
The downloaded file is a ZIP archive of 62.6 Mo. Once unzipped, the original raw data consists of one folder of 282.6 Mo containing the following files :

- 'README.txt' (where some information was taken to be used in this codebook)
- 'features_info.txt': Shows information about the variables used on the feature vector
- 'features.txt': List of all features
- 'activity_labels.txt': Links the class labels with their activity name
- 'train/X_train.txt': Training set
- 'train/y_train.txt': Training labels
- 'test/X_test.txt': Test set
- 'test/y_test.txt': Test labels
- 'train/subject_train.txt': Each row identifies the subject who performed the activity (the range is from 1 to 30)

The original data set is made of 10 299 instances and 561 attributes (as described on the [data set homepage](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)).

# Creating the tidy data set

## How to create the tidy data file

1. Download and unzip the original raw data set into the working directory (see the script above in the data download part)

2. Run the analysis script "run_analysis.R", which will create a "tidySet.txt" file into the working directory

## The analysis script
   
As described in more details inside the [README file](https://github.com/cdromain/GettingAndCleaningDataProject/blob/master/README.md) accompanying it in the repo, the analysis script "run_analysis.R" performs the following tasks :

1. Reads the training and test data sets into 2 data frames
2. Merges the training and test data sets into a single data frame
3. Reads the features names and adds them to the merged data set
4. Removes columns with duplicated names
5. Extracts the relevant columns into a new data frame
6. Names the activities using the appropriate labels
7. Renames the data set variables to make them more descriptive
8. Creates a tidy data set with the average of each variable for each activity and each subject
9. Exports the tidy data set as a text file into the working directory 

# The tidy data set and its variables

## General description and information

The result of the analysis script is a **tidy data set (one observation per row and one variable per column, respecting the tidy data principes)** with the following characteristics :

 - data frame of 180 rows/observations and 68 columns/variables
 
 - The 68 variables include the subject ID, the activity label and 66 selected variables from the original data including mean and standard deviation measurements, as requested in the project instructions
 
 - **These 66 selected measurements variables are normalized and bounded within [-1, 1], hence the absence of units**
 
 - Apart from the first 2 variables related to the subjects and the activities, the 66 variables measured are named according to the following 4-levels construction convention : *1-2-3-4*
 
    1. time or frequency domain
    2. sensor signals : triaxial acceleration from the accelerometer (total acceleration), estimated body acceleration or triaxial angular velocity from the gyroscope
    3. mean or standard deviation measurements
    4. X, Y or Z axis (triaxial signals were collected)     
       
After reading a few discussions ([link 1](https://class.coursera.org/getdata-033/forum/thread?thread_id=126), [link 2](https://class.coursera.org/getdata-033/forum/thread?thread_id=118) and [link 3](https://class.coursera.org/getdata-033/forum/thread?thread_id=232)) on the class forum, I decided to use a **simple naming system for the variables**, including no capital letter, no point, dash or space, to make the data set as descriptive, reliable, bug-free and tidy as possible. I also replaced the letters "t" and "f" by the words "time" and "frequency", as well as replacing other abbreviations with their full word equivalent.

## Description of the tidy data set variables - the code book

The following information was partially collected by running a summary script using ``str`` and ``summary`` commands inside ``for`` loops applied to all the tidy data set variables.

### Variable 1 subject

Class = Factor 

30 levels "1","2","3","4",..."30"

Unique identifier of the subject who performed the activity. 30 persons took part in the experiment, hence the 30 levels.

### Variable 2 activity

Class = Factor 

6 levels "LAYING","SITTING","STANDING","WALKING","WALKING_DOWNSTAIRS","WALKING_UPSTAIRS"  

Descriptive label of the activity performed by the subject. There were 6 different activities part of the experiment, as described by the 6 different labels above.

### Variable 3 timebodyaccelerationmeanx

Class = numeric    
Time domain; mean measurement

 Min.   :0.2216           
 1st Qu.:0.2712           
 Median :0.2770           
 Mean   :0.2743           
 3rd Qu.:0.2800           
 Max.   :0.3015           

### Variable 4 timebodyaccelerationmeany

Class = numeric    
Time domain; mean measurement

 Min.   :-0.040514        
 1st Qu.:-0.020022        
 Median :-0.017262        
 Mean   :-0.017876        
 3rd Qu.:-0.014936        
 Max.   :-0.001308        

### Variable 5 timebodyaccelerationmeanz

Class = numeric    
Time domain; mean measurement

 Min.   :-0.15251         
 1st Qu.:-0.11207         
 Median :-0.10819         
 Mean   :-0.10916         
 3rd Qu.:-0.10443         
 Max.   :-0.07538         

### Variable 6 timegravityaccelerationmeanx

Class = numeric    
Time domain; mean measurement

 Min.   :-0.6800             
 1st Qu.: 0.8376             
 Median : 0.9208             
 Mean   : 0.6975             
 3rd Qu.: 0.9425             
 Max.   : 0.9745             

### Variable 7 timegravityaccelerationmeany

Class = numeric    
Time domain; mean measurement

 Min.   :-0.47989            
 1st Qu.:-0.23319            
 Median :-0.12782            
 Mean   :-0.01621            
 3rd Qu.: 0.08773            
 Max.   : 0.95659            

### Variable 8 timegravityaccelerationmeanz

Class = numeric    
Time domain; mean measurement

 Min.   :-0.49509            
 1st Qu.:-0.11726            
 Median : 0.02384            
 Mean   : 0.07413            
 3rd Qu.: 0.14946            
 Max.   : 0.95787            

### Variable 9 timebodyaccelerationjerkmeanx

Class = numeric    
Time domain; mean measurement

 Min.   :0.04269              
 1st Qu.:0.07396              
 Median :0.07640              
 Mean   :0.07947              
 3rd Qu.:0.08330              
 Max.   :0.13019              

### Variable 10 timebodyaccelerationjerkmeany

Class = numeric    
Time domain; mean measurement

 Min.   :-0.0386872           
 1st Qu.: 0.0004664           
 Median : 0.0094698           
 Mean   : 0.0075652           
 3rd Qu.: 0.0134008           
 Max.   : 0.0568186           

### Variable 11 timebodyaccelerationjerkmeanz

Class = numeric    
Time domain; mean measurement

 Min.   :-0.067458            
 1st Qu.:-0.010601            
 Median :-0.003861            
 Mean   :-0.004953            
 3rd Qu.: 0.001958            
 Max.   : 0.038053            

### Variable 12 timebodygyroscopemeanx

Class = numeric    
Time domain; mean measurement

 Min.   :-0.20578      
 1st Qu.:-0.04712      
 Median :-0.02871      
 Mean   :-0.03244      
 3rd Qu.:-0.01676      
 Max.   : 0.19270      

### Variable 13 timebodygyroscopemeany

Class = numeric    
Time domain; mean measurement

 Min.   :-0.20421      
 1st Qu.:-0.08955      
 Median :-0.07318      
 Mean   :-0.07426      
 3rd Qu.:-0.06113      
 Max.   : 0.02747      

### Variable 14 timebodygyroscopemeanz

Class = numeric    
Time domain; mean measurement

 Min.   :-0.07245      
 1st Qu.: 0.07475      
 Median : 0.08512      
 Mean   : 0.08744      
 3rd Qu.: 0.10177      
 Max.   : 0.17910      

### Variable 15 timebodygyroscopejerkmeanx

Class = numeric    
Time domain; mean measurement

 Min.   :-0.15721          
 1st Qu.:-0.10322          
 Median :-0.09868          
 Mean   :-0.09606          
 3rd Qu.:-0.09110          
 Max.   :-0.02209          

### Variable 16 timebodygyroscopejerkmeany

Class = numeric    
Time domain; mean measurement

 Min.   :-0.07681          
 1st Qu.:-0.04552          
 Median :-0.04112          
 Mean   :-0.04269          
 3rd Qu.:-0.03842          
 Max.   :-0.01320          

### Variable 17 timebodygyroscopejerkmeanz

Class = numeric    
Time domain; mean measurement

 Min.   :-0.092500         
 1st Qu.:-0.061725         
 Median :-0.053430         
 Mean   :-0.054802         
 3rd Qu.:-0.048985         
 Max.   :-0.006941         

### Variable 18 timebodyaccelerationmagnitudemean

Class = numeric    
Time domain; mean measurement

 Min.   :-0.9865                  
 1st Qu.:-0.9573                  
 Median :-0.4829                  
 Mean   :-0.4973                  
 3rd Qu.:-0.0919                  
 Max.   : 0.6446                  

### Variable 19 timegravityaccelerationmagnitudemean

Class = numeric    
Time domain; mean measurement

 Min.   :-0.9865                     
 1st Qu.:-0.9573                     
 Median :-0.4829                     
 Mean   :-0.4973                     
 3rd Qu.:-0.0919                     
 Max.   : 0.6446                     

### Variable 20 timebodyaccelerationjerkmagnitudemean

Class = numeric    
Time domain; mean measurement

 Min.   :-0.9928                      
 1st Qu.:-0.9807                      
 Median :-0.8168                      
 Mean   :-0.6079                      
 3rd Qu.:-0.2456                      
 Max.   : 0.4345                      

### Variable 21 timebodygyroscopemagnitudemean

Class = numeric    
Time domain; mean measurement

 Min.   :-0.9807               
 1st Qu.:-0.9461               
 Median :-0.6551               
 Mean   :-0.5652               
 3rd Qu.:-0.2159               
 Max.   : 0.4180               

### Variable 22 timebodygyroscopejerkmagnitudemean

Class = numeric    
Time domain; mean measurement

 Min.   :-0.99732                  
 1st Qu.:-0.98515                  
 Median :-0.86479                  
 Mean   :-0.73637                  
 3rd Qu.:-0.51186                  
 Max.   : 0.08758                  

### Variable 23 frequencybodyaccelerationmeanx

Class = numeric    
Frequency domain; mean measurement

 Min.   :-0.9952               
 1st Qu.:-0.9787               
 Median :-0.7691               
 Mean   :-0.5758               
 3rd Qu.:-0.2174               
 Max.   : 0.5370               

### Variable 24 frequencybodyaccelerationmeany

Class = numeric    
Frequency domain; mean measurement

 Min.   :-0.98903              
 1st Qu.:-0.95361              
 Median :-0.59498              
 Mean   :-0.48873              
 3rd Qu.:-0.06341              
 Max.   : 0.52419              

### Variable 25 frequencybodyaccelerationmeanz

Class = numeric    
Frequency domain; mean measurement

 Min.   :-0.9895               
 1st Qu.:-0.9619               
 Median :-0.7236               
 Mean   :-0.6297               
 3rd Qu.:-0.3183               
 Max.   : 0.2807               

### Variable 26 frequencybodyaccelerationjerkmeanx

Class = numeric    
Frequency domain; mean measurement

 Min.   :-0.9946                   
 1st Qu.:-0.9828                   
 Median :-0.8126                   
 Mean   :-0.6139                   
 3rd Qu.:-0.2820                   
 Max.   : 0.4743                   

### Variable 27 frequencybodyaccelerationjerkmeany

Class = numeric    
Frequency domain; mean measurement

 Min.   :-0.9894                   
 1st Qu.:-0.9725                   
 Median :-0.7817                   
 Mean   :-0.5882                   
 3rd Qu.:-0.1963                   
 Max.   : 0.2767                   

### Variable 28 frequencybodyaccelerationjerkmeanz

Class = numeric    
Frequency domain; mean measurement

 Min.   :-0.9920                   
 1st Qu.:-0.9796                   
 Median :-0.8707                   
 Mean   :-0.7144                   
 3rd Qu.:-0.4697                   
 Max.   : 0.1578                   

### Variable 29 frequencybodygyroscopemeanx

Class = numeric    
Frequency domain; mean measurement

 Min.   :-0.9931            
 1st Qu.:-0.9697            
 Median :-0.7300            
 Mean   :-0.6367            
 3rd Qu.:-0.3387            
 Max.   : 0.4750            

### Variable 30 frequencybodygyroscopemeany

Class = numeric    
Frequency domain; mean measurement

 Min.   :-0.9940            
 1st Qu.:-0.9700            
 Median :-0.8141            
 Mean   :-0.6767            
 3rd Qu.:-0.4458            
 Max.   : 0.3288            

### Variable 31 frequencybodygyroscopemeanz

Class = numeric    
Frequency domain; mean measurement

 Min.   :-0.9860            
 1st Qu.:-0.9624            
 Median :-0.7909            
 Mean   :-0.6044            
 3rd Qu.:-0.2635            
 Max.   : 0.4924            

### Variable 32 frequencybodyaccelerationmagnitudemean

Class = numeric    
Frequency domain; mean measurement

 Min.   :-0.9868                       
 1st Qu.:-0.9560                       
 Median :-0.6703                       
 Mean   :-0.5365                       
 3rd Qu.:-0.1622                       
 Max.   : 0.5866                       

### Variable 33 frequencybodyaccelerationjerkmagnitudemean

Class = numeric    
Frequency domain; mean measurement

 Min.   :-0.9940                           
 1st Qu.:-0.9770                           
 Median :-0.7940                           
 Mean   :-0.5756                           
 3rd Qu.:-0.1872                           
 Max.   : 0.5384                           

### Variable 34 frequencybodygyroscopemagnitudemean

Class = numeric    
Frequency domain; mean measurement

 Min.   :-0.9865                    
 1st Qu.:-0.9616                    
 Median :-0.7657                    
 Mean   :-0.6671                    
 3rd Qu.:-0.4087                    
 Max.   : 0.2040                    

### Variable 35 frequencybodygyroscopejerkmagnitudemean

Class = numeric    
Frequency domain; mean measurement

 Min.   :-0.9976                        
 1st Qu.:-0.9813                        
 Median :-0.8779                        
 Mean   :-0.7564                        
 3rd Qu.:-0.5831                        
 Max.   : 0.1466                        

### Variable 36 timebodyaccelerationstandarddeviationx

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9961                       
 1st Qu.:-0.9799                       
 Median :-0.7526                       
 Mean   :-0.5577                       
 3rd Qu.:-0.1984                       
 Max.   : 0.6269                       

### Variable 37 timebodyaccelerationstandarddeviationy

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.99024                      
 1st Qu.:-0.94205                      
 Median :-0.50897                      
 Mean   :-0.46046                      
 3rd Qu.:-0.03077                      
 Max.   : 0.61694                      

### Variable 38 timebodyaccelerationstandarddeviationz

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9877                       
 1st Qu.:-0.9498                       
 Median :-0.6518                       
 Mean   :-0.5756                       
 3rd Qu.:-0.2306                       
 Max.   : 0.6090                       

### Variable 39 timegravityaccelerationstandarddeviationx

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9968                          
 1st Qu.:-0.9825                          
 Median :-0.9695                          
 Mean   :-0.9638                          
 3rd Qu.:-0.9509                          
 Max.   :-0.8296                          

### Variable 40 timegravityaccelerationstandarddeviationy

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9942                          
 1st Qu.:-0.9711                          
 Median :-0.9590                          
 Mean   :-0.9524                          
 3rd Qu.:-0.9370                          
 Max.   :-0.6436                          

### Variable 41 timegravityaccelerationstandarddeviationz

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9910                          
 1st Qu.:-0.9605                          
 Median :-0.9450                          
 Mean   :-0.9364                          
 3rd Qu.:-0.9180                          
 Max.   :-0.6102                          

### Variable 42 timebodyaccelerationjerkstandarddeviationx

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9946                           
 1st Qu.:-0.9832                           
 Median :-0.8104                           
 Mean   :-0.5949                           
 3rd Qu.:-0.2233                           
 Max.   : 0.5443                           

### Variable 43 timebodyaccelerationjerkstandarddeviationy

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9895                           
 1st Qu.:-0.9724                           
 Median :-0.7756                           
 Mean   :-0.5654                           
 3rd Qu.:-0.1483                           
 Max.   : 0.3553                           

### Variable 44 timebodyaccelerationjerkstandarddeviationz

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.99329                          
 1st Qu.:-0.98266                          
 Median :-0.88366                          
 Mean   :-0.73596                          
 3rd Qu.:-0.51212                          
 Max.   : 0.03102                          

### Variable 45 timebodygyroscopestandarddeviationx

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9943                    
 1st Qu.:-0.9735                    
 Median :-0.7890                    
 Mean   :-0.6916                    
 3rd Qu.:-0.4414                    
 Max.   : 0.2677                    

### Variable 46 timebodygyroscopestandarddeviationy

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9942                    
 1st Qu.:-0.9629                    
 Median :-0.8017                    
 Mean   :-0.6533                    
 3rd Qu.:-0.4196                    
 Max.   : 0.4765                    

### Variable 47 timebodygyroscopestandarddeviationz

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9855                    
 1st Qu.:-0.9609                    
 Median :-0.8010                    
 Mean   :-0.6164                    
 3rd Qu.:-0.3106                    
 Max.   : 0.5649                    

### Variable 48 timebodygyroscopejerkstandarddeviationx

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9965                        
 1st Qu.:-0.9800                        
 Median :-0.8396                        
 Mean   :-0.7036                        
 3rd Qu.:-0.4629                        
 Max.   : 0.1791                        

### Variable 49 timebodygyroscopejerkstandarddeviationy

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9971                        
 1st Qu.:-0.9832                        
 Median :-0.8942                        
 Mean   :-0.7636                        
 3rd Qu.:-0.5861                        
 Max.   : 0.2959                        

### Variable 50 timebodygyroscopejerkstandarddeviationz

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9954                        
 1st Qu.:-0.9848                        
 Median :-0.8610                        
 Mean   :-0.7096                        
 3rd Qu.:-0.4741                        
 Max.   : 0.1932                        

### Variable 51 timebodyaccelerationmagnitudestandarddeviation

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9865                               
 1st Qu.:-0.9430                               
 Median :-0.6074                               
 Mean   :-0.5439                               
 3rd Qu.:-0.2090                               
 Max.   : 0.4284                               

### Variable 52 timegravityaccelerationmagnitudestandarddeviation

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9865                                  
 1st Qu.:-0.9430                                  
 Median :-0.6074                                  
 Mean   :-0.5439                                  
 3rd Qu.:-0.2090                                  
 Max.   : 0.4284                                  

### Variable 53 timebodyaccelerationjerkmagnitudestandarddeviation

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9946                                   
 1st Qu.:-0.9765                                   
 Median :-0.8014                                   
 Mean   :-0.5842                                   
 3rd Qu.:-0.2173                                   
 Max.   : 0.4506                                   

### Variable 54 timebodygyroscopemagnitudestandarddeviation

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9814                            
 1st Qu.:-0.9476                            
 Median :-0.7420                            
 Mean   :-0.6304                            
 3rd Qu.:-0.3602                            
 Max.   : 0.3000                            

### Variable 55 timebodygyroscopejerkmagnitudestandarddeviation

Class = numeric    
Time domain; standard deviation measurement

 Min.   :-0.9977                                
 1st Qu.:-0.9805                                
 Median :-0.8809                                
 Mean   :-0.7550                                
 3rd Qu.:-0.5767                                
 Max.   : 0.2502                                

### Variable 56 frequencybodyaccelerationstandarddeviationx

Class = numeric    
Frequency domain; standard deviation measurement

 Min.   :-0.9966                            
 1st Qu.:-0.9820                            
 Median :-0.7470                            
 Mean   :-0.5522                            
 3rd Qu.:-0.1966                            
 Max.   : 0.6585                            

### Variable 57 frequencybodyaccelerationstandarddeviationy

Class = numeric    
Frequency domain; standard deviation measurement

 Min.   :-0.99068                           
 1st Qu.:-0.94042                           
 Median :-0.51338                           
 Mean   :-0.48148                           
 3rd Qu.:-0.07913                           
 Max.   : 0.56019                           

### Variable 58 frequencybodyaccelerationstandarddeviationz

Class = numeric    
Frequency domain; standard deviation measurement

 Min.   :-0.9872                            
 1st Qu.:-0.9459                            
 Median :-0.6441                            
 Mean   :-0.5824                            
 3rd Qu.:-0.2655                            
 Max.   : 0.6871                            

### Variable 59 frequencybodyaccelerationjerkstandarddeviationx

Class = numeric    
Frequency domain; standard deviation measurement

 Min.   :-0.9951                                
 1st Qu.:-0.9847                                
 Median :-0.8254                                
 Mean   :-0.6121                                
 3rd Qu.:-0.2475                                
 Max.   : 0.4768                                

### Variable 60 frequencybodyaccelerationjerkstandarddeviationy

Class = numeric    
Frequency domain; standard deviation measurement

 Min.   :-0.9905                                
 1st Qu.:-0.9737                                
 Median :-0.7852                                
 Mean   :-0.5707                                
 3rd Qu.:-0.1685                                
 Max.   : 0.3498                                

### Variable 61 frequencybodyaccelerationjerkstandarddeviationz

Class = numeric    
Frequency domain; standard deviation measurement

 Min.   :-0.993108                              
 1st Qu.:-0.983747                              
 Median :-0.895121                              
 Mean   :-0.756489                              
 3rd Qu.:-0.543787                              
 Max.   :-0.006236                              

### Variable 62 frequencybodygyroscopestandarddeviationx

Class = numeric    
Frequency domain; standard deviation measurement

 Min.   :-0.9947                         
 1st Qu.:-0.9750                         
 Median :-0.8086                         
 Mean   :-0.7110                         
 3rd Qu.:-0.4813                         
 Max.   : 0.1966                         

### Variable 63 frequencybodygyroscopestandarddeviationy

Class = numeric    
Frequency domain; standard deviation measurement

 Min.   :-0.9944                         
 1st Qu.:-0.9602                         
 Median :-0.7964                         
 Mean   :-0.6454                         
 3rd Qu.:-0.4154                         
 Max.   : 0.6462                         

### Variable 64 frequencybodygyroscopestandarddeviationz

Class = numeric    
Frequency domain; standard deviation measurement

 Min.   :-0.9867                         
 1st Qu.:-0.9643                         
 Median :-0.8224                         
 Mean   :-0.6577                         
 3rd Qu.:-0.3916                         
 Max.   : 0.5225                         

### Variable 65 frequencybodyaccelerationmagnitudestandarddeviation

Class = numeric    
Frequency domain; standard deviation measurement

 Min.   :-0.9876                                    
 1st Qu.:-0.9452                                    
 Median :-0.6513                                    
 Mean   :-0.6210                                    
 3rd Qu.:-0.3654                                    
 Max.   : 0.1787                                    

### Variable 66 frequencybodyaccelerationjerkmagnitudestandarddeviation

Class = numeric    
Frequency domain; standard deviation measurement

 Min.   :-0.9944                                        
 1st Qu.:-0.9752                                        
 Median :-0.8126                                        
 Mean   :-0.5992                                        
 3rd Qu.:-0.2668                                        
 Max.   : 0.3163                                        

### Variable 67 frequencybodygyroscopemagnitudestandarddeviation

Class = numeric    
Frequency domain; standard deviation measurement

 Min.   :-0.9815                                 
 1st Qu.:-0.9488                                 
 Median :-0.7727                                 
 Mean   :-0.6723                                 
 3rd Qu.:-0.4277                                 
 Max.   : 0.2367                                 

### Variable 68 frequencybodygyroscopejerkmagnitudestandarddeviation

Class = numeric    
Frequency domain; standard deviation measurement

 Min.   :-0.9976                                     
 1st Qu.:-0.9802                                     
 Median :-0.8941                                     
 Mean   :-0.7715                                     
 3rd Qu.:-0.6081                                     
 Max.   : 0.2878     

# Sources

Thanks and respect to the following sources authors who helped me completing this analysis :

- This codebook is based on [Joris Schut's codebook template](https://gist.github.com/JorisSchut/dbc1fc0402f28cad9b41), linked on the [D.S.S. website](http://datasciencespecialization.github.io/getclean/).

- The [blog of David Hood aka THOUGHTFULBLOKE](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) has proved to be very useful to work on the project.

- The [*Tidy Data*](http://vita.had.co.nz/papers/tidy-data.pdf) paper by Hadley Wickham, the author of the dplyr package.