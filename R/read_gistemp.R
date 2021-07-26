#' Read GISTEMP monthly data in tidy form
#' @name read_gistemp
#' @importFrom magrittr %>%
#'
#' @return A tidy GISTEMP time series
#'

read_gistemp <- function() {

  data <-
    readr::read_csv("https://data.giss.nasa.gov/gistemp/tabledata_v4/GLB.Ts+dSST.csv",
                    na = "***", skip = 1) %>%
    dplyr::rename("1" = "Jan",
                  "2" = "Feb",
                  "3" = "Mar",
                  "4" = "Apr",
                  "5" = "May",
                  "6" = "Jun",
                  "7" = "Jul",
                  "8" = "Aug",
                  "9" = "Sep",
                  "10" = "Oct",
                  "11" = "Nov",
                  "12" = "Dec") %>%
    dplyr::select(Year:"12") %>%
    tidyr::pivot_longer("1":"12", names_to = "Month", values_to = "Temperature")
  data$Month <- as.integer(data$Month)


  data$Datetime <- lubridate::ym(paste(data$Year, data$Month)) + lubridate::days(14)
  data$Year_dec <- lubridate::decimal_date(data$Datetime)

  data$Name <- "GISTEMP v4"
  data <- data %>% dplyr::select(Name, Year, Month, Year_dec, Datetime, everything())

  # clean NAs
  data <- data %>% dplyr::filter(!is.na(Temperature))

  return(data)
}
