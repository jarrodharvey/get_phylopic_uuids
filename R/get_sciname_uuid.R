get_sciname_uuid <- function(scientific_name) {
  out <- tryCatch(
    {
      search_text(scientific_name)
    },
    error = function(cond) {
      message(paste("A pic for the scientific name", scientific_name, "is not available."))
      message("Here's the original error message:")
      message(cond)
      # Choose a return value in case of error
      if (as.character(cond) != "Error in y[[1]]: subscript out of bounds\n") {
        stop("Unusual error message detected! Stopping...")
      }
      return(
        tibble(uid = NA, string = NA)
      )
    },
    warning = function(cond) {
      message(paste("Scientific name caused a warning:", scientific_name))
      message("Here's the original warning message:")
      message(cond)
      # Choose a return value in case of warning
      return(
        tibble(uid = NA, string = NA)
      )
    },
    finally = {
      message(paste("\nProcessed scientific name:", scientific_name))
      message("--------------------------------------------------")
    }
  )
  return(out[1,])
}
