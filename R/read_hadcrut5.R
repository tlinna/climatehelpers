#' Read HadCRUT5 monthly data in tidy form
#' @name read_hadcrut5
#' @importFrom magrittr %>%
#'
#' @return A tidy HadCRUT5 data set
#'

read_hadcrut5 <- function() {

  pkgcond::suppress_messages(
    data <-
      readr::read_csv("https://www.metoffice.gov.uk/hadobs/hadcrut5/data/current/analysis/diagnostics/HadCRUT.5.0.1.0.analysis.summary_series.global.monthly.csv") %>%
      dplyr::rename(Temperature = `Anomaly (deg C)`,
                    lower_ci = `Lower confidence limit (2.5%)`,
                    upper_ci = `Upper confidence limit (97.5%)`,
                    Time_char = Time)
  )

  data$Datetime <- lubridate::ym(data$Time_char) + lubridate::days(14)
  data$Year_dec <- lubridate::decimal_date(data$Datetime)

  data$Year <- lubridate::year(data$Datetime)
  data$Month <- lubridate::month(data$Datetime)

  data$Name <- "HadCRUT5"
  data <- data %>% dplyr::select(Name, Year, Month, Year_dec, Datetime, everything(), -Time_char)

  return(data)
}
