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
source("home/home.R")
source("home/googleRSS.R")
# Lesson 1 Files
source("lesson1/geyser1.R")
source("lesson1/weather1.R")
source("lesson1/datatable1.R")
source("lesson1/timeseries1.R")
source("lesson1/webscrape1.R")
# Lesson 2 Files
source("lesson2/geyser2.R")
source("lesson2/datatable2.R")
source("lesson2/timeseries2.R")
# Lesson 3 Files
source("lesson3/weather3.R")

# Sets the time zone
# Find your timezone here https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
Sys.setenv(TZ="America/New_York")

# A very simple username/password table
user_base <- tibble::tibble(
  user = c("Admin", "Guest")
  # password = c("admin_pass", "guest_pass")
)
