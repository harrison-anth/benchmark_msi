#!/bin/bash
#SBATCH --export=ALL

##Run these jobs##


##########Create Virtual Exome#############


#Generate new manifests?
new_manifests=F

#Generate mafs?
#maf=F

#Generate seq stats?
#stats=F

#downsample exome?
exome=T
#proportion of reads to downsample to
subsample=50

##settings for run 1##
status=A
seq=wxs
sample=T
size=200
random=T
paired=T

#sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $exome $subsample
#proportion of reads to downsample to
subsample=40
#sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $exome $subsample


#proportion of reads to downsample to
subsample=30
#sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $exome $subsample
#proportion of reads to downsample to
subsample=20
#sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $exome $subsample

#proportion of reads to downsample to
subsample=10
#sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $exome $subsample

#proportion of reads to downsample to
subsample=05
sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $exome $subsample


###maybe more at a higher depth?
subsample=60
#sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $exome $subsample

###maybe more at a higher depth?
subsample=70
#sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $exome $subsample

###maybe more at a higher depth?
subsample=80
#sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $exome $subsample

###maybe more at a higher depth?
subsample=90
sbatch manifest_gen.sh $status $seq $sample $size $random $paired $new_manifests $exome $subsample



