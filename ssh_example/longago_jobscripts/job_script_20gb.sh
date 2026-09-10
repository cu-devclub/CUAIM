#!/bin/bash
#SBATCH --job-name=CrPB12R2         
#SBATCH --output=log/output_CrPB12R2.log   
#SBATCH --error=log/error_CrPB12R2.log      
#SBATCH --partition=gpu             
#SBATCH --qos=gpu20gh             
#SBATCH --gres=gpu:3g.20gb:1       
#SBATCH --cpus-per-task=8           
#SBATCH --mem=48G                   
#SBATCH --time=96:00:00             

# Print some diagnostic information
echo "Job started on $(hostname) at $(date)"

# Activate the virtual environment
source venv/bin/activate

# Run your script
nvidia-smi
srun python src/multi_task/main.py
nvidia-smi

# Print completion message
echo "Job completed at $(date)"
