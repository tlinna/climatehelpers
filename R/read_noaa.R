

#' Read NOAA GlobalTemp v5 monthly data in tidy form
#'
#' @name read_noaa
#' @importFrom magrittr %>%
#'
#' @return Tidy long form NOAA time series data.
#'

read_noaa <- function() {

  url <- scrape_noaa_url()
  data <-
    readr::read_table2(url, col_names = FALSE) %>%
    dplyr::rename(Year = X1,
                  Month = X2,
                  Temperature = X3) %>%
    dplyr::select(Year, Month, Temperature)

  data$Datetime <- lubridate::ym(paste(data$Year, data$Month)) + lubridate::days(14)
  data$Year_dec <- lubridate::decimal_date(data$Datetime)

  data$Name <- "NOAA GlobalTemp v5"
  data <- data %>% dplyr::select(Name, Year, Month, Year_dec, Datetime, everything())

  return(data)

}
