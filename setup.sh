# get the sample name
if [ $# -eq 0 ]
  # if no sample name is given, a standard sample name is given
  then
    echo "No arguments supplied"
    sample="sample01"
else
    sample=$1
fi


# export the path to the vbz plugin, if this is not done in the bashrc
export HDF5_PLUGIN_PATH=/home/nu36par/miniconda3/envs/meteore_nanopolish/lib/python3.9/site-packages/hdf5plugin/plugins/

# store the current meteore working directory in a variable
meteore=$(pwd)

# create links to local genome data
mkdir $meteore/data
ln -s /mnt/fass1/genomes/Eukaryots/homo_sapiens_done/ucsc/hg38.fa $meteore/data/hg38.fa
ln -s /mnt/fass1/genomes/Eukaryots/homo_sapiens_done/ucsc/hg38.fa.fai $meteore/data/hg38.fa.fai

ln -s $meteore/../output.fastq $meteore/$sample.fastq

# create links to the basecalled data
mkdir $meteore/data/$sample
cd $meteore/data/$sample
for filename in $(find . -name '*.fast5'); do ln -s $filename ; done  #TODO: test this


## run Nanopolish
# open a screen and run Nanopolish inside this (new) detached screen session.
# screen -dm -S nanopolish_$sample bash -c 'conda activate meteore_nanopolish; cd $meteore; snakemake -s Nanopolish nanopolish_results/$sample_nanopolish-freq-perCG.tsv --cores all'
screen -S nanopolish_$sample
conda activate meteore_nanopolish
cd $meteore
snakemake -s Nanopolish nanopolish_results/$sample_nanopolish-freq-perCG.tsv --cores all

