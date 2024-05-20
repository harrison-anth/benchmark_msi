#!/bin/sh
#SBATCH --job-name="vcf_korea"
#SBATCH --output=out_files/vcf.out
#SBATCH --error=error_files/vcf.error
#SBATCH --partition="normal","highmem"
#SBATCH --mem=10G
#SBATCH --nice=1000
module load Anaconda3
module load java

ref=/data3/hanthony/reference_files/GRCh38.d1.vd1.fa
pon=/data3/hanthony/reference_files/protected_references/gatk4_mutect2_4136_pon.vcf.gz
gnome=/data3/hanthony/reference_files/protected_references/somatic-hg38_af-only-gnomad.hg38.vcf

tum_id=$1
tumor=bam/"$tum_id".sorted.bam

if [ ! -f vcf/$tum_id.vcf.gz ]
then

gatk Mutect2 \
-R $ref \
-I $tumor \
--panel-of-normals $pon \
-O vcf/$tum_id.vcf.gz
fi

if [ ! -f vcf/$tum_id.filtered.vcf ]
then

gatk FilterMutectCalls \
-V vcf/$tum_id.vcf.gz \
-R $ref \
-O vcf/$tum_id.filtered.vcf.gz

gunzip vcf/$tum_id.filtered.vcf.gz
fi

vcf=vcf/$tum_id.filtered.vcf

sbatch maf_gen.sh $vcf $tum_id




