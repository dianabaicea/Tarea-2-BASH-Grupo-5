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
* Giles Floriano, Carmen   &nbsp;&nbsp;    <a href="mailto:carmengiles02@gmail.com"><img src="https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/112-gmail_email_mail-512.png" alt="Haz clic para enviar un correo" width="15"/></a> &nbsp; <a href="https://github.com/CarmenGiles"><img src="https://cdn-icons-png.flaticon.com/512/25/25231.png" alt="Haz clic para visitar mi GitHub" width="15"/></a>

* Baicea, Diana Andreea   &nbsp;&nbsp;    <a href="mailto:diana.baicea@gmail.com"><img src="https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/112-gmail_email_mail-512.png" alt="Haz clic para enviar un correo" width="15"/></a> &nbsp; <a href="https://github.com/dianabaicea"><img src="https://cdn-icons-png.flaticon.com/512/25/25231.png" alt="Haz clic para visitar mi GitHub" width="15"/></a>

* Rodríguez Ramírez, Lucía   &nbsp;&nbsp;    <a href="mailto:luciarguez20@gmail.com"><img src="https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/112-gmail_email_mail-512.png" alt="Haz clic para enviar un correo" width="15"/></a> &nbsp; <a href="https://github.com/luciarguez20"><img src="https://cdn-icons-png.flaticon.com/512/25/25231.png" alt="Haz clic para visitar mi GitHub" width="15"/></a>

* Tejero Miranda, Lucía   &nbsp;&nbsp;    <a href="mailto:luciatejerom@gmail.com"><img src="https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/112-gmail_email_mail-512.png" alt="Haz clic para enviar un correo" width="15"/></a> &nbsp; <a href="https://github.com/Luciatej"><img src="https://cdn-icons-png.flaticon.com/512/25/25231.png" alt="Haz clic para visitar mi GitHub" width="15"/></a>

* Revilla López, Vicente   &nbsp;&nbsp;    <a href="mailto:vicenterevillalopez4@gmail.com"><img src="https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/112-gmail_email_mail-512.png" alt="Haz clic para enviar un correo" width="15"/></a> &nbsp; <a href="https://github.com/vicrevlop"><img src="https://cdn-icons-png.flaticon.com/512/25/25231.png" alt="Haz clic para visitar mi GitHub" width="15"/></a>
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



## 2 - Input
### Parameters

The _params.txt_ file is the only one that the user needs to edit according to their data to run the entire analysis. An example of the <a href="URL_del_enlace">_params.txt_</a> file can be found in this repository. In the following section, these parameters are explained to better comprehend its correct specification:

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



### Scripts

A detailed summary of the steps followed by each script will be described:





