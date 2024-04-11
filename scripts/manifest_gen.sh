#!/bin/bash
#SBATCH --partition="MSC"
#SBATCH --job-name="manitee"
#SBATCH --output=../out_files/manifest.out
#SBATCH --error=../error_files/manifest.error
#SBATCH --export=ALL


##load settings##
status=$1
seq=$2
sample=$3
size=$4
random=$5
paired=$6
new_manifests=$7
#maf=$8
#stats=$9
exome=$8
subsample=$9

module load Anaconda3

if [[ "$new_manifests" == "T" ]]
then
conda activate MSIR

R --vanilla -f manifest_gen.R --args $status $seq $sample $size $random $paired
fi


count=$(echo $(( $(wc -l < ../manifests/"$status"_"$seq"_"$size".manifest)-1 )))

#sbatch --array 1-$count cramer.sh $status $seq $size
sbatch --array 1-$count%5 downloader.sh $status $seq $size $exome $subsample
#wxs part 1
#sbatch --array 1-999%5 downloader.sh $status $seq $size $exome $subsample
#wxs part 2
#sbatch --array 1-752%5 downloader.sh $status $seq $size $exome $subsample


#manifest="$status"_"$seq"_"$sample"_"$random"_"$size".manifest
#752 excess
#tail -n +2 "$manifest" | split -d -l 1 - --filter='sh -c "{ head -n1 "$manifest"; cat; } > manifests/$FILE"' "$status"_"$seq"_"$sample"_"$random"_"$size"_



