run_Analysis <- function(){
  #reading files into data frame
  x_trainDF <- read.csv("UCI HAR Dataset//train//X_train.txt", sep = "", header = FALSE)
  y_trainDF <- read.csv("UCI HAR Dataset//train//y_train.txt", sep = "", header = FALSE)
  subject_trainDF <- read.csv("UCI HAR Dataset//train//subject_train.txt", sep = "", header = FALSE) 
  
  x_testDF <- read.csv("UCI HAR Dataset//test//X_test.txt", sep = "", header = FALSE)
  y_testDF <- read.csv("UCI HAR Dataset//test//y_test.txt", sep = "", header = FALSE)
  subject_testDF <- read.csv("UCI HAR Dataset//test//subject_test.txt", sep = "", header = FALSE) 
  
  featuresDF <- read.csv("UCI HAR Dataset//features.txt", sep = "", header = FALSE)
  activityLabelsDF <- read.csv("UCI HAR Dataset//activity_labels.txt", sep="", header = FALSE)
  
  #binding and test data frames
  
  x_trainTestDF <- rbind(x_trainDF, x_testDF)
  y_trainTestDF <- rbind(y_trainDF, y_testDF)
  subject_trainTestDF <- rbind(subject_trainDF, subject_testDF)
  
  
  #selecting column names from features data frame
  vector_x_features <- as.vector(featuresDF[, 2])
  colnames(x_trainTestDF) <- vector_x_features
  
  #selecting column names containing "mean or deviation calculations"
  x_trainTestDF_Subset <- x_trainTestDF[ , grepl("mean\\(\\)|std\\(\\)", names(x_trainTestDF))]
  colnames(y_trainTestDF) <- "activity"
  
  
  names(activityLabelsDF)[names(activityLabelsDF) == "V1"] <- "activity"
  names(activityLabelsDF)[names(activityLabelsDF) == "V2"] <- "ActivityName"
  activityLabelsDF$ActivityName <- as.factor(activityLabelsDF$ActivityName)
  
  
  
  colnames(subject_trainTestDF) <- "subject"
  
  #binding x & y training and testing data sets
  x_trainTestDF_Subset_Activity <- cbind(y_trainTestDF, x_trainTestDF_Subset)
  
  x_trainTestDF_Subset_ActivitySubject <- cbind(x_trainTestDF_Subset_Activity, subject_trainTestDF)
  
  #merging to get the activity names
  
  x_trainTestDF_Subset_ActivityName <- 
    merge(x_trainTestDF_Subset_ActivitySubject, activityLabelsDF, by.x="activity", by.y="activity", all = TRUE)
  
  #  x_trainTestDF_Subset_ActivityName <- cbind(x_trainTestDF_Subset_ActivityName, subject_trainTestDF)
  
  x_trainTestDF_Subset_ActivityAvg <- x_trainTestDF_Subset_ActivityName[, 2:69] 
  
  resultTemp <- x_trainTestDF_Subset_ActivityAvg %>%
    group_by(subject, ActivityName) %>%
    summarise_each(funs(mean), 1:66)

}