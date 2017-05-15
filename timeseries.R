#time series plots around for full data, first 6 months, and Aleppo
vdc$date_of_death <- as.Date(vdc$date_of_death, format="%Y-%d-%m")

##tabulate based on month
vdc.full.month <- data.frame(table(cut(vdc$date_of_death, 'month')))
colnames(vdc.full.month)<-c("Month", "Count")

#creating time series object
ts.vdc<-data.frame(sort(unique(vdc$date_of_death)),tabulate(as.factor(vdc$date_of_death)))
colnames(ts.vdc)<-c("Date","Count")
vdc.ts.full<-ts(vdc.full.month$Count, start=c(2011,1), frequency=12)
vdc.ts.first6<-ts(ts.vdc$Count,start= as.Date('2011-03-18'), end=as.Date('2011-09-15'), frequency=1)
vdc.ts<-ts(ts.vdc$Count[177:189], start= as.Date('2012-07-01'))
#plot(vdc.ts)


snhr$date_of_death <- as.Date(snhr$date_of_death, format="%Y-%d-%m")

##tabulate based on month
snhr.full.month <- data.frame(table(cut(snhr$date_of_death, 'month')))
colnames(snhr.full.month)<-c("Month", "Count")


ts.snhr<-data.frame(sort(unique(snhr$date_of_death)),tabulate(as.factor(snhr$date_of_death)))
colnames(ts.snhr)<-c("Date","Count")
snhr.ts.full<-ts(snhr.full.month$Count, start=c(2011,1), frequency=12)
snhr.ts.first6<-ts(ts.snhr$Count,start= as.Date('2011-03-18'), end=as.Date('2011-09-14'), frequency=1)
snhr.ts<-ts(ts.snhr$Count[175:187], start= as.Date('2012-07-01'))


#time series plots around for full data, first 6 months, and Aleppo
scsr$date_of_death <- as.Date(scsr$date_of_death, format="%Y-%d-%m")

##tabulate based on month
scsr.full.month <- data.frame(table(cut(scsr$date_of_death, 'month')))
scsr.full.month<-scsr.full.month[-c(1:7),]
colnames(scsr.full.month)<-c("Month", "Count")

ts.scsr<-data.frame(sort(unique(scsr$date_of_death)),tabulate(as.factor(scsr$date_of_death)))
ts.scsr<-ts.scsr[-c(1:2),]
colnames(ts.scsr)<-c("Date","Count")
scsr.ts.full<-ts(scsr.full.month$Count, start=c(2011,1), frequency=12)
scsr.ts.first6<-ts(ts.scsr$Count,start= as.Date('2011-03-18'), end=as.Date('2011-09-28'), frequency=1)
scsr.ts<-ts(ts.scsr$Count[172:184],  start= as.Date('2012-07-01'))

par(xpd=TRUE) 


##--------FIRST 6 MONTHS----##
ts.plot(vdc.ts.first6, snhr.ts.first6, scsr.ts.first6,gpars=list(xlab="Day", ylab="Deaths", main='First 6 Months',
                                                           lty=c(1:3), xaxt = "n") )
#adding legend
legend("topright",legend=c("VDC", "SNHR", "SCSR"), 
       lty = c(1,2,3), cex=0.5, title='Collection Group')

axis(1, ts.vdc$Date,format(ts.vdc$Date, "%Y-%m"), cex.axis = .5)

##--------AROUND BATTLE OF ALEPPO--------##

ts.plot(vdc.ts, snhr.ts,scsr.ts,gpars=list(xlab="Day", ylab="Deaths", main='Deaths Around Battle of Aleppo in July 2012',
                                           lty=c(1:3), xaxt = "n"))
#adding legend
legend("topright",legend=c("VDC", "SNHR", "SCSR"), 
       lty = c(1,2,3), cex=0.5, title='Collection Group')

#formatting x-axis dates
ts.vdc$Date <- as.Date(ts.vdc$Date, "%Y-%m-%d")
ts.scsr$Date<-as.Date(ts.scsr$Date, "%Y-%m-%d")
ts.snhr$Date<-as.Date(ts.snhr$Date, "%Y-%m-%d")


axis(1, ts.vdc$Date, format(ts.vdc$Date, "%b %d"), cex.axis = .5)


