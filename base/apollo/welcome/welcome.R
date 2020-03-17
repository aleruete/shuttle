#UI Output/Namespace Section----
welcomeUI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("welcome_ui"))
}

#Module Section----
welcome <- function(input, output, session) {
  
  #UI Section----

  output$welcome_ui <- renderUI({
    
    tagList(
      
      div(
        tags$style('
.nav-tabs-custom .nav-tabs li.active:hover a, .nav-tabs-custom .nav-tabs li.active a {color: #385898;}
.nav-tabs-custom .nav-tabs li.active {border-top-color: #555;}
'),
        column(12,
               fluidRow(
                 tabBox(
                   id = session$ns("welcome_box"),
                   width = 5,
                   tabPanel(class = "home-tab",
                            title = "Getting Started",  value = "start", icon = icon("rocket"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("start")))
                            )),
                   tabPanel(class = "home-tab", style = "overflow-y:scroll;",
                            title = "About", value = "about", icon = icon("feather-alt"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("about")))
                            )),
                   tabPanel(class = "home-tab",
                            title = "SDS", value = "sds", icon = icon(c("frog","kiwi-bird","truck-monster") %>% sample(., 1)),
                            fluidRow(
                              column(12, htmlOutput(session$ns("sds")))
                            )),
                   tabPanel(class = "home-tab",
                            title = "Links", value = "links", icon = icon("plus"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("links")))
                            ))
                 ),
                 
                 tabBox(
                   id = session$ns("welcome_box"),
                   width = 6,
                   tabPanel(class = "welcome-tab",
                            title = "Welcome",  value = "start", icon = icon("rocket"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("welcome")))
                            )),
                   tabPanel(class = "welcome-tab",
                            title = "Plots", value = "plots", icon = icon("plus"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("plots")))
                            )),
                   tabPanel(class = "welcome-tab",
                            title = "DataTable", value = "datatable", icon = icon("plus"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("datatable")))
                            )),
                   tabPanel(class = "welcome-tab",
                            title = "TimeSeries", value = "timeseries", icon = icon("plus"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("timeseries")))
                            )),
                   tabPanel(class = "welcome-tab",
                            title = "WebScrape", value = "webscrape", icon = icon("plus"),
                            fluidRow(
                              column(12, htmlOutput(session$ns("webscrape")))
                            ))
                 )))
      )
    )
    
  })

  #Server Section----
  
  output$about <- renderUI({includeMarkdown(paste0("base/apollo/welcome/about.md"))})
  
  output$sds <- renderUI({includeMarkdown(paste0("base/apollo/welcome/sds.md"))})
  
  output$start <- renderUI({includeMarkdown(paste0("base/apollo/welcome/start.md"))})
  
  output$links <- renderUI({includeMarkdown(paste0("base/apollo/welcome/links.md"))})
  
  
  output$welcome <- renderUI({includeMarkdown(paste0("base/apollo/welcome/welcome.md"))})
  
  output$plots <- renderUI({includeMarkdown(paste0("base/apollo/welcome/plots.md"))})
  
  output$datatable <- renderUI({includeMarkdown(paste0("base/apollo/welcome/datatable.md"))})
  
  output$timeseries <- renderUI({includeMarkdown(paste0("base/apollo/welcome/timeseries.md"))})
  
  output$webscrape <- renderUI({includeMarkdown(paste0("base/apollo/welcome/webscrape.md"))})
  
}