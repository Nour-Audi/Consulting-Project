#stochastic linkage for smaller subset of data
combined_results<-compare.dedup(combined_first_6, blockfld = list(7, c(2,3)), strcmp=1)
rpairs1<-epiWeights(combined_results)
getPairs(rpairs1, 0.5, 0.3)
results<-epiClassify(rpairs1, 0.4)


