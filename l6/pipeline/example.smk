samples = []
genome = "pipeline/filtered_contigs.fasta"

with open('list_of_samples.txt') as f:
    samples = f.read().splitlines()

wildcard_constraints:
    sample = "[^./]+"   # sample names must not contain dots or slashes


rule all:
    input:
        expand("mapped/{sample}.sorted.mapping.bam", sample=samples),
        expand("report/flagstat/{sample}.sorted.mapping.flagstat.txt", sample=samples)


rule trimming:
    input:
        read1="{sample}_1.fastq",
        read2="{sample}_2.fastq"

    output:
        trimmed1="trimmed/{sample}_1.trimmed.fastq.gz",
        trimmed2="trimmed/{sample}_2.trimmed.fastq.gz",
        report="report/fastp/{sample}.html"

    log:
        log="logs/{sample}.fastp.log"

    conda:
        "fastp.yaml"

    group:
        "pipeline"

    shell:
        """
        fastp \
        -i {input.read1} \
        -I {input.read2} \
        -o {output.trimmed1} \
        -O {output.trimmed2} \
        -V -w 16 -x -g -n 2 -5 -3 -p -l 75 -M 26 \
        -h {output.report} \
        > {log.log} 2>&1
        """


rule mapping:
    input:
        reference=genome,
        trimmed1="trimmed/{sample}_1.trimmed.fastq.gz",
        trimmed2="trimmed/{sample}_2.trimmed.fastq.gz"

    output:
        "mapped/{sample}.mapping.bam"

    conda:
        "alignment.yaml"

    group:
        "pipeline"

    shell:
        """
        bwa mem -t 4 -M \
        {input.reference} \
        {input.trimmed1} \
        {input.trimmed2} | \
        samtools view -@ 4 -bS - > {output}
        """


rule sorting:
    input:
        mapping="mapped/{sample}.mapping.bam"

    output:
        sorted="mapped/{sample}.sorted.mapping.bam"

    conda:
        "alignment.yaml"

    group:
        "pipeline"

    shell:
        """
        samtools sort -@ 24 -o {output.sorted} {input.mapping}
        """


rule flagstat:
    input:
        "mapped/{sample}.sorted.mapping.bam"

    output:
        "report/flagstat/{sample}.sorted.mapping.flagstat.txt"

    conda:
        "alignment.yaml"

    group:
        "pipeline"

    shell:
        """
        samtools flagstat -@ 24 {input} > {output}
        """


rule unmapped:
    input:
        "mapped/{sample}.sorted.mapping.bam"

    output:
        "mapped/{sample}_unmapped.bam"

    conda:
        "alignment.yaml"

    group:
        "pipeline"

    shell:
        """
        samtools view -u -f 12 -F 256 {input} > {output}
        """
