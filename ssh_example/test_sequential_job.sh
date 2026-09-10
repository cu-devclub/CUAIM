#!/bin/bash -l
#The array creates jobs the %1 means that only one array task runs at a time
#SBATCH --job-name=test-array
#SBATCH --partition=gpu
#SBATCH --qos=gpu40g
#SBATCH --gres=gpu:7g.40gb:1
#SBATCH --mem=20G
#SBATCH --cpus-per-task=2
#SBATCH --time=24:00:00
#SBATCH --array=1-3%1
#SBATCH --output=mtj-%A_%a.out
#SBATCH --error=mtj-%A_%a.err

set -e

mkdir -p logs

module load Anaconda3
module load CUDA/11.8.0

eval "$(conda shell.bash hook)"
conda activate my_project

i="$SLURM_ARRAY_TASK_ID"

echo "Running script${i}.py"

srun --exclusive \
     --ntasks=1 \
     --cpus-per-task=1 \
     --gres=gpu:7g.40gb:1 \
     --mem=10G \
     --output="logs/script${i}-${SLURM_ARRAY_JOB_ID}_${i}.out" \
     --error="logs/script${i}-${SLURM_ARRAY_JOB_ID}_${i}.err" \
     python -u "script${i}.py"

echo "Finished script${i}.py"