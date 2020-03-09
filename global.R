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
# Plots
source("base/gemini/plots/geyser1.R")
source("base/gemini/plots/ggplot1.R")
source("base/gemini/plots/geyser2.R")
# DataTable
source("base/gemini/datatable/datatable1.R")
source("base/gemini/datatable/datatable2.R")
# TimeSeries
source("base/gemini/timeseries/timeseries1.R")
source("base/gemini/timeseries/timeseries2.R")
# Weather
source("base/gemini/weather/weather1.R")
source("base/gemini/weather/weather3.R")
# Webscrape
source("base/gemini/webscrape/webscrape1.R")
# Apollo
# Source your files here.

# Sets the time zone
# Find your time zone here https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
# The function OlsonNames() also has a list of time zones
Sys.setenv(TZ="America/New_York")

user_github <<- "shuttleds" #type your github username in here
user_loc <- "New York" #type your location in here
user_lat <- 40.678815 #insert latitude value here
user_long <- -73.987942 #insert longitude value here
