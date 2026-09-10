#!/bin/bash
#SBATCH --job-name=mtj
#SBATCH --partition=gpu
#SBATCH --qos=gpu40g24m
#SBATCH --gres=gpu:7g.40gb:2
#SBATCH --mem=20G
#SBATCH --cpus-per-task=2
#SBATCH --output=mtj-%j.out
#SBATCH --error=mtj-%j.err
#398561
mkdir -p logs

# Launch task 1 in the background
srun --exclusive \
     --ntasks=1 \
     --cpus-per-task=1 \
     --gres=gpu:7g.40gb:1 \
     --mem=10G \
     --output=logs/script1-%j.out \
     --error=logs/script1-%j.err \
     python -u script1.py &

pid1=$!

# Launch task 2 in the background
srun --exclusive \
     --ntasks=1 \
     --cpus-per-task=1 \
     --gres=gpu:7g.40gb:1 \
     --mem=10G \
     --output=logs/script2-%j.out \
     --error=logs/script2-%j.err \
     python -u script2.py &

pid2=$!

# Wait for both tasks and preserve their exit statuses
wait "$pid1"
status1=$?

wait "$pid2"
status2=$?

if [[ $status1 -ne 0 || $status2 -ne 0 ]]; then
    echo "At least one task failed."
    exit 1
fi

echo "Both tasks completed successfully."