#UI Output/Namespace Section----
weather3UI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("weather3_ui"))
}

#Module Section----
weather3 <- function(input, output, session) {
  
  #UI Section----
  
  output$weather3_ui <- renderUI({
    
    tagList(
      h2("Weather: Step 3"),
      
               tags$script('
      $(document).ready(function () {
              navigator.geolocation.getCurrentPosition(onSuccess, onError);

              function onError (err) {
              Shiny.onInputChange("weather3-geolocation", false);
              }

              function onSuccess (position) {
              setTimeout(function () {
              var coords = position.coords;
              console.log(coords.latitude + ", " + coords.longitude);
              Shiny.onInputChange("weather3-geolocation", coords.latitude + ", " + coords.longitude);
              Shiny.onInputChange("weather3-lat:", coords.latitude);
              Shiny.onInputChange("weather3-long", coords.longitude);
              }, 1100)
              }
              });
              '),
      
      div(
        fluidRow(
          
          # Displays the weather app 
          box(width = 12,
            htmlOutput(session$ns("weather"))
          )
        ))
    )
    
  })
  
  #Server Section----
  
  #Creates reactive values for longitude and latitude
  vals <- reactiveValues()
  observe({
    vals$lat <- input$lat
    vals$long <- input$long
  })
  
  #Uses the long and lat to figure out location name from openstreepmap.org
  observeEvent(vals$long, {
    base <- "https://nominatim.openstreetmap.org/reverse?format=json&"
    
    url <- paste0(base,'lat=',vals$lat,'&lon=',vals$long)
    
    loc <- read_html(url) %>%
      html_nodes("p") %>%
      html_text()
    
    p1 <- gsub("[][!#$%()*,.:;<=>@^_`|~.{}]", "", loc)
    
    p2 <- str_split(p1, '"\"')
    
    n_city <-which(grepl("city", p2[[1]])) + 1
    n_state <-which(grepl("state", p2[[1]])) + 1
    
    city <- p2[[1]][n_city]
    state <- p2[[1]][n_state]
    
    
    vals$loc <- paste(city, state, sep = ", ")
  })
  
  
  # Creates the weather app
  output$weather <- renderUI({
    req(vals$loc)
    
    dark.base1 <- "https://forecast.io/embed/#"
    call.dark1 <- paste(dark.base1, "lat=", vals$lat, "&lon=", vals$long, "&name=", vals$loc, sep="")
    tags$iframe(src=call.dark1, height=230, width=615, frameborder = 0)
    
  })
  
}