globalVariables(c("Name", "Year", "Month", "Year_dec", "Datetime", "Time_char",
                  "data", "%>%", "!!", ":=", "::", "Anomaly (deg C)", "Lower confidence limit (2.5%)",
                  "Time", "Upper confidence limit (97.5%)", "everything", "last_month", "nas_tibble",
                  "Temperature", "X1", "X2", "X3", "str_detect"))

#' Pad empty month rows to the end of last year
#'
#' @param data Data to be padded to a full year.
#'
#' @return Data padded to full year with NAs as necessary.
#'
pad_to_full_year <- function(data) {

  # Pad NAs to full year

  last_month <- data$Month[nrow(data)]
  last_year <- data$Year[nrow(data)]

  if(last_month < 12) {

    months_to_add <- (last_month + 1):12
    nas_tibble <- tibble::tibble(Year = last_year,
                                 Month = months_to_add)
    data <- dplyr::full_join(data, nas_tibble)

  }
  return(data)
}

#' Annualise monthly data
#'
#' @param data Tidy long form data to be reduced to annual resolution.
#'
#' @return Annual data.

annualise_data <- function(data) {

  dataname <- data$Name[1]
  annual_data <- data %>% dplyr::group_by(Year) %>% dplyr::summarise(
    Name = dataname,
    Temperature = mean(Temperature))
  return(annual_data)

}

#' Scrape NOAA url from NOAA timeseries directory
#'
#' @return Url to current NOAA GlobalTemp time series file.
#'

scrape_noaa_url <- function() {

  noaa_dir_url <- "https://www.ncei.noaa.gov/data/noaa-global-surface-temperature/v5/access/timeseries/"
  html_page <- rvest::read_html(noaa_dir_url)
  url_table <- html_page %>% rvest::html_node("table") %>% rvest::html_table()
  noaa_url <- dplyr::filter(url_table, str_detect(url_table$Name, "aravg.mon.land_ocean.90S.90N")) %>%
    dplyr::select(Name)
  noaa_url <- paste0(noaa_dir_url, noaa_url[[1]])

  return(noaa_url)

}
