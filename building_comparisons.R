#subset for the first 6 months
vdc_first_6<-vdc[as.Date(vdc$date_of_death) %between% c("2011-03-15", "2011-09-15"),] 
snhr_first_6<-snhr[as.Date(snhr$date_of_death) %between% c("2011-03-15", "2011-09-15"),] 
scsr_first_6<-scsr[as.Date(scsr$date_of_death) %between% c("2011-03-15", "2011-09-15"),] 
combined_first_6<-combined[as.Date(combined$date_of_death) %between% c("2011-03-15", "2011-09-15"),]

#first 5 letters of the name
vdc_first_6$first_5_letters<-apply(as.matrix(vdc_first_6$name), 1, substr, 1, 5)
snhr_first_6$first_5_letters<-apply(as.matrix(snhr_first_6$fullname), 1, substr, 1, 5)
scsr_first_6$first_5_letters<-apply(as.matrix(scsr_first_6$name), 1, substr, 1, 5)
combined_first_6$first_5_letters<-apply(as.matrix(combined_first_6$name), 1, substr, 1, 5)

# filtering out names that are Mohammed 
vdc_first_6<-vdc_first_6[,]
snhr_first_6<-snhr_first_6[-grep(".*محمدم.*",snhr_first_6$name),]
scsr_first_6<-scsr_first_6[-grep(".*محمدد.*",scsr_first_6$name),]
combined_first_6<-combined_first_6[-grep(".*محمدد.*",combined_first_6$name),]

#compare.dedup
# we use our standard blocking field of (first 5 letters of name) OR (governorate AND date_of_death)
#--------------------------------------------------------------------------------------
vdc_results<-compare.dedup(vdc_first_6, blockfld = list(25,c(3,13)), strcmp=2)
summary(vdc_results)

snhr_results<-compare.dedup(snhr_first_6, blockfld = list(17, c(2, 3)), strcmp=1)
summary(snhr_results)

scsr_results<-compare.dedup(scsr_first_6, blockfld = list(13, c(4, 5)), strcmp=2)
summary(scsr_results)
#more stringent blocking rules for SCSR- all name fields
scsr_first_6$first_5_letters_lastname<-apply(as.matrix(scsr_first_6$surname), 1, substr, 1, 5)
scsr_results<-compare.dedup(scsr_first_6, blockfld = list(c(13,14), c(4, 5)), strcmp=2)


combined_results<-compare.dedup(combined_first_6, blockfld = list(7, c(2,3)), strcmp=1)
summary(combined_results)


#compare.linkage
#--------------------------------------------------------------------------------------


## exploration of compare.linkage: compare.linkage is used for 2 datasets
colnames(snhr_first_6)[1]<-"name"

#things have to be ordered in the same way
linkage_results<-compare.linkage(vdc_first_6[,c(1:4, 8, 13, 25)],snhr_first_6[,c(16, 1,3, 6:7,2, 17)], 
                                 blockfld=list(7, c(3,6)), strcmp = 7) #note that it can run fairly quickly

summary(linkage_results)


#seeing if we can achieve any results with training data
#----------------------------------------------------------------------------
vdc_train<-train_data[grep("VDC",train_data$id),]
vdc_train<-vdc_train[as.Date(vdc_train$date_of_death) %between% c("2011-03-15", "2011-09-15"),] 
matches <- regmatches(vdc_train$id, gregexpr("[[:digit:]]+", vdc_train$id))
vdc_train$id<-as.numeric(unlist(matches))
vdc_first_6_with_train<-vdc_first_6[intersect(vdc_first_6$record_id, vdc_train$id),]
#take out record_id and call original id record id
vdc_train_2<-vdc_train[intersect(vdc_first_6$record_id, vdc_train$id), -3]
colnames(vdc_train_2)[13]<-"record_id"
vdc_results<-compare.dedup(vdc_first_6_with_train, blockfld = list(25,c(3,13)), strcmp=2, identity=vdc_train_2$record_id)
summary(vdc_results)

snhr_train<-train_data[grep("SNHR",train_data$id),]
matches <- regmatches(snhr_train$id, gregexpr("[[:digit:]]+", snhr_train$id))
snhr_train$id<-as.numeric(unlist(matches))
colnames(snhr_train_2)[13]<-"record_id"
snhr_train_2<-snhr_train[which(snhr_train$record_id %in% intersect(snhr_first_6$record_id, snhr_train$record_id)), -3]

snhr_first_6_with_train<-snhr_first_6[which(snhr_first_6$record_id %in% intersect(snhr_first_6$record_id,
                                                                                snhr_train$record_id)),]

snhr_results<-compare.dedup(snhr_first_6_with_train, blockfld = list(17, c(2, 3)), strcmp=1, identity=snhr_train_2$record_id)
summary(snhr_results)
