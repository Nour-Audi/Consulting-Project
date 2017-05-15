#combining data sources

library(data.table)


#Reading in Data
#-------------------------------------------------------------------------------

scsr= fread("SCSR-2014.csv", sep="|", stringsAsFactors=FALSE, encoding='UTF-8')
snhr = fread("SNHR-2014.csv", sep="|", encoding='UTF-8')
vdc = fread("VDC-2014.csv", sep="|", encoding='UTF-8')

#Applying Filter
#-------------------------------------------------------------------------------

filterSyria = function(filtertest, data) { 
  filterVec = rep(NA, length(data))
  filterVec = (data == "") | (data == "الطفل") | (data == " ") | (data == ")") | (grepl(")", data)) | (grepl("مجهول", data)) | (data %in% filtertest) | (data == "( لم يصل الاسم )") | (grepl("\\?", data)) | (grepl("\\.", data)) | (grepl("\\*", data)) | (grepl("From Samha family", data)) | (grepl("unknown", data))
  return(filterVec)
}

anontoken = read.table("filter_test.txt", sep="\n", header=FALSE, stringsAsFactors=FALSE)
filtertest = c(anontoken)

real_filter = rep(0, length(filtertest))
for (ii in 1:length(filtertest$V1)) {
  real_filter[ii] = trimws(filtertest$V1[ii])
}

vdc_missing = vdc[filterSyria(real_filter, vdc$name), ]
nrow(vdc)
nrow(vdc_missing)
nrow(vdc_missing) / nrow(vdc)
scsr_missing = scsr[filterSyria(real_filter, paste(scsr$name, scsr$father_name, scsr$surname)), ]
nrow(scsr)
nrow(scsr_missing)
nrow(scsr_missing) / nrow(scsr)
snhr_missing = snhr[filterSyria(real_filter, snhr$fullname), ]
nrow(snhr)
nrow(snhr_missing)
nrow(snhr_missing) / nrow(snhr)

vdc= vdc[!filterSyria(real_filter, vdc$name), ]
scsr = scsr[!filterSyria(real_filter, paste(scsr$name, scsr$father_name, scsr$surname)), ]
snhr = snhr[!filterSyria(real_filter, snhr$fullname), ]


write.csv(vdc, file="VDC_filtered.csv")
write.csv(scsr, file="SCSR_filtered.csv")
write.csv(snhr, file="SNHR_filtered.csv")


#lets match the ID from train_data to the records in combined dataset
scsr.fullname<-as.data.frame(paste(scsr$name, scsr$father_name, scsr$surname))
colnames(scsr.fullname)[1]<-"name"
names<-data.frame(rbindlist(list(scsr.fullname, data.frame(snhr$fullname), 
                                 data.frame(vdc$name))))
governorate<-data.frame(rbindlist(list(data.frame(scsr$governorate), 
                                            data.frame(snhr$governorate), 
                                            data.frame(vdc$governorate))))
date.of.death<-data.frame(rbindlist(list(data.frame(scsr$date_of_death), 
                                         data.frame(snhr$date_of_death), 
                                         data.frame(vdc$date_of_death))))
age<-data.frame(rbindlist(list(data.frame(scsr$age), 
                               data.frame(snhr$age), 
                               data.frame(vdc$age))))

sex<-data.frame(rbindlist(list(data.frame(scsr$sex), 
                               data.frame(snhr$sex), 
                               data.frame(vdc$sex))))
record_id<-data.frame(rbindlist(list(data.frame(scsr$record_id),
                                     data.frame(snhr$record_id),
                                     data.frame(vdc$record_id))))


combined<-cbind(names, governorate, date.of.death, age, sex, record_id)
colnames(combined)<-c("name", "governorate", "date_of_death", "sex", "age", "id")
length(which(duplicated(combined)==TRUE))

#attaching indicators to the combined dataset solely based on name
binary.scsr<-c()
binary.snhr<-c()
binary.vdc<-c()

#NOTE:this takes a few minutes for each dataset. Solely matching based on dataset 
for (i in 1:nrow(combined)){
  binary.scsr[i]<-ifelse(is.na(match(combined$name[i], scsr.fullname$name)),0,1)
  binary.snhr[i]<-ifelse(is.na(match(combined$name[i], snhr$fullname)), 0,1)
  binary.vdc[i]<-ifelse(is.na(match(combined$name[i], vdc$name)), 0,1)
}
#combined$scsr<-binary.scsr
#combined$snhr<-binary.snhr
combined$vdc<-binary.vdc


