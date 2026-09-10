#!/bin/bash -l

#SBATCH --job-name=basicpy
#SBATCH --partition=gpu
#SBATCH --qos=gpu40g
#SBATCH --gres=gpu:7g.40gb:1
#SBATCH --mem=20G
#SBATCH --cpus-per-task=2
#SBATCH --output=mtj-%j.out
#SBATCH --error=mtj-%j.err
#SBATCH --time=24:00:00     

mkdir -p logs
module load Anaconda3
module load CUDA/11.8.0
eval "$(conda shell.bash hook)"
conda activate my_project

srun --output=logs/script1-%j.out \
     --error=logs/script1-%j.err \
     python -u script1.py

exit $?