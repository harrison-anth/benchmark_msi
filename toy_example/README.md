This directory contains a toy example of the scripts used to generate the results in this study. 
The run.sh script has been preset to run MSI NGS tools on small subsetted bam files.

The preset bams have been subset down to contain only microsatellite sites on chromsome 7 to avoid Github's large file size limits.

The bam files are from publicly available SRA files. These include a whole exome sequencing tumor sample (SRR14555852) and
its paired-normal (SRR14555853). The tumor-only RNA sequencing file is from SRA sample SRR15197363.


Simply change the filenames/paths in the run.sh script to use your own bam files. While run.sh should work with local installations
of each MSI tool, it is advisable to use the conda environments for each tool provided in this repository's envs/ directory. 


