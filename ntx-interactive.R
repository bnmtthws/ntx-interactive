library(ggplot2)
library(gdata)

### set your working directory
setwd('~/bioinfo/github/ntx-interactive/')


### define the relevant filenames within the working directory
ANNOTATION <- 'files/Additional file 3 - AaegLRU annotation.xlsx'
TPM_RU <- 'files/Additional File 5 - TPM_all.xlsx'
TPM_VEC <- 'files/Additional File 6 - TPM_all_AaegL3.3.xlsx'

### read in these files
annotations <- read.xls(ANNOTATION)
tpm_ru <- read.xls(TPM_RU)
tpm_vec <- read.xls(TPM_VEC)