#!/bin/bash
#SBATCH --job-name="vcf tcga"
#SBATCH --output=../out_files/vcf.out
#SBATCH --error=../error_files/vcf.error
#SBATCH --partition="normal","highmem"
#SBATCH --mem=5G

normal=$1
normal2=$2
normal3=$3
tumor=$4
tumor2=$5
tumor3=$6
t_name=$7
seq=$8

module load Anaconda3
module load java

ref=/data3/hanthony/reference_files/GRCh38.d1.vd1.fa
pon=/data3/hanthony/reference_files/protected_references/gatk4_mutect2_4136_pon.vcf.gz
gnome=/data3/hanthony/reference_files/protected_references/somatic-hg38_af-only-gnomad.hg38.vcf



if [[ ! -f ../temp/$normal.name ]]
then

gatk GetSampleName -I ../temp/$normal3/$normal -O ../temp/$normal.name
norm_samp_name=$( cat ../temp/"$normal".name)
fi


if [[ ! -f ../vcf/$t_name.vcf.gz ]]
then

gatk Mutect2 \
-R $ref \
-I ../temp/$normal3/$normal \
-I ../temp/$tumor3/$tumor \
-normal $norm_samp_name \
--panel-of-normals $pon \
-O ../vcf/$t_name.vcf.gz 

fi

if [[ ! -f ../vcf/$t_name.filtered.vcf ]]
then

gatk FilterMutectCalls \
-V ../vcf/$t_name.vcf.gz \
-R $ref \
-O ../vcf/$t_name.filtered.vcf.gz

#unzip vcf
gunzip ../vcf/$t_name.filtered.vcf.gz
fi

if [ -f ../vcf/$t_name.filtered.vcf ]
then
#clean up
rm -r ../temp/$normal3 &
rm -r ../temp/$tumor3 &
wait
fi
vcf=../vcf/$t_name.filtered.vcf
sbatch maf_gen.sh $vcf $t_name $seq

