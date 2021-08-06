# climatehelpers

Helper R function(s) to download and format common climate time series data in tidy long format.

## Installation

Install with package devtools:
```r
devtools::install_github("tlinna/climatehelpers")
```

## Usage

Download and read data with the read_climate_ts function. You can also pad last, partial year with NAs, which is then included when averaging annual data. The data is then baselined, and you can provide baseline start and end years if necessary.

```r
data <- read_climate_ts(
  name = "hadcrut",
  resolution = "monthly",
  pad_last_year = FALSE,
  baseline = c(1880, 1919)
)
```

Common columns provided are Name, Year, Month, Year_dec, Datetime and Temperature. With HadCRUT5 95% CI boundaries are also provided.

## Data

Currently the function is working with the following global time series data in either monthly or annual resolution:

- HadCRUT 5.0.1.0
- GISTEMP v4
- NOAA GlobalTemp v5
- Berkeley Earth

## TODO

- proper error handling and messaging
- choice of global/hemispheres or custom latitudes or lat/lon box
