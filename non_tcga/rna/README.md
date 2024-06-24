# Non-TCGA RNA results

## Repository information

The general workflow of the scripts in the directory is as follows:

1.) Download the data from the SRA archive -- download_all_files.sh

2.) Align the fastq files to the hg38 reference genome -- align_fastq.sh

3.) Create a gene count matrix for each sample and run MSI tools -- gen_count_matrix.sh

4.) Convert gene count matrix to MSIsensor-RNA and preMSIm format -- sensor_rna.sh

Note: This directory has been optimized for sample level parallelization using a SLURM HPC framework. There is an SBATCH chain in place
 to allow for seamless passing of sample ID's while checking to see if each step has run correctly. The preMSIm results can be obtained by 
running the preMSIm R package on the gene_count matrix in the premsim_results folder. There is no need to include a script to do this as the preMSIm
package only needs 1 line of code to be run on the gene count matrix.  

