# Russia During the COVID-19 Pandemic

## Overview

This repo provides all the work and files used and created while writing the paper titled *"Evaluating Russia's Response to the COVID-19 Pandemic: An Analysis of High Excess Death Rates Despite High GHS Index"*. To access the PDF of the paper you can find it in the `paper` directory where it is named as `paper.pdf`. The File Structure Section outlines each directory and also all relevant material that they contain. Please go through the File Structure Section before accessing the repo to gain all the understanding needed.

To use this folder, click the green "Code" button", then "Download ZIP". The user can then move the folder around to wherever they want to work on it on their own computer.

The repo has been created in a reproducible way for as to allow users to access and reproduce the work easily. Happy Reading!

## LLM Usage

Chat-GPT4 was used as an LLM for this paper where the usage was restricted to learning some features of Quarto and R, and was restricted to only be used for the coding aspect. All the usages have been included in `other/llm/usage.txt` for reference, with the full chat with the LLM.

## Replication Data Access

All the raw data used for replication in this paper was from the replication package of Nuzzo and Ledesma's paper. 
-   `other/literature` contains the paper being replicated in this report.
-   `data/raw_data` contains the raw data from the replication package of the replicated paper.
-   `scripts/99-replications.R` contains the R code to replicate 3 figures in the paper.

Replication on Social Science Reproduction platform available at: https://www.socialsciencereproduction.org/reproductions/8938b287-6681-4a5e-8993-42011a51be58/index

## File Structure

The repo has been structured in a way to make it accessible to the user. The repo is structured as:

-   `data/raw_data` contains the raw data from the replication package of the replicated paper, as mentioned above.
-   `data/analysis_data` contains the cleaned data after running script `02-data_cleaning.R`.
-   `other/literature` contains the paper being replicated in this report, as mentioned above.
-   `other/llm` contains the file `usage.txt` that includes the chat with the LLM as reference.
-   `other/sketches` contains two sketches for the datasets `dataset.pdf` and the graphs `graphs.pdf` as reference to what is to be expected in the paper.
-   `paper` contains the files used to generate the paper, including the Quarto document, `paper.qmd`, the reference bibliography file, `references.bib` as well as the PDF of the paper, `paper.pdf`. 
-   `scripts` contains the R scripts used to simulate `00-simulate_data.R`, clean `02-data_cleaning.R`, test data `03-test_data.R` and replicate the data in Nuzzo and Ledesma's paper `99-replications.R`. Kindly read the prerequisites in the R scripts' preamble to be able to reuse and run the code.


