# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)

# Data Import
Adata_tbl <- read_delim("../data/Aparticipants.dat",delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
Anotes_tbl <-read_csv("../data/Anotes.csv",col_names = TRUE)
Bdata_tbl <- read_delim("../data/Bparticipants.dat",delim = "\t", col_names = c("casenum", "parnum", "stimver", "datadate", paste0("q",1:10)))
Bnotes_tbl <-read_delim("../data/Bnotes.txt",delim = "\t",col_names = TRUE) # read_tsv("../data/Bnotes.txt")

# Data Cleaning
Aclean_tbl <- Adata_tbl %>%
  separate(qs, into = paste0("q",1:5),sep = " - ") %>% #across(contains("q"))
  mutate(datadate=mdy_hms(datadate)) %>%
  mutate(across(q1:q5, as.integer)) %>%
  left_join(Anotes_tbl,by="parnum")%>%
  filter(is.na(notes))
ABclean_tbl <- Bdata_tbl %>%
  mutate(datadate=mdy_hms(datadate)) %>%
  mutate(across(q1:q5, as.integer))%>%
  left_join(Bnotes_tbl,by="parnum")%>%
  filter(is.na(notes))%>%
  select(-notes)%>%
  bind_rows(Aclean_tbl,.id="lab")
  
  
