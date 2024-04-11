#!/bin/sh
#SBATCH --job-name="MSI"
#SBATCH --output=../out_files/MSI.out
#SBATCH --error=../error_files/MSI.error
#SBATCH --partition="normal","highmem","MSC"
#run which programs?

pro=T
mantis=T
sensor=T
sensor2=T
msings=T

status=$1
seq=$2
size=$3
NUMA=$4
sample=$5
name=$6
name_new=$7
subsample=$8

if [[ "$seq" == "wxs" ]]
then
baseline_pro=../baselines/20_ran_wxs.baseline
else
baseline_pro=../baselines/20_ran_wgs.baseline
fi


if [[ "$seq" == "wxs" ]]
then
baseline_msings=../baselines/msings_wxs.baseline
else
baseline_msings=../baselines/msings_wgs.baseline
fi

if [[ "$sample" == "normal" ]]
then

normal=$(grep -h $name ../manifests/*"$size".pair* | cut -f 2)
tumor=$(grep -h $name ../manifests/*"$size".pair* | cut -f 1)
t_name=$tumor
tumor=../temp/"$tumor"_$subsample.sorted.exon
normal=../temp/"$normal"_$subsample.sorted.exon
status=exon_$subsample
dir=../mantis_results/"$status"_"$seq"/
if [ ! -d "$dir" ]
then
mkdir $dir
fi
dir=../sensor_results/"$status"_"$seq"/
if [ ! -d "$dir" ]
then
mkdir $dir
fi


if [[ "$mantis" == "T" ]]
then
FILE=../mantis_results/"$status"_"$seq"/$t_name.status
if [ ! -f "$FILE" ]
then
sbatch mantis.sh $normal $tumor $status $seq $t_name
fi
fi


if [[ "$sensor" == "T" ]]
then
FILE=../sensor_results/"$status"_"$seq"/$t_name
if [ ! -f "$FILE" ]
then
sbatch sensor.sh $tumor $status $seq $t_name $normal
fi
fi

fi

if [[ "$sample" == "tumor" ]]
then

tumor=$(cut -f 1 ../manifests/"$status"_"$seq"_"$size".pair$NUMA | tail -n +2)
tumor=../temp/"$tumor"_$subsample.sorted.exon

t_name=$(cut -f 1 ../manifests/"$status"_"$seq"_"$size".pair$NUMA | tail -n +2)
status=exon_$subsample
dir=../sensor2_results/"$status"_"$seq"/
if [ ! -d "$dir" ]
then
mkdir $dir
fi
dir=../pro_results/"$status"_"$seq"/
if [ ! -d "$dir" ]
then
mkdir $dir
fi
dir=../msings_results/"$status"_"$seq"/
if [ ! -d "$dir" ]
then
mkdir $dir
fi




if [[ "$pro" == "T" ]]
then
FILE=../pro_results/"$status"_"$seq"/$t_name
if [ ! -f "$FILE" ]
then
sbatch pro.sh $baseline_pro $tumor $status $seq $t_name
fi
fi

if [[ "$sensor2" == "T" ]]
then
FILE=../sensor2_results/"$status"_"$seq"/$t_name
if [ ! -f "$FILE" ]
then 
sbatch sensor2.sh $tumor $status $seq $t_name
fi
fi
if [[ "$msings" == "T" ]]
then
FILE=../msings_results/"$status"_"$seq"/$t_name.MSI_Analysis.txt
if [ ! -f "$FILE" ]
then
sbatch msings.sh $baseline_msings $tumor $status $seq $t_name
fi
fi
fi

