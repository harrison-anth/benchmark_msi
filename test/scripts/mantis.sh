#!/bin/sh

#activate conda environment
eval "$(conda shell.bash hook)"
conda activate mantis

tumor=$1
normal=$2

echo "Running MANTIS"

python ../reference_files/MANTIS/mantis.py -n $normal -t $tumor -b ../reference_files/mantis_chr7.bed -o output/mantis_test \
--genome ../reference_files/GRCh38.d1.vd1_chr7.fa.gz --threads 1 -mrq 20.0 -mlq 25.0 -mlc 20 -mrr 1

if [[ -f output/mantis_test.status ]]
then
echo "MANTIS test ran successfully."
echo "See output/mantis_test.status for result."
fi

if [[ ! -f output/mantis_test.status ]]
then
echo "MANTIS test failed. Check program output for error messages."
fi

