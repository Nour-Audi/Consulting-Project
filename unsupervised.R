##unsupervised classification for smaller subsets of the data (first 6 months)

#generating training data 
generated.samples<-genSamples(combined_results, num.non= 303329) #combined_results is from compare_dedup_each_collection
generated.samples<-splitData(combined_results, prop=0.01, num.non=303329)

combined_results<-compare.dedup(combined_first_6, blockfld = list(7, c(2,3)), strcmp=1)

#UNSUPERVISED CLASSIFICATION METHODS
kmeans<-classifyUnsup(combined_results, 'kmeans')
summary(kmeans)
bclust<-classifyUnsup(combined_results, 'bclust')
summary(bclust)
