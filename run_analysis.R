## 1. Merges the training and the test sets to create one data set.
trainData <- read.table("./data/train/X_train.txt")
trainLabel <- read.table("./data/train/y_train.txt")
trainSubject <- read.table("./data/train/subject_train.txt")

testData <- read.table("./data/test/X_test.txt")
testLabel <- read.table("./data/test/y_test.txt") 
testSubject <- read.table("./data/test/subject_test.txt")

joinData <- rbind(trainData, testData)
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./data/features.txt")
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
joinData <- joinData[, meanStdIndices]
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2])
names(joinData) <- gsub("mean", "Mean", names(joinData))
names(joinData) <- gsub("std", "Std", names(joinData))
names(joinData) <- gsub("-", "", names(joinData))

## 3. Uses descriptive activity names to name the activities in the data set
activities <- read.table("./data/activity_labels.txt")
activitiesLabel <- activities[joinLabel[, 1], 2]
joinLabel[, 1] <- activitiesLabel
names(joinLabel) <- "activity"

## 4. Appropriately labels the data set with descriptive activity names.
names(joinSubject) <- "subject"
mergedData <- cbind(joinSubject, joinLabel, joinData)
write.table(mergedData, "tiny_data.txt")