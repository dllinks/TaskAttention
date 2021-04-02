#!/bin/bash

touch dynamic_script.sh
> dynamic_script.sh
printf "#!/bin/bash \n" >> dynamic_script.sh

printf "#SBATCH --job-name=%s            # create a short name for your job \n" $1 >> dynamic_script.sh
printf "#SBATCH --nodes=1                # node count \n" >> dynamic_script.sh
printf "#SBATCH --ntasks=1               # total number of tasks across all nodes \n" >> dynamic_script.sh
printf "#SBATCH --cpus-per-task=4    # cpu-cores per task (>1 if multi-threaded tasks) \n" >> dynamic_script.sh
printf "#SBATCH --partition=gpu \n" >> dynamic_script.sh
printf "#SBATCH --time=56:15:00          # total run time limit (HH:MM:SS)\n" >> dynamic_script.sh
printf "#SBATCH --output=%s/%s.out       # file to collect standard output\n" $2 $1 >> dynamic_script.sh
printf "#SBATCH --error=%s/%s.err        # file to collect standard errors\n" $2 $1 >> dynamic_script.sh
printf "#SBATCH --mail-type=begin        # send email when job begins \n" >> dynamic_script.sh
printf "#SBATCH --mail-type=end          # send email when job ends \n" >> dynamic_script.sh
printf "#SBATCH --mail-type=fail         # send email if job fails \n" >> dynamic_script.sh
printf "#SBATCH --mail-user=%s\n" $4 >> dynamic_script.sh

printf "module load conda-python/3.7 \n" >> dynamic_script.sh
printf "source activate %s \n" $5     >> dynamic_script.sh

printf "cd %s \n" $2     >> dynamic_script.sh
printf "python %s \n" $3 >> dynamic_script.sh 

sbatch dynamic_script.sh
