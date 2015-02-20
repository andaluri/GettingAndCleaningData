#run_analysis 
#  parameters - None
#  returns- tidy data set
#  description :
#  This function reads data from :
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#  Makes several modifcations to make the data tidy for further analysis.
run_analysis <- function() {
  
  # Load plyr and dplyr libraries.
  library(plyr)
  library(dplyr)
  
  # Set rootDir variable to working directory where the data is unzipped.
  rootDir <- "./UCI HAR Dataset"
  
  # Constant column names (to reduce constant string duplication).
  colActivity <- "activity"
  colSubject <- "subject"
  
  # Set up test and train data folders.
  testDataDir <- paste(rootDir, "/test", sep="")
  trainDataDir <- paste(rootDir, "/train", sep="")
  
  # Load features (column names for train and test datasets)
  features <- read.table(paste(rootDir, "/features.txt", sep=""))  
  
  # Load activity labels (factors that need to be coded)
  actlabels <- read.table(paste(rootDir, "/activity_labels.txt", sep=""))  
  
  # Load train dataset.
  xtrain <- read.table(paste(trainDataDir, "/X_train.txt", sep=""))
  ytrain <- read.table(paste(trainDataDir, "/y_train.txt", sep=""))
  subtrain <- read.table(paste(trainDataDir, "/subject_train.txt", sep=""))

  # Assign column names for train dataset.
  colnames(xtrain) <- features$V2
  colnames(ytrain) <- colActivity
  colnames(subtrain) <- colSubject
  
  # Load test dataset.
  xtest <- read.table(paste(testDataDir, "/X_test.txt", sep=""))
  ytest <- read.table(paste(testDataDir, "/y_test.txt", sep=""))
  subtest <- read.table(paste(testDataDir, "/subject_test.txt", sep=""))
  
  # Assign column names for test dataset.
  colnames(xtest) <- features$V2
  colnames(ytest) <- colActivity
  colnames(subtest) <- colSubject
  
  # Label the factors in ytrain and ytest i.e. Activities.
  ytrain$activity <- factor(ytrain$activity, actlabels$V1, actlabels$V2)
  ytest$activity <- factor(ytest$activity, actlabels$V1, actlabels$V2)
  
  # Filter xtrain and xtest datasets with mean/std at the end of the name.
  stdmeantrain <- xtrain[,grep("std\\(\\)$|mean\\(\\)$", names(xtrain))]
  stdmeantest <- xtest[,grep("std\\(\\)$|mean\\(\\)$", names(xtest))]
  
  # Combine train columns to make a complete train dataset.
  trainset <- cbind(subtrain, stdmeantrain)
  trainset <- cbind(trainset, ytrain)
  
  # Combine test columns to make a complete test dataset.
  testset <- cbind(subtest, stdmeantest)
  testset <- cbind(testset, ytest)
  
  # Bind the rows of train and test datasets to form the raw dataset for further cleaning.
  rawset <- rbind(trainset, testset)
  
  # Scrub the features by removing braces and replacing dash extensions.
  names(rawset) <- gsub("\\(\\)", "", names(rawset))
  names(rawset) <- gsub("\\-mean", "Mean", names(rawset))
  names(rawset) <- gsub("\\-std", "StdDev", names(rawset))
  
  # Group by activity and subject and calculate mean of each variable.
  result <- ddply(rawset, c(colActivity, colSubject), numcolwise(mean))
  
  # Return results. Fields seperated by a blank space.
  write.table(result, sep=" ", file="tidy_data.txt", row.names=FALSE)
  
  # Write names of the columns to assist codebook creation.
  write.table(names(result), file="code_book.txt", row.names=FALSE)
  
  # Return result dataset for viewing/validating.
  return(result)
}
