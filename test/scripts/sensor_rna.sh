#!/bin/sh

tumor=$1

#initialize conda shell
eval "$(conda shell.bash hook)"

echo "Reformatting count matrix"

#shape gene count matrix for use with MSIsensor-RNA and preMSIm
conda activate premsim

Rscript scripts/sensor_rna_shaper.R

conda deactivate

echo "Running MSIsensor-RNA"


msisensor-rna detection -i temp/all_samples.csv -o output/sensor_rna_test.txt -m ../baselines/sensor_rna.model -d True

if [[ -f output/sensor_rna_test.txt ]]
then
echo "MSIsensor-RNA ran successfully"
echo "See output/sensor_rna_test.txt for details."

fi

if [[ ! -f output/sensor_rna_test.txt ]]
then
echo "MSIsensor-RNA failed. Check program output for error messages."
fi

# wait 4 seconds for user to see success/fail status
sleep 4
