library(tidyverse)
library(data.table)
library(janitor)

f_files<- list.files("../count_matrices", pattern = ".counts", full.names = T)


read_in_feature_counts<- function(file_list){
d=1
for( f in file_list){
if(d==1){
sample_name <- gsub(f,pattern='count_matrices/',replacement='')
sample_name <- gsub(sample_name,pattern='.counts',replacement='')
temp <- fread(f)
temp <- data.frame(temp[,c(1,7)])
colnames(temp) <- c('gene_id','counts')
temp$log <- log2(temp$counts+1)
temp$scaled <- (temp$log -min(temp$log))/(max(temp$log)-min(temp$log))
temp2 <- data.frame(temp$gene_id,temp$scaled)
colnames(temp2) <- c('gene_id',sample_name)
d=d+1
fin_df <- temp2
}
else{
sample_name <- gsub(f,pattern='count_matrices/',replacement='')
sample_name <- gsub(sample_name,pattern='.counts',replacement='')
temp <- fread(f)
temp <- data.frame(temp[,c(1,7)])
colnames(temp) <- c('gene_id','counts')
temp$log <- log2(temp$counts+1)
temp2 <- data.frame(temp$gene_id,temp$log)
colnames(temp2) <- c('gene_id',sample_name)

fin_df <- merge(fin_df,temp2,by="gene_id",all.x=TRUE)
}
}
return(fin_df)
}
results <- read_in_feature_counts(f_files)
results2 <- as.data.frame(t(results))
results3 <- row_to_names(dat=results2,row_number=1)

results3 <- results3 %>% rownames_to_column('SampleID')

fwrite(results3,'../sensor_rna_results/all_samples.csv',sep=',')

