#!/bin/sh
#SBATCH --job-name="vcf_mgi"
#SBATCH --output=out_files/vcf.out
#SBATCH --error=error_files/vcf.error
#SBATCH --array=1-178
#SBATCH --partition="normal","highmem"
#SBATCH --mem=5G

module load Anaconda3
module load java

ref=/data3/hanthony/reference_files/GRCh38.d1.vd1.fa
pon=/data3/hanthony/reference_files/protected_references/gatk4_mutect2_4136_pon.vcf.gz
gnome=/data3/hanthony/reference_files/protected_references/somatic-hg38_af-only-gnomad.hg38.vcf


end=$(( $SLURM_ARRAY_TASK_ID*2 ))
start=$(( $end - 1 ))
norm_id=$(sed "${start}q;d" sorted_access_list.txt)
tum_id=$(sed "${end}q;d" sorted_access_list.txt)

tumor=bam/"$tum_id".sorted.bam 
normal=bam/"$num_id".sorted.bam
t_name=$tum_id

if [[ ! -f maf/$tum_id.maf ]]
then


if [ ! -f temp/"$num_id".name ]
then
#grab name of normal sample
gatk GetSampleName -I $normal -O temp/$num_id.name --use-url-encoding
fi

norm_samp_name=$( cat temp/"$num_id".name)

#gatk GetPileupSummaries -I $normal \
#-L /data3/hanthony/reference_files/biallelic_only_gnomad.vcf.gz \
#-V /data3/hanthony/reference_files/biallelic_only_gnomad.vcf.gz \
#-O temp/$num_id.table

##gatk GetPileupSummaries -I $tumor \
#-L /data3/hanthony/reference_files/biallelic_only_gnomad.vcf.gz \
#-V /data3/hanthony/reference_files/biallelic_only_gnomad.vcf.gz \
#-O temp/$tum_id.table

##gatk CalculateContamination \
#-I temp/$tum_id.table \
#-matched temp/$num_id.table \
#-O temp/$tum_id.contamination.table
 
if [ ! -f vcf/$tum_id.vcf.gz ]
then

gatk Mutect2 \
-R $ref \
-I $tumor \
-I $normal \
-normal $norm_samp_name \
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
fi


vcf=vcf/$tum_id.filtered.vcf

sbatch maf_gen.sh $vcf $tum_id




