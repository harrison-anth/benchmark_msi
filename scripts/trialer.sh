#!/bin/bash

##Run these jobs##

#Generate new manifests?
new_manifests=T

#Generate mafs?
maf=T

##settings for run 1##
status=msih
seq=wxs
sample=T
size=1
random=T
paired=T

sbatch manitest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf
