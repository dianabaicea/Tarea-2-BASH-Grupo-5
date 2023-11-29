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
  <summary style="font-size: 20px;"><strong>Table of Contents</summary>
  <ol>
    <li>
      <a href="#1---about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#2---input">Input</a>
      <ul>
        <li><a href="#parameters">Parameters</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
  </ol>
</details>
  <br />

## 1 - About The Project
In this project, we developed an automated process that analyzes a chosen number of ChIP-seq samples of Transcription Factors (TFs) or Epigenetic Marks (EMs) in Arabidopsis thaliana model organisms. The results obtained are a _list of target genes that could be regulated by TFs or EMs, GO and KEGG metabolic pathways enrichment and DNA motifs in the TSS region where the transcription factor is bound_.

The process is based on three bash scripts (_pipe.sh_, _sample_proc.sh_, _callpeaks.sh_) and one R script (_pipe.R_). The parameters needed for its execution must be specified in the _params.txt_ file previously the script is run. In the next paragraph, these parameters are explained to better comprehend its use.

## 2 - Input
### Parameters

An example of the model file params_file.txt is found ChIPing/my_test/params_file.txt
The params file should contain the following parameters:
To process ChIP-Seq data run the executable chip_data_process.sh with param_input as unique input. On the folder: param_input you can find the file param_input.txt where it is neccesary to write this parameters:

The _params.txt_ file is the only one that the user needs to edit according to their data to run the entire analysis. An example of the _params.txt_ file can be found in this repository. In the following section, these parameters are explained to better comprehend its use:

* path_input_1: <the path to access into the location where the input file is. Must be written as much paths as input samples the study has>
* path_chip_1: <the path to access into the location where the chip file is. Must be written as much paths as chip samples the study has>
* path_genome: <the path to access into the location where the genome file of the organism is>
* path_annotation: <the directory where the annotation.gtf are located>
* experiment_name: <name of the folder where the analysis is been taking >
* working_directory: <the directory where the analysis is carried out  >
* installation_directory: <the directory where all the executable files are archived>
* number_chip: <number of chip samples the study have>
* number_input: <number of input samples the study have>
* tf_em: <type of data used in the study, use “tf” in case of transcription factor or “em” if it is epigenetics marks>
