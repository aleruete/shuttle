# install.packages(c("shiny", "shinydashboard", "shinyjs", "tidyverse","rvest",
#                    "tidyquant","dygraphs","xts","DT","xml2","lubridate"))

# Loading all the packages needed
library(shiny)
library(shinydashboard)
library(shinyjs)
library(tidyverse)
library(rvest)

# Loading all the necessary source files
source("login.R")
source("base/home/home.R")
source("base/home/googleRSS.R")
source("base/welcome/welcome.R")
# Plots and Charts
source("base/projects/plots_charts/geyser1.R")
source("base/projects/plots_charts/ggplot1.R")
source("base/projects/plots_charts/geyser2.R")
# DataTable
source("base/projects/datatable/datatable1.R")
source("base/projects/datatable/datatable2.R")
# TimeSeries
source("base/projects/timeseries/timeseries1.R")
source("base/projects/timeseries/timeseries2.R")
# Weather
source("base/projects/weather/weather1.R")
source("base/projects/weather/weather3.R")
# Webscrape
source("base/projects/webscrape/webscrape1.R")

# Sets the time zone
# Find your time zone here https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
# The function OlsonNames() also has a list of time zones
Sys.setenv(TZ="America/New_York")

user_github <<- "shuttleds" #type your github username in here
user_loc <- "New York" #type your location in here
user_lat <- 40.678815 #insert latitude value here
user_long <- -73.987942 #insert longitude value here
