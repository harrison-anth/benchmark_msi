#!/bin/sh
#SBATCH --job-name="Gnorts"
#SBATCH --output=../out_files/gnorts.out
#SBATCH --error=../error_files/gnorts.error
#SBATCH --partition="normal","highmem"
#SBATCH --mem-per-cpu=35G
#SBATCH --nice=10000

status=$1
seq=$2
size=$3
#maf=$4
#stats=$5
exome=$4
subsample=$5

####Use this code to get around slurm array task id limit
#sum=$(($SLURM_ARRAY_TASK_ID + 999))

#SLURM_ARRAY_TASK_ID=$sum
############



line="$status"_"$seq"_"$size"_$SLURM_ARRAY_TASK_ID




gnar=$(cut -f 9 ../manifests/$line | tail -1)
if [[ "$gnar" == "N" ]]
then
sample=normal
elif [[ "$gnar" == "N*" ]]
then
sample=normal
elif [[ "$gnar" == "T" ]]
then
sample=tumor
fi

token=/data/Seoighe_data/GDC_Tokens/gdc_token.2023-01-09.tkn

gnorts=$(tail -n +2 ../manifests/$line | cut -f 1)
name=$(tail -n +2 ../manifests/$line | cut -f 2)
gnar2=$name.ms

#if [ $maf == "T" ]
#then
#sbatch maf_gen.sh $status $seq $size $gnorts $name $gnar2 $sample $SLURM_ARRAY_TASK_ID
#fi

#if [ $stats == "T" ]
#then
#sbatch stats.sh $status $seq $size $gnorts $name $gnar2 $sample $SLURM_ARRAY_TASK_ID
#fi


dir=../"$status"_"$seq"/$sample/
if [ ! -d "$dir" ]
then
mkdir $dir
fi


FILE=../"$status"_"$seq"/$sample/$gnar2.sorted.bam
if [ ! -f "$FILE" ]
then
gdc-client download --manifest ../manifests/$line --token $token --dir ../"$status"_"$seq"/$sample/
fi


if [[ "$exome" == "T" ]]
then
sbatch exon2.sh $status $seq $size $gnorts $name $gnar2 $sample $SLURM_ARRAY_TASK_ID $subsample
fi

if [[ "$exome" != "T" ]]
then
sbatch filer.sh $status $seq $size $gnorts $name $gnar2 $sample $SLURM_ARRAY_TASK_ID 
fi
