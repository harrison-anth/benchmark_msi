#!/bin/bash

##Run these jobs##

#Generate new manifests?
new_manifests=T

#Generate mafs?
maf=F

#Generate stats?
stats=F

##settings for run 1##
status=A
seq=wgs
sample=N
size=10
random=T
paired=F

sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats


##settings for run 2##
status=A
seq=wxs
sample=N
size=10
random=T
paired=F

sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf $stats
