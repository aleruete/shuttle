#UI Output/Namespace Section----
weather1UI <- function(id) {
  ns <- NS(id)
  
  uiOutput(ns("weather1_ui"))
}

#Module Section----
weather1 <- function(input, output, session) {
  
  #UI Section----
  
  output$weather1_ui <- renderUI({
    
    tagList(
      h2("Weather: Step 1"),
      
      div(
        fluidRow(
          
          # Displays the weather app 
          box(width = 6,
            htmlOutput(session$ns("weather"))
          )
        ))
    )
    
  })
  
  #Server Section----
  
  # Creates the weather app
  output$weather <- renderUI({
    
    lat <- 74.0060 #insert latitude value here
    long <- 40.7128 #insert longitude value here
    loc <- "Manhattan, New York" #insert name of location
    
    dark.base1 <- "https://forecast.io/embed/#"
    call.dark1 <- paste(dark.base1, "lat=", lat, "&lon=", long, "&name=", loc, sep="")
    tags$iframe(src=call.dark1, width= "100%", height= 230, frameborder= 0)
    # height=230, width=615
  })
  
  
}