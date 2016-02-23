run_analysis <- function() {
  
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
  
  ## Write out final data table
  ## write.csv(alldata, "wearablesall.csv", row.names = FALSE)
  
  ## Join by activity label (to get appropriate activity descriptions)
  datamerge <- merge(activities, alldata, by="label")
  
  ## Remove redundant join ID, group and average
  finaldata <- datamerge %>% select(-label) %>% group_by(activity, subject) %>% summarise_each(funs(mean))
  
  ## Write out new data table
  write.csv(finaldata, "wearablesmean.csv", row.names = FALSE)
  
}