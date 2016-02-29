run_analysis <- function() {
  
  ## This script is dependent on the package "dplyr". Please load this into R before running the script.
  ## The unzipped "wearables" folder should be placed in the working directory.
  
  ## Set file path
  folder <- "wearables/UCI HAR Dataset"
  
  ## Read feature and activity label data
  features <- read.table(file.path(folder,"features.txt"))
  activities <- read.table(file.path(folder, "activity_labels.txt"), col.names = c("label", "activity"))
  
  ## Read "test" files
  stest <- read.table(file.path(folder, "test/subject_test.txt"), col.names = "subject")
  ytest <- read.table(file.path(folder, "test/y_test.txt"), col.names = "label")
  xtest <- read.table(file.path(folder, "test/X_test.txt"))
  
  ## Set column names for X_test data here, as reading in with col.names removes "()" from features
  names(xtest) <- features$V2
  
  ## Select columns with "mean()" or "std()"
  xtestms <- xtest[,grep("mean\\(\\)|std\\(\\)", names(xtest))]
  
  ## Bind "test" columns together
  testcomb <- cbind(stest, ytest, xtestms)
  
  ## Read "train" files
  strain <- read.table(file.path(folder, "train/subject_train.txt"), col.names = "subject")
  ytrain <- read.table(file.path(folder, "train/y_train.txt"), col.names = "label")
  xtrain <- read.table(file.path(folder, "train/X_train.txt"))
  
  ## Set column names for y_test data here, as reading in with col.names removes "()" from features
  names(xtrain) <- features$V2
  
  ## Select columns with "mean()" or "std()"
  xtrainms <- xtrain[,grep("mean\\(\\)|std\\(\\)", names(xtrain))]
  
  ## Bind "train" columns together
  traincomb <- cbind(strain, ytrain, xtrainms)
  
  ## Merge "test" and "train" data together
  alldata <- rbind(testcomb, traincomb)
  
  ## Join by activity label (to get appropriate activity descriptions)
  datamerge <- merge(activities, alldata, by="label")
  
  ## Remove redundant join ID, group and average
  finaldata <- datamerge %>% select(-label) %>% group_by(activity, subject) %>% summarise_each(funs(mean))
  
  ## Update variable names
  names(finaldata) <- sub("mean\\(\\)", "avgmean", names(finaldata))
  names(finaldata) <- sub("std\\(\\)", "avgstd", names(finaldata))
  
  ## Write out new data table
  write.table(finaldata, "wearablesmean.txt", row.names = FALSE)
  
}
