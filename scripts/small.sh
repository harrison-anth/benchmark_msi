#!/bin/bash

##Run these jobs##

#Generate new manifests?
new_manifests=T

#Generate mafs?
maf=F

#Generate stats?
stats=F

##settings for run 1##
status=msih
seq=wgs
sample=T
size=10
random=T
paired=T

sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats
status=msil
sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats
status=mss
sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats

##settings for run 2##
status=msih
seq=wxs
sample=T
size=20
random=T
paired=T

sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats
status=msil
sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats
status=mss
sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats


