##Read in the data files.

subject_test<-read.table("subject_test.txt", header=FALSE, col.names="subjectid")
subject_train<-read.table("subject_train.txt", header=FALSE, col.names="subjectid")

y_test<-read.table("y_test.txt", header=FALSE, col.names="activity")
y_train<-read.table("y_train.txt", header=FALSE, col.names="activity")

features<-read.table("features.txt", header=FALSE, col.names=c("index", "feature"))

x_test<-read.table("X_test.txt", header=FALSE, col.names=c(features$feature))
x_train<-read.table("X_train.txt", header=FALSE, col.names=c(features$feature))

##Merge the training and test data sets to create one data set.

testdata<-cbind(subject_test, y_test, x_test)
traindata<-cbind(subject_train, y_train, x_train)
alldata<-rbind(testdata, traindata)

##Extracts only the columns on mean and standard deviation.

neededdata<-alldata %in% select(contains(c("subjectid", "activity", "mean", "std")))

##Uses descriptive activity names to name the activities in the data set.

betterdata<-transform(neededdata, activity=factor(activity, levels=c("1", "2", "3", "4", "5", "6"),
                                                  labels=c("walking", "walkingupstairs", 
                                                           "walkingdownstairs", "sitting",
                                                           "standing", "laying")))

##Appropriately labels the data set with descriptive variable names.
##Cleans up column names by removing unnecessary punctuation.

names(betterdata)<-gsub("\\.", "", names(betterdata))

##Create a second, independent tidy data set with the average of each variable for
##each activity and each subject.

groupeddata<-group_by(betterdata, activity, subjectid)
summarizeddata<-summarize_all(groupeddata,mean)

##Write tidy data table to txt file.

write.table(summarizeddata, "summarizeddata.txt", row.names=FALSE, col.names=TRUE)
