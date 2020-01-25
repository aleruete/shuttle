# Loading all the packages needed
library(shiny)
library(shinydashboard)
library(shinycssloaders)
library(shinyjs)
library(htmltools)
library(tidyverse)
library(lubridate)
library(openxlsx)
library(DT)
library(xts)
library(dygraphs)
library(tidyquant)
library(rvest)

# Loading all the necessary source files
source("login.R")
source("home/home.R")
source("home/googleRSS.R")
#Lesson 1 Files
source("lesson1/geyser1.R")
source("lesson1/weather1.R")
source("lesson1/datatable1.R")
source("lesson1/timeseries1.R")
source("lesson1/webscrape1.R")
#Lesson 2 Files
source("lesson2/geyser2.R")
source("lesson2/datatable2.R")

# Sets the time zone
Sys.setenv(TZ="America/New_York")

# A very simple username/password table
user_base <- tibble::tibble(
  user = c("Charizard", "Guest")
  # password = c("admin_pass", "guest_pass")
)
