#' Read climate time series in tidy long form
#' @name read_climate_ts
#' @importFrom magrittr %>%
#' @param name One of "hadcrut5", "gistemp", others ...TODO
#'
#' @param resolution Either "monthly" or "annual".
#' @param pad_last_year Pad months to the end of last year with NAs.
#'
#' @return Tidy climate data set
#' @export

read_climate_ts <- function(name = "hadcrut5", resolution = "monthly", pad_last_year = FALSE) {

  if (name == "hadcrut5") {

    data <- read_hadcrut5()

  } else if (name == "gistemp") {

    data <- read_gistemp()

  } else if (name == "noaa") {

    data <- read_noaa()

  }  else {
    stop("Name not recognized.")
  }


  if (pad_last_year == T) {

    data <- pad_to_full_year(data)

  }

  if(resolution == "annual") {

    data <- annualise_data(data)
    data$Name <- paste0(data$Name, " Annual")

  } else if (resolution == "monthly") {

  data$Name <- paste0(data$Name, " Monthly")

  } else {
    stop("Resolution not recognized.")
  }

  return(data)
}






