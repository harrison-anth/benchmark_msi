#!/bin/bash
#SBATCH --partition="normal","highmem","MSC"
#SBATCH --job-name="manitee"
#SBATCH --output=../out_files/manifest.out
#SBATCH --error=../error_files/manifest.error

##load settings##
status=$1
seq=$2
sample=$3
size=$4
random=$5
paired=$6
new_manifests=$7
maf=$8

if [[ "$new_manifests" == "T" ]]
then
module load R
R --vanilla -f manifest_gen.R --args $status $seq $sample $size $random $paired
fi


count=$(echo $(( $(wc -l < ../manifests/"$status"_"$seq"_"$size".manifest)-1 )))

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

token=/data/Seoighe_data/Tokens/token_mar23

gnorts=$(tail -n +2 ../manifests/$line | cut -f 1)
name=$(tail -n +2 ../manifests/$line | cut -f 2)
gnar2=$name.ms

sbatch maf_gen.sh $status $seq $size $gnorts $name $gnar2 $sample $SLURM_ARRAY_TASK_ID
