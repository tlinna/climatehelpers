#' Download and read climate time series
#'
#' A helper function to load up-to-date common climate timeseries
#' data sets, and to format them in consistently named tidy long form data.
#'
#' @name read_climate_ts
#' @importFrom magrittr %>%
#'
#' @param name One of "hadcrut", "gistemp", "noaa", "berkeley".
#'
#' @param resolution Either "monthly" or "annual".
#' @param pad_last_year
#' Pad months to the end of last year with NAs. If resolution is annual, last
#' partial year is then averaged and included in the data.
#'
#' @param baseline Baseline start and end year as a vector.
#'
#' @return Tidy, long form climate time series data set.
#' @export

read_climate_ts <- function(name = "hadcrut", resolution = "monthly", pad_last_year = FALSE,
                            baseline = c(1881,1920)) {

  if (name == "hadcrut") {

    data <- read_hadcrut5()

  } else if (name == "gistemp") {

    data <- read_gistemp()

  } else if (name == "noaa") {

    data <- read_noaa()

  } else if (name == "berkeley") {

    data <- read_berkeley()

  } else {
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

  data <- change_baseline(data, baseline)

  return(data)
}






