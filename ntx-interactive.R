### import the required libraries
library(ggplot2)
library(gdata)

### set your working directory
setwd('~/bioinfo/github/ntx-interactive/')

### define the relevant filenames within the working directory
ANNOTATION <- 'files/Additional file 3 - AaegLRU annotation.csv'
TPM_RU <- 'files/Additional File 5 - TPM_all.csv'
TPM_VEC <- 'files/Additional File 6 - TPM_all_AaegL3.3.csv'

### read in these files
annotations <- read.csv(ANNOTATION)
tpm_ru <- read.csv(TPM_RU)
tpm_vec <- read.csv(TPM_VEC)