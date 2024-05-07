# Evaluating the performance of several MSI tools on next-generation sequencing data. 
### Information about the author(s) of this code:
Name(s): Harrison Anthony 
contact information: h dot anthony1 at universityofgalway dot ie

## Repository information

### Conda environments
The conda_envs folder contains all conda environments used for data handling and all MSI tools.

sensor.yml was used to run MSIsensor MSIsensor2 and MSIsensor-pro

msings.yml was used to run msiNGS

mantis.yml was used to run MANTIS

vcf2maf.yml was used to convert from vcf file format to maf file format

### Scripts
All code used to generate results was seperated into two pipelines.
One that creates GDC manifest files for use with TCGA data (tcga directory) and another that converts the pipeline for use with non-TCGA data (non_tcga directory).


