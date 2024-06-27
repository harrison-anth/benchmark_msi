library(PreMSIm)
library(data.table)
library(tidyverse)

path = system.file("extdata", "example.txt", package = "PreMSIm", mustWork = TRUE)
input_data = data_pre(path, type = "ID")
temp <-fread("temp/SRR15197363.counts",header = TRUE)
temp <- temp[,c(1,7)]
temp2 <- temp
temp$Geneid <- NULL 

temp3 <- t(as.matrix(temp,rownames.value=temp2$Geneid))

msi_results <- msi_pre(temp3[,c(colnames(input_data))]) 

msi_results$pcr_status <- NA msi_results$binary <- NA for(i in 1:nrow(msi_results)){ Sample <- 
msi_results$Sample[i] if(tcga == TRUE){
      if(Sample %in% msih_rna_key$`File ID`){
        msi_results$pcr_status[i]="High"
        msi_results$binary[i]=1
      } else if( Sample %in% msil_rna_key$`File ID`){
        msi_results$pcr_status[i]="Stable"
        msi_results$binary[i]=0
      } else if (Sample %in% mss_rna_key$`File ID`){
        msi_results$pcr_status[i]="Stable"
        msi_results$binary[i]=0
      } else{msi_status$pcr_status[i]="ERROR"
      msi_results$binary[i]='ERROR'}
} else if (tcga == FALSE){
  temp20 <- filter(misc_key, samp_id == Sample)
      if(nrow(temp20)==0){
        next}
      else if(is.na(temp20$status)){
        status = NA
        binary = NA
      }else if(temp20$status == "MSIH"){
        status="High"
        binary= 1
      } else if (temp20$status =="MSS" | temp20$status == "MSIL"){
        status="Stable"
        binary=0
      } else { status="?"
      binary="?"}
  msi_results$pcr_status[i] <- status msi_results$binary[i] <- binary
  
}
}
msi_results$score <- NA for(i in 1:nrow(msi_results)){ if(msi_results$MSI_status[i] == 0){
  msi_results$score[i] <- 'MSS'
} else if (msi_results$MSI_status[i] == 1){
  msi_results$score[i] <- 'MSI-H'
} else {msi_results$score[i] <- 'ERROR'}
}
  if(raw==FALSE){
    temp21 <- filter(msi_results, pcr_status != "NA")
    temp21 <- filter(temp21, pcr_status != "?")
     }
  if(nrow(temp21) == 0){
    temp21 <- c("filtered out all data")
  }
  msi_results <- temp21 return(msi_results)
