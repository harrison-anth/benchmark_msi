#!/bin/sh
#SBATCH --job-name="maf"
#SBATCH --output=../out_files/maf.out
#SBATCH --error=../error_files/maf.error
#SBATCH --partition="normal"
#SBATCH --mem-per-cpu=30G

module load java
#set perl5 lib to null as it causes problems with vep
PERL5LIB=""



token=token=/data/Seoighe_data/GDC_Tokens/gdc_token.2023-01-09.tkn
ref=/data3/hanthony/reference_files/GRCh38.d1.vd1.fa
pon=/data3/hanthony/reference_files/protected_references/gatk4_mutect2_4136_pon.vcf.gz
gnome=/data3/hanthony/reference_files/protected_references/somatic-hg38_af-only-gnomad.hg38.vcf




status=$1
seq=$2
size=$3
gnorts=$4
name=$5
gnar2=$6
sample=$7
NUMA=$8

if [[ "$sample" == "normal" ]]
then
exit
fi

FILE=../maf/"$status"_"$seq"/$tumor.maf
if [ ! -f "$FILE" ]
then


tumor=$(cut -f 1 ../manifests/"$status"_"$seq"_"$size".pair$NUMA | tail -n +2)
tumor2=$(grep $tumor ../manifests/"$status"_"$seq"_$size.manifest | cut -f 1)
normal=$(cut -f 2 ../manifests/"$status"_"$seq"_"$size".pair$NUMA | tail -n +2)
normal2=$(grep $normal ../manifests/"$status"_"$seq"_$size.manifest | cut -f 1)

t_name=$(cut -f 1 ../manifests/"$status"_"$seq"_"$size".pair$NUMA | tail -n +2)




gdc-client download -t $token $tumor2 --dir ../maf/"$status"_"$seq"/ &
gdc-client download -t $token $normal2 --dir ../maf/"$status"_"$seq"/ &
wait

#grab name of normal sample
gatk GetSampleName -I ../maf/"$status"_"$seq"/$normal2/$normal -O ../maf/"$status"_"$seq"/$normal.name
gatk GetSampleName -I ../maf/"$status"_"$seq"/$tumor2/$tumor -O ../maf/"$status"_"$seq"/$tumor.name
norm_samp_name=$( cat ../maf/"$status"_"$seq"/$normal.name)
tumor_samp_name=$( cat ../maf/"$status"_"$seq"/$tumor.name)

gatk Mutect2 \
-R $ref \
-I ../maf/"$status"_"$seq"/$tumor2/$tumor \
-I ../maf/"$status"_"$seq"/$normal2/$normal \
-normal $norm_samp_name \
--panel-of-normals $pon \
-O ../maf/"$status"_"$seq"/$tumor.vcf.gz

#clean up giant bam files
rm -r ../maf/"$status"_"$seq"/$tumor2
rm -r ../maf/"$status"_"$seq"/$normal2

gatk FilterMutectCalls \
-V ../maf/"$status"_"$seq"/$tumor.vcf.gz \
-R $ref \
-O ../maf/"$status"_"$seq"/$tumor.filtered.vcf.gz

#quick clean up
rm ../maf/"$status"_"$seq"/$tumor.vcf.gz* 
rm ../maf/"$status"_"$seq"/$normal.name
rm ../maf/"$status"_"$seq"/$tumor.name

#unzip vcf
gunzip ../maf/"$status"_"$seq"/$tumor.filtered.vcf.gz

#load msi-seq env
source /home/hanthony/anaconda3/etc/profile.d/conda.sh
conda activate msiseq



perl /home/hanthony/anaconda3/envs/msiseq/bin/vcf2maf.pl --input-vcf ../maf/"$status"_"$seq"/$tumor.filtered.vcf \
--output-maf ../maf/"$status"_"$seq"/$tumor.maf --normal-id $norm_samp_name --tumor-id $tumor_samp_name \
--ncbi-build GRCh38

fi
