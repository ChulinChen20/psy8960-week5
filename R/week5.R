# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)

# Data Import
Adata_tbl <- read_delim("../data/Aparticipants.dat",delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
Anotes_tbl <-read_csv("../data/Anotes.csv",col_names = TRUE)
Bdata_tbl <- read_delim("../data/Bparticipants.dat",delim = "\t", col_names = c("casenum", "parnum", "stimver", "datadate", paste0("q",1:10)))
Bnotes_tbl <-read_delim("../data/Bnotes.txt",delim = "\t",col_names = TRUE)

# Data Cleaning
Aclean_tbl <- Adata_tbl %>%
  separate(qs, into = paste0("q",1:5),sep = " - ") %>%
  mutate(datadate=as.POSIXct(datadate, format = "%b %d %Y, %H:%M:%S")) %>%
  mutate_at(vars(paste0("q",1:5)),as.integer)


ABclean_tbl <- Bdata_tbl %>%
  mutate(datadate=as.POSIXct(datadate, format = "%b %d %Y, %H:%M:%S")) %>%
  mutate_at(vars(paste0("q",1:10)),as.integer)
  
