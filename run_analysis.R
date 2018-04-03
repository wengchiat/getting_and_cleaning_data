library(dplyr)

##[1]Merges the training and the test sets to create one data set.
##set working directory and read data
setwd('./R/UCI HAR Dataset/')
features<-read.table('./features.txt',header = FALSE)
activitys<-read.table('./activity_labels.txt',header = FALSE)


test<-read.table('./test/X_test.txt',header = FALSE)
testID<-read.table('./test/Y_test.txt',header = FALSE)
testsub<-read.table('./test/subject_test.txt',header = FALSE)

train<-read.table('./train/X_train.txt',header = FALSE)
trainID<-read.table('./train/Y_train.txt',header = FALSE)
trainsub<-read.table('./train/subject_train.txt',header = FALSE)

##combine test and train data
data<-rbind(test,train)
activityID<-rbind(testID,trainID)
subject<-rbind(testsub,trainsub)

##rename data header
names(activityID) = 'Activity'
names(subject) = 'Subject'
names(data) <- features[,2]


##[2]Extracts only the measurements on the mean and standard deviation for each measurement.
data<-data[,grep('mean\\()|std\\()',names(data),value = TRUE)]
data_head<-names(data)


##[3]Appropriately labels the data set with descriptive variable names.
##substitute t,f,mean() and std()
data_head<-paste(data_head, lapply(data_head,fun_replace_time_frequency ))
data_head<-paste(data_head, lapply(data_head,fun_replace_mean_std ))

##remove t and f 
data_head<-sub('^t','',data_head)
data_head<-sub('^f','',data_head)

##remove -mean() and -std() 
data_head<-sub('-mean\\()','',data_head)
data_head<-sub('-std\\()','',data_head)


##function for relacing t,f,mean() and std()
fun_replace_time_frequency <-function(x){
  if (grepl('^t',x)){
    x<-'in time '
  }else if (grepl('^f',x)){
      x<-'in frequency '
    }
  }
   
fun_replace_mean_std <-function(x){
  if (grepl('mean\\()',x)){
    x<-'-Mean'
  }else if (grepl('std\\()',x)){
    x<-'-Standard Deviation'
  }
}  

##Relabeling the data header
data_head<-sub('GravityAcc', 'Gravity Acceleration ',data_head)
data_head<-sub('[Body]+Acc','Body Acceleration ',data_head)
data_head<-sub('[Body]+Gyro', 'Angular velocity ',data_head)
data_head<-sub('Jerk', '-Jerk signals ',data_head)
data_head<-sub('Mag', '(Magnitude) ',data_head)
data_head<-sub('-X', ' X-axis ',data_head)
data_head<-sub('-Y', ' Y-axis ',data_head)
data_head<-sub('-Z', ' Z-axis ',data_head)
names(data) = data_head 

##combine data, activityID and subject then rename activity ID
data<-cbind(subject,activityID,data)

##[4]Uses descriptive activity names to name the activities in the data set
data$Activity <- as.factor(data$Activity)
levels(data$Activity) = activitys[,2]

##[5]From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data_summarised<- group_by(data,Subject,Activity)%>%summarise_all(funs(mean))
write.csv(data_summarised,file='tidydata.csv')

 