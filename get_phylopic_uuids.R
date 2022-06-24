rm(list=setdiff(ls(), c("rD", "remDr")))
cat("\014")

easypackages::packages("dplyr", "rphylopic", "DBI", "RSQLite", "pbapply", "stringr", "tibble")

sapply(list.files("R", full.names = TRUE), source)

# Read the unique scientific names into memory
unique_scientific_names_with_authorship <- readRDS("data/unique_scientific_names_with_authorship.rds")

# Connect to the db
phylo_db <- dbConnect(RSQLite::SQLite(), "db/phylo_uuids.sqlite")

# Read the already completed scientific names into memory
already_processed <- dbReadTable(phylo_db, "phylopic_uuids") %>%
  .$search_term

# Create a list of scientific names to read based on what hasn't yet been done
still_to_process <- setdiff(str_to_lower(unique_scientific_names_with_authorship), str_to_lower(already_processed))

# Iterate through the remaining scientific names and write the OTT and the MATCHED names to the db
pblapply(still_to_process, function(scientific_name) {
  retrieved_data <- get_sciname_uuid(scientific_name) %>%
    add_column(search_term = scientific_name)
  dbAppendTable(phylo_db, "phylopic_uuids", retrieved_data)
})
