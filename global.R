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
# Lesson 1 Files
source("base/lessons/lesson1/geyser1.R")
source("base/lessons/lesson1/weather1.R")
source("base/lessons/lesson1/datatable1.R")
source("base/lessons/lesson1/timeseries1.R")
source("base/lessons/lesson1/webscrape1.R")
# Lesson 2 Files
source("base/lessons/lesson2/geyser2.R")
source("base/lessons/lesson2/datatable2.R")
source("base/lessons/lesson2/timeseries2.R")
# Lesson 3 Files
source("base/lessons/lesson3/weather3.R")

# Sets the time zone
# Find your time zone here https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
# The function OlsonNames() also has a list of time zones
Sys.setenv(TZ="America/New_York")
