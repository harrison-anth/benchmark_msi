#!/bin/bash

##Run these jobs##

#Generate new manifests?
new_manifests=F

#Generate mafs?
maf=T

#new status
status=msih
sample=T
seq=wxs
size=20
random=T
paired=T



sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $maf
#new status
