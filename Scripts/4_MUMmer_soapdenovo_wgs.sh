#!/bin/bash -l

#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 10:00:00
#SBATCH -J soapdenovo_validation_wgs
#SBATCH --mail-type=ALL
#SBATCH --mail-user ziqi.kang.5312@student.uu.se

# Load modules
module load bioinfo-tools
module load MUMmer

# Your commands
nucmer --prefix /home/ziqi/Ziqi_Genome_Analysis/result/4_assembly_validation/MUMmerplot_SOAP/soapdenovo \
/home/ziqi/Ziqi_Genome_Analysis/unziped_data/sel3_NW_015504249.fna \
/home/ziqi/Ziqi_Genome_Analysis/result/3_dna_assembly/soapdenovo_gapcloser/closed_gaps.fasta

mummerplot -x "[0,4000000]" -y "[0,4000000]" --png --layout --filter -p \
/home/ziqi/Ziqi_Genome_Analysis/result/4_assembly_validation/MUMmerplot_SOAP/soapdenovo \
/home/ziqi/Ziqi_Genome_Analysis/result/4_assembly_validation/MUMmerplot_SOAP/soapdenovo.delta \
-R /home/ziqi/Ziqi_Genome_Analysis/unziped_data/sel3_NW_015504249.fna \
-Q /home/ziqi/Ziqi_Genome_Analysis/result/3_dna_assembly/soapdenovo_gapcloser/closed_gaps.fasta