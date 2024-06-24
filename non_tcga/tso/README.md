# TSO500 gene panel results

## Repository information

The general workflow of the scripts in the directory is as follows:

1.) Download the data from the SRA archive -- download_all_files.sh

2.) Align the fastq files to the hg38 reference genome -- aln1_fastq.sh & aln2_fastq.sh

3.) Make VCF/MAF files for MSINGB -- make_vcf.sh | maf_gen.sh

4.) Run MSI tools -- tso_msi.sh

Note: This directory has been optimized for sample level parallelization using a SLURM HPC framework. There is an SBATCH chain in place
 to allow for seamless passing of sample ID's while checking to see if each step has run correctly. The sample ID's used are split amongst two different
naming schemes. To accomodate this, we split the align fastq scripts into aln1_fastq and aln2_fastq. Otherwise, these results are generated in the same manner
as all other tumor-only results. 



  
