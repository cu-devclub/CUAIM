#!/bin/bash
#SBATCH --job-name=output_Inference         
#SBATCH --output=log/output_UMAP.log   
#SBATCH --error=log/error_UMAP.log      
#SBATCH --partition=gpu             
#SBATCH --qos=gpu10gh             
#SBATCH --gres=gpu:2g.10gb:1       
#SBATCH --cpus-per-task=8           
#SBATCH --mem=48G                       
#SBATCH --time=96:00:00             

# Print some diagnostic information
echo "Job started on $(hostname) at $(date)"

# Activate the virtual environment
source venv/bin/activate

# Run your script
#nvidia-smi
srun python src/umap_visualize.py \
  --models outputs/multi_task_results/fold3 \
           outputs/single_task_results/NP-KV/fold3 \
  --labels PAGTN-MTL PAGTN-ST \
  --task NP-KV


#nvidia-smi

# Print completion message
echo "Job completed at $(date)"
