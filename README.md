# Evaluating the performance of several MSI tools on next-generation sequencing data. 
### Information about the author(s) of this code:
Name(s): Harrison Anthony 
contact information: h dot anthony1 at universityofgalway dot ie

Questions regarding this repository can be directed to me at the following email address: h.anthony1 at universityofgalway dot ie
I will also respond to github issues and messages. 

## Repository information

The conda_envs folder contains all conda environments used to run each MSI tool. The sensor.yml file can be used to run MSI-sensor MSI-sensor2 and MSI-sensor pro



### 10.1001/jamanetworkopen.2020.3959 Description of scripts and steps in pipeline for use in 200k release:
bed2vcf.sh creates vcf file from UKB bed/bim/fam files and creates tbi indexes. vcf files are then filtered for lynch syndrome 
variants with hg38 positions found in scripts/ref_lists
#### Note on above comment: vcf's no longer have to be remapped to hg19 (as done in referential publication) Scripts used to 
#### remap are now in defunct_files directory
find_lynch.R is then used to write files which contain variant files with sample ID of carriers and their variants. Lastly, 
summarize.R is used to generate list of sample ID's and a summary table of variant information. All results and UKB data is 
stored in /data/UKB/harrison/lynch_syndrome/
#### Information on variants that were called with the 200k release and 50k FE pipeline 
#### https://biobank.ndph.ox.ac.uk/ukb/label.cgi?id=170
