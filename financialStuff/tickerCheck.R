#FUNCTION THAT TAKES IN STOCK TICKER SYMBOL, OUTPUTS A TABLE OF FINANCIAL RATIOS
#IN DEVELOPMENT!!

#LOAD REQUIRED PACKAGES
require(XML)

#TAKES IN TICKER SYMBOL, OUTPUTS RATIOS
doAnalysis<-function(ticker)
{
  #MAKE URL STRINGS
  ISurl<-paste("http://finance.yahoo.com/q/is?s=",ticker,"+Income+Statement&annual",sep="")
  BSurl<-paste("http://finance.yahoo.com/q/bs?s=",ticker,"+Balance+Sheet&annual",sep="")
  urlstr<-c(ISurl,BSurl)
  #GET INFO AS HTML TABLE, TRIM INFO
  for(a in seq(urlstr))
  {
    tbl<-readHTMLTable(urlstr[a])
    tbl<-data.frame(tbl[5])
    tbl<-data.frame(tbl[5:nrow(tbl)-4,]) #CUT TOP & BOTTOM ROWS
    colnames(tbl)<-c("Item","y1","y2","y3") #NAME COLUMNS
    
    #PREP TO SAVE NONEMPTY ROWS
    rlist<-c()  #LIST OF SAVED ROWS
    for(x in seq(nrow(tbl)))
    {
      if(!is.na(tbl[x,3]))
      {
        rlist<-c(rlist,x)  #SAVE ROWS THAT AREN'T NA ON THIRD COLUMN
      }
    }
    dtbl<-rbind(tbl[rlist,])  #PUT ALL IMPORTANT ROWS IN ONE DATA.FRAME
    t1<-data.frame()
    tt1<-c()
    t2<-data.frame()
    tt2<-c()
    finTbl<-data.frame()
    for(x in seq(nrow(dtbl)))
    {
      if(as.character(dtbl[x,1])=="")
      {
        t1<-rbind(t1,dtbl[x,2:5])
        tt1<-c(tt1,x) #REMEMBER WHICH ROWS WERE SWITCHED
      } 
      else 
      {
        t2<-rbind(t2,dtbl[x,1:4])
        tt2<-c(tt2,x) #REMEMBER WHICH ROWS REMAINED THE SAME
      }
    }
    #MAKE COLUMN NAMES THE SAME FOR BINDING
    colnames(t1)<-c("Item","y1","y2","y3")
    #PUT TOGETHER IN ONE DATA.FRAME
    for(x in seq(nrow(dtbl)))
    {
      if(is.na(match(x,tt1)))
      {
        finTbl<-rbind(finTbl,t2[match(x,tt2),])
      } 
      else 
      {
        finTbl<-rbind(finTbl,t1[match(x,tt1),])
      }
    }
    #CONVERT NUMBER COLUMNS TO NUMBERS AND ZERO OUT NA CELLS
    for(x in seq(ncol(finTbl)-1))
    {
      q<-as.character(finTbl[,x+1]) #CONVERT TO STRINGS
      q<-gsub(",","",q) #REMOVE COMMAS FROM STRINGS
      finTbl[,x+1]<-q
      finTbl[,x+1]<-as.numeric(finTbl[,x+1])
      finTbl[is.na(finTbl[,x+1]),x+1]<-0
    }
    if(a==1)
    {
      assign("istbl",finTbl)
    } 
    else 
    {
      assign("bstbl",finTbl)
    }
  }
  
  y<-c()
  #GET YEARS AS INTEGERS
  for(i in seq(ncol(t2)-1))
  {
    y[i]<-as.integer(substr(as.character(t2[1,i+1]),nchar(as.character(t2[1,i+1]))-3,nchar(as.character(t2[1,i+1]))))
  }
  
  #SET VARIABLES
  revenue<-istbl[which(istbl[,1]=="Total Revenue"),2:4]
  cogs<-istbl[which(istbl[,1]=="Cost of Revenue"),2:4]
  profit<-istbl[which(istbl[,1]=="Net Income"),2:4]
  currentassets<-bstbl[which(bstbl[,1]=="Total Current Assets"),2:4]
  totalassets<-bstbl[which(bstbl[,1]=="Total Assets"),2:4]
  currentliability<-bstbl[which(bstbl[,1]=="Total Current Liabilities"),2:4]
  totalliability<-bstbl[which(bstbl[,1]=="Total Liabilities"),2:4]
  totalequity<-bstbl[which(bstbl[,1]=="Total Stockholder Equity"),2:4]
  
  #RATIOS
  profit.margin<-profit/revenue
  asset.turnover<-revenue/totalassets
  equity.multiplier<-totalassets/totalequity
  roa<-profit/totalassets
  roe<-profit/totalequity
  current<-currentassets/currentliability
  debttoasset<-totalliability/totalassets
  
  analysis<-rbind(profit.margin,asset.turnover,roa,roe,equity.multiplier,current,debttoasset)
  #APPLY ROW NAMES
  row.names(analysis)<-c("Proft Margin","Asset Turnover","Return_Assets","Return_Equity","Equity_Multiplier","Current Ratio","Debt to Asset")
  #APPLY YEARS TO COLUMN NAMES
  colnames(analysis)<-c(y)
  #ROUND NUMBERS TO THOUSANDTHS
  analysis<-round(analysis,3)
  #REORGANIZE COLUMNS TO CHRONOLOGICAL ORDER
  analysis<-analysis[,c(3,2,1)]
  #MAKE COMPANY COLUMN FOR TRACKING
  comp<-c()
  comp[1:nrow(analysis)]<-ticker
  analysis<-cbind(comp,analysis)
  
  if(exists("completeanalysis"))
  {
    completeanalysis<<-rbind(completeanalysis,analysis)
  } 
  else 
  {
    completeanalysis<<-analysis
  }
  
}




