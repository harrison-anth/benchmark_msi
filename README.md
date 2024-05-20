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







and another that converts the pipeline for use with non-TCGA data (non_tcga directory).
Each subdirectory contains all code and results for that particular dataset.
All directories fall the same naming scheme for datasets that were used in our manuscript.

