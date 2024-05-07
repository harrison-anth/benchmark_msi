library(data.table)
library(tidyverse)
library(R.utils)

set.seed(15827271)

argus <- (commandArgs(asValues=TRUE, excludeReserved=TRUE)[-1])
status <- argus[1]
seq <- argus[2]
sample <- argus[3]
numba  <- as.numeric(argus[4])
random <- argus[5]
paired <- argus[6]

key <- fread(paste0("../master_keys/",status,"_",seq,"_master2.manifest"))


if(sample == "N"){
key_filt <- filter(key, sample_type == "N")} else if (sample == "T") {
key_filt <- filter(key, sample_type == "T")} else {quit()}


if(random == "T"){
ran <- sample_n(key_filt,size=numba,replace=FALSE)
} else { ran <- key_filt[1:numba,] } 

if(paired == "T") {
temp <- filter(key, case_id %in% ran$case_id & (sample_type == "N" | sample_type == "N*"))
ran <- rbind(ran,temp)
}

fwrite(ran,paste0("../manifests/",status,"_",seq,"_",numba,".manifest"),sep="\t")

for (i in 1:nrow(ran)){
run=ran[i,]
fwrite(run,paste0("../manifests/",status,"_",seq,"_",numba,"_",i),sep="\t")

}
successful_download_list <- data.frame(samp_id="successful_downloads_listed_below")
fwrite(successful_download_list, paste0("../successes/",status,"_",seq,"_",numba,".successes"),sep="\t")

#fwrite(ran, paste0(status,"_",seq,"_",sample,"_",random,"_",num,".manifest"),sep="\t")



####code previously in tool_prep.R ; might as well just do it all at the beginning####

if(paired == "T") {
key <- fread(paste0("../manifests/",status,"_",seq,"_",numba,".manifest"))

paired_df <- data.frame(tumor_sample=NA,normal=NA,uniqlo=NA)

temp <- filter(key, sample_type == "T")

for(i in 1:nrow(temp)) {
temp2 <- filter(key, case_id %in% temp$case_id[i] & (sample_type == "N" |
sample_type =="N*"))

if(nrow(temp2)<1){
next}

lolcat <- sample(temp2$filename,size=1)

new_row <- c(temp$filename[i],lolcat,paste0(temp$filename[i],'_',lolcat))
paired_df[i,] <- new_row
}



for (i in 1:nrow(paired_df)){
p1=paired_df[i,]
fwrite(p1,paste0("../manifests/",status,"_",seq,"_",numba,".pair",i),sep="\t")

}
}

#fwrite(temp,paste0("../manifests/",status,"_",seq,"_",numba,"t_list"),sep="\t")
