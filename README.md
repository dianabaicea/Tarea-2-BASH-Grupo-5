# Project 2 - BASH (Group 5)

<br />
<div align="center">
  <a href="[https://github.com/github_username/repo_name](https://github.com/dianabaicea/Tarea-2-BASH-Grupo-5)">
    <img src="https://dbarchive.biosciencedbc.jp/data/togo-pic/image/202002_ChIP-seq_positive.png" alt="ChIP-seq" width="200" height="200">
  </a>

<h3 align="center">ChIP-seq Analysis using BASH Scripting</h3>

  <p align="center">
    <a href="https://github.com/dianabaicea/Tarea-2-BASH-Grupo-5"><strong>Explore the repository »</strong></a>
    <br />
    <br />
    <br />
  </p>
</div>



**Authors:**
* Giles Floriano, Carmen   &nbsp;&nbsp;    <a href="mailto:carmengiles02@gmail.com"><img src="https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/112-gmail_email_mail-512.png" alt="carmengiles02@gmail.com" width="15"/></a> &nbsp; <a href="https://github.com/CarmenGiles"><img src="https://cdn-icons-png.flaticon.com/512/25/25231.png" alt="GitHub - CarmenGiles" width="15"/></a>

* Baicea, Diana Andreea   &nbsp;&nbsp;    <a href="mailto:diana.baicea@gmail.com"><img src="https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/112-gmail_email_mail-512.png" alt="diana.baicea@gmail.com" width="15"/></a> &nbsp; <a href="https://github.com/dianabaicea"><img src="https://cdn-icons-png.flaticon.com/512/25/25231.png" alt="GitHub - dianabaicea" width="15"/></a>

* Rodríguez Ramírez, Lucía   &nbsp;&nbsp;    <a href="mailto:luciarguez20@gmail.com"><img src="https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/112-gmail_email_mail-512.png" alt="luciarguez20@gmail.com" width="15"/></a> &nbsp; <a href="https://github.com/luciarguez20"><img src="https://cdn-icons-png.flaticon.com/512/25/25231.png" alt="GitHub - luciarguez20" width="15"/></a>

* Tejero Miranda, Lucía   &nbsp;&nbsp;    <a href="mailto:luciatejerom@gmail.com"><img src="https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/112-gmail_email_mail-512.png" alt="luciatejerom@gmail.com" width="15"/></a> &nbsp; <a href="https://github.com/Luciatej"><img src="https://cdn-icons-png.flaticon.com/512/25/25231.png" alt="GitHub - Luciatej" width="15"/></a>

* Revilla López, Vicente   &nbsp;&nbsp;    <a href="mailto:vicenterevillalopez4@gmail.com"><img src="https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/112-gmail_email_mail-512.png" alt="vicenterevillalopez4@gmail.com" width="15"/></a> &nbsp; <a href="https://github.com/vicrevlop"><img src="https://cdn-icons-png.flaticon.com/512/25/25231.png" alt="GitHub - vicrevlop" width="15"/></a>
  <br />
  <br />
  <br />



<!-- TABLE OF CONTENTS -->
<details>
  <summary><strong>Table of Contents</strong></summary>
  <ol>
    <li>
      <a href="#1---about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#2---input">Input</a>
      <ul>
        <li><a href="#parameters">Parameters</a></li>
        <li><a href="#scripts">Scripts</a></li>
      </ul>
    </li>
  </ol>
</details>
  <br />



## 1 - About The Project
In this project, we developed an automated process that analyzes a chosen number of ChIP-seq samples of Transcription Factors (TFs) or Epigenetic Marks (EMs) in Arabidopsis thaliana model organisms. The process is based on three bash scripts (_pipe.sh_, _sample_proc.sh_, _callpeaks.sh_) and one R script (_pipe.R_). The parameters needed for its execution must be specified in the _params.txt_ file previously the script is run. 

In the next section, all the input data is explained 

The results obtained are a _list of target genes that could be regulated by TFs or EMs, GO and KEGG metabolic pathways enrichment and DNA motifs in the TSS region where the transcription factor is bound_.
  <br />
  <br />
  <br />


## 2 - Input
### Parameters
The _params.txt_ file is the only one that the user needs to edit according to their data to run the entire analysis. An example of the <a href="URL_del_enlace">_params.txt_</a> file can be found in this repository. In the following section, these parameters are explained to better comprehend its correct use:

* `path_input_i:` The path to access the location where the input file/s is/are located. Must be written as many paths as input samples the study has (i=1,2,3...).
* `path_chip_i:` The path to access the location where the chip file/s is/are located. Must be written as many paths as chip samples the study has (i=1,2,3...).
* `path_genome:` The path to access the location where the genome file of the organism is located.
* `path_annotation:` The path to access the location where the annotation file of the genome is located.
* `experiment_name:` The name of the folder where the analysis output is contained.
* `working_directory:` The directory where the analysis is carried out. 
* `installation_directory:` The directory where all the executable files are archived.
* `number_chip:` The number of chip samples the study has.
* `number_input:` The number of input samples the study has.
* `tf_em:` The type of data used in the analysis. Use “tf” in case of transcription factor or “em” if it is epigenetics marks.

  <br />
> [!WARNING]
> * The analysis only accepts compressed sample files (fq.gz extension file). 
> * It is necessary to write a space bar after each ":" in the _params.txt_ file.
  <br />

### Scripts
The processes carried out by each script are explained in the following section:

 * **`pipe.sh`**
   - Load parameters from the _params.txt_ file.
   - Create the workspace that contains all the input files and where the output would be located.
   - Create the genome index using [bowtie2-build](http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml).
   - Process the samples in parallel by executing it from the queue manager.
   - Passes the arguments needed by the sample_proc.sh script to run.

 * **`sample_proc.sh`**
   - Quality analysis of the samples using [fastqc](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/).
   - Map of short reads to the reference genome using [bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml).
   - Transform the SAM format into a binary BAM format, sort the mappings according to their order in the genome and create a BAM index using [samtools](http://www.htslib.org).
   - Passes the arguments needed by the callpeaks.sh script to run.
  
  * **`callpeaks.sh`**
   - Peak calling usin [masc2 callpeak](https://github.com/macs3-project/MACS)).
   - Find relevant DNA motifs using [HOMER](http://homer.ucsd.edu/homer/ngs/peakMotifs.html).
   - Passes the arguments needed by the pipe.R file to be executed.

  * **`pipe.R`**
   - Data enrichment analysis using [RStudio](https://www.r-project.org).
   - Definition of promoter region using [ChIPseeker](https://bioconductor.org/packages/release/bioc/html/ChIPseeker.html) and [TxDb.Athaliana.BioMart.plantsmart28](https://bioconductor.org/packages/release/data/annotation/html/TxDb.Athaliana.BioMart.plantsmart28.html) library. 
   - Peak annotation using [ChIPseeker](https://bioconductor.org/packages/release/bioc/html/ChIPseeker.html) and [TxDb.Athaliana.BioMart.plantsmart28](https://bioconductor.org/packages/release/data/annotation/html/TxDb.Athaliana.BioMart.plantsmart28.html) library.
   - GO terms enrichment using [clusterProfiler](https://bioconductor.org/packages/release/bioc/html/clusterProfiler.html), [org.At.tair.db](https://bioconductor.org/packages/release/data/annotation/html/org.At.tair.db.html) and [enrichplot](https://bioconductor.org/packages/release/bioc/html/enrichplot.html) library.
   - KEGG terms enrichment using [clusterProfiler](https://bioconductor.org/packages/release/bioc/html/clusterProfiler.html) and PATHVIEW library.
    

OUTPUT
Once all parameters have been specified, the next step is to run the scripts. When CHIPsequeando pipeline is running, the next folders will be created in the output directory:
PARA EJECUTAR TODO EL SCRIPT SE INTRODUCE EL COMANDO

