#!/bin/sh

tumor=$1

#initialize conda shell
eval "$(conda shell.bash hook)"

echo "Running PreMSIm"

#shape gene count matrix for use with MSIsensor-RNA and preMSIm
conda activate premsim

Rscript scripts/handle.R

if [[ -f output/premsim_test.txt ]]
then
echo "PreMSIm ran successfully"
echo "See output/premsim_test.txt for details."

fi

if [[ ! -f output/premsim_test.txt ]]
then
echo "PreMSIm failed. Check program output for error messages."
fi

# wait 4 seconds for user to see success/fail status
sleep 4
