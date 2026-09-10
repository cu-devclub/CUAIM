#!/bin/bash
#SBATCH --job-name=dy_gru_lete
#SBATCH --output=log/%x_%j.out
#SBATCH --error=log/%x_%j.err
#SBATCH --partition=gpu
#SBATCH --qos=gpu10gh
#SBATCH --gres=gpu:2g.10gb:1
#SBATCH --cpus-per-task=8
#SBATCH --mem=48G
#SBATCH --time=96:00:00

set -euo pipefail

echo "Job started on $(hostname) at $(date)"
cd "${SLURM_SUBMIT_DIR:-$(pwd)}"

if [[ ! -f scripts/train.py ]]; then
  echo "Run this job from the project root directory."
  exit 1
fi

if [[ -f venv/bin/activate ]]; then
  source venv/bin/activate
else
  echo "venv/bin/activate not found; using the current Python environment."
fi

mkdir -p log
nvidia-smi || true

# Override at submit time, for example:
# sbatch --export=ALL,CROPS="cassava sugarcane",DATE_STAMP=20251014 jobs_example/job_train_gru_lete_10gb.sh
CROPS="${CROPS:-cassava}"
LEVEL="${LEVEL:-tam}"
DATE_STAMP="${DATE_STAMP:-20251014}"
N_TRIALS="${N_TRIALS:-20}"
TUNE_EPOCHS="${TUNE_EPOCHS:-30}"
WANDB_MODE="${WANDB_MODE:-offline}"
REGION_OHE="${REGION_OHE:-1}"
RUN_CV="${RUN_CV:-1}"
LETE_DIM="${LETE_DIM:-8}"
LETE_P="${LETE_P:-0.5}"
RUN_TAG="gru_lete"

for CROP in ${CROPS}; do
  MODEL_DIR="models/slurm/${DATE_STAMP}/${LEVEL}/${CROP}/${RUN_TAG}"
  mkdir -p "${MODEL_DIR}"

  train_args=(
    --crop "${CROP}"
    --level "${LEVEL}"
    --date-stamp "${DATE_STAMP}"
    --data-root .
    --model-dir "${MODEL_DIR}"
    --model gru
    --gru-lete-time
    --lete-dim "${LETE_DIM}"
    --lete-p "${LETE_P}"
    --tune
    --n-trials "${N_TRIALS}"
    --tune-epochs "${TUNE_EPOCHS}"
    --optuna-study-name "${LEVEL}_${DATE_STAMP}_${CROP}_${RUN_TAG}"
    --optuna-storage "sqlite:///${MODEL_DIR}/optuna_${RUN_TAG}.db"
    --wandb-mode "${WANDB_MODE}"
    --wandb-project "drought-yield-${RUN_TAG}"
    --no-progress
  )

  case "${REGION_OHE}" in
    1|true|TRUE|yes|YES) train_args+=(--region-ohe) ;;
  esac

  case "${RUN_CV}" in
    0|false|FALSE|no|NO) train_args+=(--no-cv) ;;
  esac

  echo "Training ${RUN_TAG}: crop=${CROP}, level=${LEVEL}, artifacts=${MODEL_DIR}"
  srun python -u scripts/train.py "${train_args[@]}"
done

nvidia-smi || true
echo "Job completed at $(date)"
