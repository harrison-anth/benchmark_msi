#!/bin/sh
#SBATCH --job-name="maf"
#SBATCH --output=out_files/maf.out
#SBATCH --error=error_files/maf.error
#SBATCH --partition="normal","highmem"
#SBATCH --mem=30G

module load Anaconda3
conda activate vcf22maf

#set perl5 lib to null as it causes problems with vep
PERL5LIB=""

ref=/data3/hanthony/reference_files/GRCh38.d1.vd1.fa

vcf=$1
tum_id=$2
if [ ! -f maf/$tum_id.maf ]
then
vcf2maf.pl --input $vcf \
--output-maf maf/$tum_id.maf \
--ref-fasta $ref \
--vep-path /data3/hanthony/.conda_envs/vcf22maf/bin \
--vep-data /data4/hanthony/vep_files/ \
--ncbi-build GRCh38
fi

sbatch msingb.sh $tum_id
