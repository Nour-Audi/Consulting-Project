#heat map to better show governorate 

#loading in shapefile from Hum Data

require(ggplot2)
require(gpclib)
require(maptools)

# Read the Syrian governorate shapefile data and plot
shpfile <- "/home/als1/raw2014/syr_admin1.shp" 
sh <- readShapeSpatial(shpfile)
plot(sh)

combined_first_6<-combined[as.Date(combined$date_of_death) %between% c("2011-03-15", "2011-09-15"),]

#death count per governorate from combined_first_6
death.table<-as.data.frame(table(combined_first_6$governorate), row.names=c("Missing", "Al-Hasakeh","Aleppo", "Ar-Raqqa", 
                                                       "As-Sweida", "Damascus", "Dar'a", "Deir-ez-Zor",
                                                       "Egypt", "Germany", "Hama", "Homs", "Idleb",
                                                       "Iraq", "Jordan", "Latakia", "Lebanon", "Palestine",
                                                       "Quneitra", "Rural Damascus", "Tartous", "Turkey",
                                                       "Other", "Saudi Arabia"))

death.table$names<-rownames(death.table)


sh2 <- merge(sh, death.table, by.x='NAME_EN', by.y='names')

# Set the palette
p <- colorRampPalette(c("white", "red"))(20)
palette(p)


# Scale the total population to the palette
pop <- sh2@data$Freq[complete.cases(sh2@data$Freq)]
cols <- (pop - min(pop))/diff(range(pop))*20
par(mfrow=c(1,2))
plot(sh, col=cols, main='Total for the First 6 Months')


#let's look at the last six months of data to compare
combined_last_6<-combined[combined$date_of_death %between% c("2013-10-15", "2014-04-15"),]

#death count per governorate from combined_last_6
death.table<-as.data.frame(table(combined_last_6$governorate), row.names=c("Missing", "Al-Hasakeh","Aleppo", "Ar-Raqqa", 
                                                                            "As-Sweida", "Damascus", "Dar'a", "Deir-ez-Zor",
                                                                            "Egypt", "Germany", "Hama", "Homs", "Idleb",
                                                                            "Iraq", "Jordan", "Latakia", "Lebanon", "Palestine",
                                                                            "Quneitra", "Rural Damascus", "Tartous", "Turkey",
                                                                            "Other", "Saudi Arabia"))

death.table$names<-rownames(death.table)


sh2 <- merge(sh, death.table, by.x='NAME_EN', by.y='names')

# Set the palette
p <- colorRampPalette(c("white", "red"))(20)
palette(p)


# Scale the total population to the palette
pop <- sh2@data$Freq[complete.cases(sh2@data$Freq)]
cols <- (pop - min(pop))/diff(range(pop))*20
plot(sh, col=cols, main='Total for the Last 6 Months')




#above was for the combined_first_6 file, let's do it for separate collections (total) to get a sense of jurisdictions
par(mfrow=c(2,2))
death.table.vdc<-as.data.frame(table(vdc$governorate), row.names=c("Missing", "Al-Hasakeh","Aleppo", "Ar-Raqqa", 
                                                                    "As-Sweida", "Damascus", "Dar'a", "Deir-ez-Zor",
                                                                     "Hama", "Homs", "Idleb",
                                                                   "Latakia", "Other",
                                                                    "Quneitra", "Rural Damascus", "Tartous"))


death.table.vdc$names<-rownames(death.table.vdc)


sh.vdc <- merge(sh, death.table.vdc, by.x='NAME_EN', by.y='names')

# Set the palette
p <- colorRampPalette(c("white", "red"))(20)
palette(p)


# Scale the total population to the palette
pop <- sh.vdc@data$Freq[complete.cases(sh.vdc@data$Freq)]
cols <- (pop - min(pop))/diff(range(pop))*20
plot(sh, col=cols, main='VDC Collection')


#SNHR
death.table.snhr<-as.data.frame(table(snhr$governorate), row.names=c("Missing", "Al-Hasakeh","Aleppo", "Ar-Raqqa", 
                                                                   "As-Sweida", "Damascus", "Dar'a", "Deir-ez-Zor",
                                                                   "Hama", "Homs", "Idleb", "Jordan",
                                                                   "Latakia", "Lebanon", "Other",
                                                                   "Quneitra", "Rural Damascus", "Saudi Arabia","Tartous"))


death.table.snhr$names<-rownames(death.table.snhr)


sh.snhr <- merge(sh, death.table.snhr, by.x='NAME_EN', by.y='names')

# Set the palette
p <- colorRampPalette(c("white", "red"))(20)
palette(p)


# Scale the total population to the palette
pop <- sh.snhr@data$Freq[complete.cases(sh.snhr@data$Freq)]
cols <- (pop - min(pop))/diff(range(pop))*20
plot(sh, col=cols, main='SNHR Collection')


#SCSR

death.table.scsr<-as.data.frame(table(scsr$governorate), row.names=c("Missing", "Al-Hasakeh","Aleppo", "Ar-Raqqa", 
                                                                     "As-Sweida", "Damascus", "Dar'a", "Deir-ez-Zor",
                                                                     "Egypt", "Germany", "Hama", "Homs", "Idleb", "Iraq",
                                                                     "Jordan" ,"Latakia", "Lebanon", "Palenstine",
                                                                     "Quneitra", "Rural Damascus", "Tartous", "Turkey"))


death.table.scsr$names<-rownames(death.table.scsr)


sh.scsr <- merge(sh, death.table.scsr, by.x='NAME_EN', by.y='names')

# Set the palette
p <- colorRampPalette(c("white", "red"))(20)
palette(p)


# Scale the total population to the palette
pop <- sh.scsr@data$Freq[complete.cases(sh.scsr@data$Freq)]
cols <- (pop - min(pop))/diff(range(pop))*20
plot(sh, col=cols, main='SCSR Collection')

