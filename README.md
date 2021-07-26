# climatehelpers

Helper R function to download common climate data in tidy long format.

## Installation

Install with devtools:
```r
devtools::install_github("tlinna/climatehelpers")
```

## Usage

Download and read data with the read_climate_ts function.

```r
data <- read_climate_ts(
  name = "hadcrut",
  resolution = "monthly",
  pad_last_year = FALSE,
  baseline = c(1881, 1920)
)
```
