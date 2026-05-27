# Lesson 05. Report for 26/05

> Anna Miletova, 89231151

## 1. Environment and installation of Snakemake

First, as always, I created new conda environment and installed Snakemake package:

```bash
conda create -c conda-forge -c bioconda -c nodefaults -n snakemake snakemake
conda activate snakemake
```

## 2. Preparation of the workflow

To avoid confusion I have rearranged the needed files (reads, genome created with arrangement) into the folder `pipeline`.

In the `list_of_samples.txt` file I have saved the name of the sample: `ERR327955`. I have also created the `example.smk` file with the instructions for the workflow.

## 3. Alignment environment

I created new environment for bwa and samtools called `alignment` and installed the packages:

```bash
conda create -n alignment -y
conda activate alignment
conda install -c bioconda bwa samtools -y
```

## 4. Confiruation of the workflow

In the new YAML file i have saved the configuration of the conda environment.

```bash
conda env export > alignment.yaml
```

And also I saved previously created environment for `fastp` in the `fastp.yaml` file.

```bash
conda deactivate
conda activate fastp
conda env export > fastp.yaml
```

## 5. Indexing of the reference genome

I have created index of the reference genome with bwa:

```bash
ln -s ../l4/spades_ERR327955_output/contigs.fasta filtered_contigs.fasta
bwa index filtered_contigs.fasta
```

## 6. Running the workflow

The `example.smk` instructions include the following steps:

1. Trimming of the reads with `fastp`
2. Mapping of the reads to the reference genome with `bwa`
3. Sorting and indexing of the mapped reads with `samtools`
4. Flagstat of the mapped reads with `samtools`


Now, I can run the pipeline using the following command:

```bash
conda deactivate
conda activate snakemake
snakemake -s example.smk --use-conda --cores 8 -n
snakemake -s example.smk --use-conda --cores 8
```
