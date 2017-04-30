## Here are the steps 

## Step 1
## Read our data
## Reading testing data
test_subject <- read.table("test/subject_test.txt", col.names="subject")
test_y <- read.table("test/y_test.txt", col.names="label")
test_x <- read.table("test/X_test.txt")

## Reading training data
train_subject <- read.table("train/subject_train.txt", col.names="subject")
train_y <- read.table("train/y_train.txt", col.names="label")
train_x <- read.table("train/X_train.txt")

## Merging testing data
testData<-cbind(test_subject, test_label, test_data)

## merging training data
trainData <- cbind(train_subject, train_label, train_data)

## merging testing and training data
full_data<-rbind(testData, trainData)

## Step 2
## Reading the features data
feature_name <- read.table("features.txt",  stringsAsFactors=FALSE)[,2]

## Extract mean and standard deviation for each measurement
featureIndex <- grep(("mean\\(\\)|std\\(\\)"), feature_name)
finalData <- full_data[, c(1, 2, featureIndex+2)]
colnames(finalData) <- c("subject", "activity", feature_name[featureIndex])

## Step 3
## Reading the activities_labels 
activityName <- read.table("activity_labels.txt", stringsAsFactors=FALSE)

## Replacing labels in data with label names
# Replace 1 to 6 with activity names
finalData$activity <- factor(finalData$activity, levels = activityName[,1], 
                             labels = activityName[,2])

## step 4
names(finalData) <- gsub("\\()", "", names(finalData))
names(finalData) <- gsub("^t", "time", names(finalData))
names(finalData) <- gsub("^f", "frequency", names(finalData))
names(finalData) <- gsub("-mean", "Mean", names(finalData))
names(finalData) <- gsub("-std", "Std", names(finalData))


## Lastly write the data to upload

write.table(finalData, "./tidyData.txt", row.names = FALSE)

