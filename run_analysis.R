library(dplyr)

subject_train <- read.table("train/subject_train.txt")
X_train <- read.table("train/X_train.txt")
Y_train <- read.table("train/Y_train.txt")

subject_test <- read.table("test/subject_test.txt")
X_test <- read.table("test/X_test.txt")
Y_test <- read.table("test/Y_test.txt")

training_set <- cbind(subject_train, Y_train, X_train)
test_set <- cbind(subject_test, Y_test, X_test)
data_set <- rbind(training_set, test_set)

activity_labels <- read.table("activity_labels.txt")
names(activity_labels) <- c("Nr", "Activity")

features <- data.frame(read.table("features.txt"))
features$V1 <- NULL
new_labels <- data.frame(V2=c("Subject", "Activity"), stringsAsFactors=FALSE)
features <- rbind(new_labels, features)

features$V2 <- as.factor(make.unique(features$V2))
colnames(data_set) <- features$V2

by_subject_activity <- group_by(data_set, Subject, Activity)
sum_by_subj_act <- summarise_each(by_subject_activity, funs(mean, sd))

write.table(sum_by_subj_act, file="submit.txt", row.name=FALSE) 
