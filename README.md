# Tarea 2 - BASH (Grupo 5)

Authors:
* Carmen Giles Floriano
* Diana Andreea Baicea
* Lucía Rodríguez Ramírez
* Lucía Tejero Miranda
* Vicente Revilla López


## 1. Introduction
In this work, we developed an automized process that analyzes a given number of ChIP-seq samples of Transcription Factors (TFs) or Epigenetic Marks (EMs) in Arabidopsis thaliana model organisms. The results obtained are a _list of target genes that could be regulated by TFs or EMs, GO and KEGG metabolic pathways enrichment and DNA motifs in TSS region where the transcription factor is bound_.

The process is based on three bash scripts (pipe.sh, sample_proc.sh, callpeaks.sh) and one R script (pipe.R). The parameters needed for its execution have to be specified in the params.txt file every time the script is run. In the next paragraph, these parameters are explained for better comprehension of its use.

## 2. Parameters
