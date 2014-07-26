# This script should be run inside the unzipped folder of the Samsung data set.
library(reshape2)

# Read the training and the test set feature file
train <- read.table("train/X_train.txt")
test <- read.table("test/X_test.txt")

# Extracts only the measurements on the mean and standard deviation for each measurement. The column numbers
# are hard coded here.
mean_feature_columns <- c(1,2,3,41,42,43,121,122,123,161,162,163,201,214,227,253,266,267,268,345,346,347,424,425,426,503,516,529,542)
train <- train[, mean_feature_columns]
test <- test[, mean_feature_columns]

# Uses descriptive activity names to name the activities in the data set
subject_train <- read.table("train/subject_train.txt", col.names = c("SubjectIdentifier"))
subject_test <- read.table("test/subject_test.txt", col.names = c("SubjectIdentifier"))

y_train <- read.table("train/Y_train.txt", col.names = c("ActivitylabelID"))
y_test <- read.table("test/Y_test.txt", col.names = c("ActivitylabelID"))

activity_names <- read.table("activity_labels.txt", col.names = c("Num", "ActivityLabel"))

# Clip all the data together.
all_train <- cbind(subject_train, train, y_train)
all_test <- cbind(subject_test, test, y_test)
all_data <- rbind(all_train, all_test)
remove(all_train, all_test, train, test, subject_train, subject_test, y_train, y_test)

all_data <- merge(all_data, activity_names, by.x = "ActivitylabelID", by.y = "Num", all = TRUE)
all_data$ActivitylabelID <- NULL

# Appropriately labels the data set with descriptive variable names. 
# TODO()
# Don't use the features.txt some are incorrect some have illegal characters in them making them hard to work with. Come up with your own names.

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
melted <- melt(all_data, id.vars = c("SubjectIdentifier", "ActivityLabel"), variable.name = "V")
result <- dcast(melted, SubjectIdentifier + ActivityLabel ~ V, mean)