#   REALTIME.R
#   TAKES IN AN ARGUMENT TO LOAD THE CORRESPONDING RDA FILE
#   THEN SAVE THE TEMP/HUM FIGURE IN A SIMPLE TEXT FILE FOR THE WEBSITE
args<-commandArgs(trailingOnly=TRUE)
path<-"/home/pi/Temps/data/"
wwwpath<-"/var/www/html/tempnow/"
fname<-args[1]  #RDA FILENAME
txtfileprefix<-gsub("tuba","",fname)

#DECLARE PATHS
rdapath<-paste(path,fname,".Rda",sep="")
temptxtpath<-paste(wwwpath,txtfileprefix,"temp",".txt",sep="")
humtxtpath<-paste(wwwpath,txtfileprefix,"hum",".txt",sep="")

obj<-readRDS(file=rdapath)
t<-obj[nrow(obj),"temp"]
h<-obj[nrow(obj),"hum"]
t<-factor(t)
h<-factor(h)
write.table(t,temptxtpath,col.names=FALSE,row.names=FALSE,quote=FALSE)
write.table(h,humtxtpath,col.names=FALSE,row.names=FALSE,quote=FALSE)
