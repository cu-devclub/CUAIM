# CU-AIM Server User Manual

A practical guide for lab users working with the CU-AIM computing cluster.

The manual is intended for students who are familiar with basic files and Python but are new to remote servers, SSH, Slurm, GPUs, and Singularity containers.

## Contents

- First-time access through the Chulalongkorn University VPN
- SSH key generation and authentication
- Connecting through a terminal or VS Code Remote-SSH
- Project storage and resource limits
- Interactive and batch Slurm jobs
- Job monitoring and cancellation
- Python, Conda, virtual environments, CUDA, and GPU usage
- Job arrays and concurrent workloads
- Singularity containers
- Example SSH and Slurm scripts

## Files

- `survival-manual-cuaim.pdf` — compiled user manual
- `survival-manual-cuaim.tex` — LaTeX source
- `figures/` — images used in the manual
- `ssh_example/` — example SSH, Slurm, and Singularity scripts
- `reference/` — related reference material

## Building the manual

The manual requires a LaTeX installation with `latexmk`.

```bash
latexmk -pdf survival-manual-cuaim.tex
```

The generated PDF will be saved as `survival-manual-cuaim.pdf`.

## Important notes

- Connect to the university VPN before accessing CU-AIM.
- Keep your SSH private key private.
- Cluster partitions, QoS limits, GPU availability, and software modules may change. Always verify current settings before submitting resource-intensive jobs.
- Follow your laboratory and university policies when using shared computing resources.

## Author

Created by Peeradon Sarnkaew.

For questions or corrections, contact:

`peeradonsarnkaew46@gmail.com`
