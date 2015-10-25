#   SENSORDATAPROCESS.R
#   PROCESSES RDA FILES FOR BOTH ROOMS, CONVERTS TO JSON FOR GRAPHING AND SAVES AS ONE LARGE FILE
path<-"/home/pi/Temps/data/"
elutubapath<-paste(path,"elutuba",".Rda",sep="")
magatubapath<-paste(path,"magatuba",".Rda",sep="")
totalpath<-paste(path,"total.Rda",sep="")

#GET ELUTUBA RDA FILE
obj.e<-readRDS(elutubapath)
elu<-obj.e
#GET MAGATUBA RDA FILE
obj.m<-readRDS(magatubapath)
maga<-obj.m
#MERGA DATA INTO ONE SINGLE DATA FRAME
total<-merge(elu,maga[,2:7],by=c("month","day","hour","minute"),all.x=T)
total<-total[order(total$timestamp),] #ORDER CHRONOLOGICALLY
total<-total[,c(5,1:4,6:9)]
colnames(total)<-c("timestamp","month","day","hour","minute","etemp","ehum","mtemp","mhum")
total<-total[complete.cases(total),]  #FILTER OUT ANY NA COLUMNS

#FUNCTION TO CONVERT ALL VALUES TO JSON -> [TIMESTAMP, READING]
toJSONarray <- function(dtf)
{
  clnms <- colnames(dtf)
  name.value <- function(i)
  {
    quote <- '';
    if(!class(dtf[, i]) %in% c('numeric', 'integer'))
    {
      quote <- '';
    } 
    paste( quote, dtf[,i], quote, sep='')
  } 
  objs <- apply(sapply(clnms, name.value), 1, function(x){paste(x, collapse=', ')})
  objs <- paste('[', objs, ']')
  res <- paste('[', paste(objs, collapse=', '), ']')
  return(res)
} 

dtRng<-as.numeric(as.POSIXct(total[,"timestamp"],format="%Y-%m-%d %H:%M:%S"))
dtRng<-dtRng*1000 #CONVERT TO UNIX EPOCH IN MILLISECONDS
dtRng<-dtRng+7200000 #ADD IN THREE HOURS (3H*60M*60S*1000MS) TO ACCOUNT FOR GMT +3

#DEFINE A FUNCTION TO HANDLE REPEATED ASSIGNMENTS TO JSON FILES
convertToJSON<-function(measureCol,measuretype,varname,endfilename)
{
  tmpVar<-data.frame()      #EMPTY DATA FRAME
  tmpVar<-data.frame(dtRng) #CREATE A TEMPORARY VECTOR
  tmpVar[,2]<-total[,measureCol] #LOAD UNIX EPOCH DATES AND MEASUREMENTS
  colnames(tmpVar)<-c("date",measureCol)
  tmpVar<-toJSONarray(tmpVar) #CONVERT DATA FRAME INTO JSON FILE
  write(tmpVar,file=endfilename)  #WRITE AS JSON FILE
}

#CONVERT DATA FRAMES TO JSON
convertToJSON("etemp","temp","elutempjson",paste(path,"elutemp.json",sep=""))
convertToJSON("mtemp","temp","magatempjson",paste(path,"magatemp.json",sep=""))
convertToJSON("ehum","hum","eluhumjson",paste(path,"eluhum.json",sep=""))
convertToJSON("mhum","hum","magahumjson",paste(path,"magahum.json",sep=""))

saveRDS(total,file=totalpath)
