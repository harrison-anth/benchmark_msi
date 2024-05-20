# Evaluating the performance of several MSI tools on next-generation sequencing data. 
### Information about the author(s) of this code:
Name(s): Harrison Anthony 
contact information: h dot anthony1 at universityofgalway dot ie

## Repository information

### Conda environments
The conda_envs folder contains all conda environments used for data handling and all MSI tools.

sensor.yml was used to run MSIsensor MSIsensor2 and MSIsensor-pro

msings.yml was used to run msiNGS

MSIR.yml was used to run R code

mantis.yml was used to run MANTIS

vcf2maf.yml was used to convert from vcf file format to maf file format

### Scripts
All code used to generate results were seperated into two directories.
The first bash pipeline is used to handle and identify MSI status with TCGA data (tcga directory). While effort has been made to comment throughout the code,
each script is generally defined as such:

master.sh - A master script to define the paramters of the GDC data to be downloaded

manifest_gen.sh - Generates the GDC manifest file with paramters specified in the master script. Manifests are then split for each individual and written out to the manifests directory.

manifest_gen.R - R script used to stochastically sample from the GDC manifest and write out the manifest files.

downloader.sh - Downloads GDC data 

filer.sh - subsets large WGS and WXS bam files down to their microsatellites

msi_passer.sh - defines which MSI tools should be run

pro.sh - runs msisensor-pro

sensor2.sh - runs msisensor2

sensor.sh - runs msisensor

sensor_rna.sh - runs msisensor-rna

sensor_rna_shaper.R - reformats gene count matrices for use with msisensor-rna

gen_count_matrix.sh - create gene count matrix from TCGA RNA sequencing data

mantis.sh - runs MANTIS

make_msings_baseline.sh - Creates msings baseline from 20 normal files

make_pro_baseline.sh - Creates MSIsensor-pro baseline from 20 normal files

make_sensor_rna_baseline.sh - Creates MSIsensor-rna baseline from 20 normal files and 7 MSI-H samples

msings.sh - runs mSINGS

#### The following code was used exclusively for TCGA-RNA samples

rna.sh - Alternate version of the master script to handle rna samples. 

rna_msih.sh - Alternate version of the master script to sample MSI-H cases for use with baseline generation

rna_normals.sh - Alternate version of the master script to randomly sample the paired normals for use with baseline generation


### All non-TCGA datasets and the code used to generate the results are in their own subdirectories under the non_tcga directory.

All non-TCGA datasets have their own pipelines loosley based on the code used to generate the TCGA results. The only difference being that there is
an alignment script used to align the fastq files to a reference genome, and that the MSI tools run files might have been concatenated into one script
(typically titled dataset_msi.sh)

# Graphs and results

## All the code necessary to generate the graphs used in the paper are stored in two Rmarkdown file titled final_pub_fig_file3.rmd and cpu_time.rmd).

All the results for this study have been reduced down to their smallest necessary files and are stored in the appropriate subdirectory for each dataset
(for example pn_wxs/sensor2_results will have the results for MSIsensor2 on the additional paired-normal WXS dataset used in the study). 

Please feel free to reach out with any questions if this README has not answered your questions. 


and another that converts the pipeline for use with non-TCGA data (non_tcga directory).
Each subdirectory contains all code and results for that particular dataset.
All directories fall the same naming scheme for datasets that were used in our manuscript.

