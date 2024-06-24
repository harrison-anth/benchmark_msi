# Pipeline to generate all TCGA results

The workflow of this pipeline works in the following steps:

1.) Set the parameters of the GDC data to be downloaded -- master.sh

2.) Generate GDC manifest file -- manifest-gen.sh

3.) Download GDC data -- downloader.sh

4.) Trim WGS/WXS files down to only microsatellite regions (optional) -- filer.sh

5.) Run MSI tools -- msi_passer.sh

6.) Create MAF files and run MSINGB -- make_vcf.sh

7.) Create gene count matrices and run MSIsensor-RNA and preMSIm -- rna.sh | gen_count_matrix.sh


Note: These scripts are all part of SBATCH chains designed for use with a SLURM HPC environment. For examples to generate the results of each MSI tool on
a local linux based operating system, please see the toy example included with this GitHub. We have also included the code used to generate the baselines
for the tumor-only MSI tools. These are bash files named make_msings_baseline.sh, make_pro_baseline.sh, etc. 
 
