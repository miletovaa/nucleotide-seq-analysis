# Workbook for Nucleotide Sequence Analysis Course

> Anna Miletova, 89231151, BF2-EN

During the course, we had six practical classes. Report for each of them is available on click:

1. [Lab 01. Databases and Sequence Quality Control](l1/report1_2104.md). We downloaded the data from SRA database, performed quality control of the data using **FastQC** and **MultiQC**.
2. [Lab 02. Sequence Preprocessing, Alignment and Quantification](l2/report2_0505.md). We performed quality filtering and trimming of the reads using **FastP**, then performed sequence alignment using **HISAT2** and quantified the gene expression using **Salmon**.
3. [Lab 03. Indexing, IGV Visualization, feature counting](l3/report3_1205.md). Using **samtools**, we converted sam file to bam, sorted the bam file according to the location of reads on the reference genome and created index of bam file with samtools. We also created index of reference genome fasta file. Finally, we visualized the alignment using **IGV** Visualization and feature counting with **featureCounts**.
4. [Lab 04. Assembly](l4/report4_1805.md). We performed the whole pipeline of quality control and trimming of the reads using **FastQC**, **FastP**. Then we performed assembly with **SPADES**, detected the species with **QUAST** and evaluated the annotation with **BUSCO**.
5. [Lab 05. Annotation](l5/report5_2605.md). This class was dedicated to annotation of the assembled contigs. We used **Prokka** for prokaryotic genome annotation.
6. [Lab 06. Pipeline creation](l6/report6_0206.md). We created a pipeline for quality control, trimming and assembly of the reads using **Snakemake**.