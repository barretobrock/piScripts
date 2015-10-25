#   ADDTODATATABLE.R
#   TAKES IN FOUR ARGUMENTS TO 
#   [1] LOAD THE CORRESPONDING RDA FILE
#   [2] TAKE IN TIMESTAMP STRING
#   [3] TAKE IN TEMP STRING
#   [4] TAKE IN HUMIDITY STRING
#   THEN PUT IT ALL TOGETHER AND SAVE INTO RDA FILE

args<-commandArgs(trailingOnly=TRUE)
path<-"/home/pi/Temps/data/"
fname<-args[1]  #RDA FILENAME
grpStr<-args[2] #GROUP OF STRINGS
grpStr<-strsplit(grpStr,"/")	#SPLIT STRING BY SLASH
tstamp<-grpStr[[1]][1]  #MEASUREMENT TIMESTAMP STRING
tempStr<-as.numeric(grpStr[[1]][2])  #TEMPERATURE MEASUREMENT
humStr<-as.numeric(grpStr[[1]][3])   #HUMIDITY MEASUREMENT
rdapath<-paste(path,fname,".Rda",sep="")

#CHECK IF STORAGE FILE EXISTS
if(file.exists(rdapath))
{
  obj<-readRDS(rdapath)  #LOAD STORED DATA FRAME
} else {
  obj<-data.frame() #IF FILE DOESN'T EXIST IN FOLDER, CREATE NEW DATAFRAME
} 

tstamp<-gsub("_"," ",tstamp)  #REMOVE '_' FROM TIMESTAMP TO MATCH FORMATTING
dataset<-cbind(tstamp,tempStr,humStr)

df<-dataset[,1]
df<-strptime(df, "%Y-%m-%d %H:%M:%S")
dataset[,1]<-as.character(df)

#INSERT INTO NEW DATAFRAME
temphum<-data.frame(dataset)
#NEW COLUMNS TO ORGANIZE STUFF
mths<-as.numeric(format(df,"%m"))
dys<-as.numeric(format(df,"%d"))
hrs<-as.numeric(format(df,"%H"))
mns<-as.numeric(format(df,"%M"))
temphum[4:7]<-cbind(mths,dys,hrs,mns)

colnames(temphum)<-c("timestamp","temp","hum","month","day","hour","minute")
temphum<-temphum[order(temphum$timestamp),]
obj<-rbind(obj,temphum)

saveRDS(obj,file=rdapath)
