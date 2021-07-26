#' Read Berkeley Earth monthly data in tidy form
#'
#' @name read_berkeley
#' @importFrom magrittr %>%
#' @return Tidy Berkeley Earth time series
#'

read_berkeley <- function() {

  pkgcond::suppress_warnings(
    pkgcond::suppress_messages(
      data <- readr::read_table2("http://berkeleyearth.lbl.gov/auto/Global/Land_and_Ocean_complete.txt",
                                 col_names = FALSE, skip = 86) %>%
        dplyr::rename(Year = X1,
                      Month = X2,
                      Temperature = X3) %>%
        dplyr::select(Year, Month, Temperature)
    )
  )



  # Since there are two tables in the source file, find NA rows and slice the head

  na_row_indexes <- which(is.na(data$Year))
  data <- data %>% dplyr::slice_head(n = na_row_indexes[1] - 1)

  data$Datetime <- lubridate::ym(paste(data$Year, data$Month)) + lubridate::days(14)
  data$Year_dec <- lubridate::decimal_date(data$Datetime)

  data$Name <- "Berkeley Earth"
  data <- data %>% dplyr::select(Name, Year, Month, Year_dec, Datetime, everything())

  return(data)

}
