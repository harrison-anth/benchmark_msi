# T/O WXS results

## Repository information

The general workflow of the scripts in the directory is as follows:

1.) Download the data from the SRA archive -- download_all_files.sh

2.) Align the fastq files to the hg38 reference genome -- align_fastq.sh

3.) Make VCF/MAF files for MSINGB -- make_vcf.sh | maf_gen.sh

4.) Run MSI tools -- msi_to_wxs.sh


Note: This directory has been optimized for sample level parallelization using a SLURM HPC framework. There is an SBATCH chain in place
 to allow for seamless passing of sample ID's while checking to see if each step has run correctly.



  
