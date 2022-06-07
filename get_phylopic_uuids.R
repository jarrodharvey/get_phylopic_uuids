rm(list=setdiff(ls(), c("rD", "remDr")))
cat("\014")

easypackages::packages("dplyr", "rphylopic", "DBI", "RSQLite", "pbapply", "stringr")

# Read the unique scientific names into memory
unique_scientific_names <- read.csv("/home/jarrod/R Scripts/merge_ncbi_and_col_datasets/species_table.csv") %>%
  .$scientific.name %>%
  unique(.)

