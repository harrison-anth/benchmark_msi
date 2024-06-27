library(tidyverse)
library(data.table)
library(janitor)

f1 <- "temp/SRR15197363.counts"

sample_name <- sample_name <- gsub(f1,pattern='/temp',replacement='')
sample_name <- gsub(sample_name,pattern='.counts',replacement='')





temp <- fread(f1)
temp <- data.frame(temp[,c(1,7)])
colnames(temp) <- c('gene_id','counts')
temp$log <- log2(temp$counts+1)
#temp$scaled <- (temp$log -min(temp$log))/(max(temp$log)-min(temp$log))
temp2 <- data.frame(temp$gene_id,temp$log)
colnames(temp2) <- c('gene_id',sample_name)
results <- temp2
results2 <- as.data.frame(t(results))
results3 <- row_to_names(dat=results2,row_number=1)

results3 <- results3 %>% rownames_to_column('SampleID')

fwrite(results3,'temp/all_samples.csv',sep=',')

