#!/bin/bash -l
#This will create only one job but multiple tasks inside
#SBATCH --job-name=loop_task
#SBATCH --partition=gpu
#SBATCH --qos=gpu40g
#SBATCH --gres=gpu:7g.40gb:1
#SBATCH --mem=20G
#SBATCH --cpus-per-task=2
#SBATCH --output=mtj-%j.out
#SBATCH --error=mtj-%j.err
#SBATCH --time=24:00:00

set -e

mkdir -p logs

module load Anaconda3
module load CUDA/11.8.0

eval "$(conda shell.bash hook)"
conda activate my_project

for i in {1..10}; do
    echo "Running script${i}.py"

    srun --exclusive \
         --ntasks=1 \
         --cpus-per-task=1 \
         --gres=gpu:7g.40gb:1 \
         --mem=10G \
         --output="logs/script${i}-%j.out" \
         --error="logs/script${i}-%j.err" \
         python -u "script${i}.py"

    echo "Finished script${i}.py"
done