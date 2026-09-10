#!/bin/bash -l
#SBATCH --job-name=sin_batch
#SBATCH --partition=gpu
#SBATCH --qos=gpu40g24m
#SBATCH --gres=gpu:7g.40gb:2
#SBATCH --mem=20G
#SBATCH --cpus-per-task=2
#SBATCH --output=mtj-%j.out
#SBATCH --error=mtj-%j.err
mkdir -p logs

set -euo pipefail

PROJECT=/data/project/your_username/your_project
IMAGE=$PROJECT/containers/your_container.sif
ENV_TAG=your_environment
VENV=/workspace/.venv-$ENV_TAG


singularity exec --nv \
  --pwd /workspace \
  --bind "$PROJECT:/workspace:rw" \
  "$IMAGE" \
  "$VENV/bin/python" \
  /workspace/script1.py
