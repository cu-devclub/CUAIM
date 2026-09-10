#!/bin/bash
#SBATCH --job-name=CrP2B12R2          
#SBATCH --output=log/output_CrP2B12R2.log   
#SBATCH --error=log/error_CrP2B12R2.log      
#SBATCH --partition=gpu             
#SBATCH --qos=gpu40g24m             
#SBATCH --gres=gpu:7g.40gb:1       
#SBATCH --cpus-per-task=8           
#SBATCH --mem=48G                   
#SBATCH --time=96:00:00             

# Print some diagnostic information
echo "Job started on $(hostname) at $(date)"

# Activate the virtual environment
source venv/bin/activate

# Run your script
nvidia-smi
srun python src/single_task/main.py
nvidia-smi

# Print completion message
echo "Job completed at $(date)"
