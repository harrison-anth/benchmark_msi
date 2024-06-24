# P/N WXS results

## Repository information

The general workflow of the scripts in the directory is as follows:

1.) Download the data from SRA/ENA -- download_all_files.sh

2.) Align the fastq files to the hg38 reference genome -- align_fastq.sh

3.) Make VCF/MAF files for MSINGB -- make_vcf.sh | maf_gen.sh

4.) Run MSI tools -- msi_pn_wxs.sh

Each txt file contains useful information required for parallelization. The access_list.txt file contains all the SRA sample ID's used in this dataset. 
The SRA ID's are pre-sorted numerically. The tumor paired-normal For example, the first two SRA ID's are a tumor sample and then its paired normal. This allows for the user to use the sorted access list in a
parallelized job array where $JOB_ARRAY_ID * 2 = the tumor sample and ( $JOB_ARRAY_ID * 2 ) -1  = the normal sample.

Note: This directory has been optimized for sample level parallelization using a SLURM HPC framework. This directory does not incldue the SBATCH chain
at the end of the align_fastq script. This is because there are paired-normal samples, and we found it easier to fork the pipeline at the pre and post-BAM
creation steps. One would have to first submit the alignment job and then separately submit the jobs labeled steps 2, 3, and 4 above.  


  
