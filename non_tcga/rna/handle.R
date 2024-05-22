library(tidyverse)
library(data.table)
library(PreMSIm)

path=system.file('extdata','example.txt',package='PreMSIm',mustWork=TRUE)
input_data <- data_pre(path,type='ID')



f_files<- list.files("count_matrices", pattern = ".counts", full.names = T)

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
temp$scaled <- (temp$log -min(temp$log))/(max(temp$log)-min(temp$log))
temp2 <- data.frame(temp$gene_id,temp$scaled)
colnames(temp2) <- c('gene_id',sample_name)

fin_df <- merge(fin_df,temp2,by="gene_id",all.x=TRUE)
}
}
return(fin_df)
}

results <- read_in_feature_counts(f_files)
results2 <- results
results$gene_id=NULL

results3 <- t(as.matrix(results,rownames.value=results2$gene_id))
#just pass results to local. Not sure why yet but lugh can't give premsim output
row.names(results) <- results$gene_id
results$gene_id <- NULL
results <- t(as.matrix(results))

