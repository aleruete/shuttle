source("ui.R")

server<- function(input, output, session) {
  
  # Keeps the app awake----
  stayAwake <- reactiveTimer(10000)
  observe({
    stayAwake()
    cat(".")
  })
  
  # Home Base ----
  login_info <- callModule(login, "login")
  
  callModule(home, "home")
  
  callModule(welcome, "welcome")
  
  # Gemini Modules ----
  
  callModule(geyser1, "geyser1")
  
  callModule(ggplot1, "ggplot1")
  
  callModule(weather1, "weather1")
  
  callModule(datatable1, "datatable1")
  
  callModule(timeseries1, "timeseries1")
  
  callModule(webscrape1, "webscrape1")
  
  callModule(geyser2, "geyser2")
  
  callModule(datatable2, "datatable2")
  
  callModule(timeseries2, "timeseries2")
  
  callModule(weather3, "weather3")
  
  # Apollo Modules ----
  # Call your modules here.
  
  # UserPanel Information----
  user <- reactiveValues(name = NULL,
                         loc = NULL,
                         img = NULL)
  
  observe({
    if(login_info()$access) {
      if (input$ichooseyou %% 2 == 0) {
        user$name = login_info()$name
        user$loc = user_loc
        user$img = paste0("https://github.com/",login_info()$name,".png")
      }
      else {
        user$name = "Charizard" #RAWR
        user$loc = "Kanto"
        user$img = "https://vignette.wikia.nocookie.net/iso33private/images/9/95/Charizard.png"
      }
    } else {
      return(NULL)
    }
  })
  
  # Collapses the Sidebar before the user logs in ----
  observe({
    if(login_info()$access) {
      shinyjs::removeClass(selector = "body", class = "sidebar-collapse")
      
      #Render the UserPanel
      output$userpanel <- renderUI({
        sidebarUserPanel(name = span(icon("user-astronaut"), user$name),
                         subtitle = span(icon("globe-americas"), user$loc),
                         image = user$img)
      })
      
      #Render Mission Radio Buttons
      output$mission_radio <- renderUI({
        radioButtons("mission", label = NULL, c("Gemini","Apollo"), selected = "Gemini", inline = TRUE)
      })
      
    } else if (!isTruthy(login_info()$access)) {
      shinyjs::addClass(selector = "body", class = "sidebar-collapse")
    }
  })
  
  # Rendering the Sidebar----
  output$sidebar <- renderMenu({
    req(login_info()$access & input$mission > 0)
    
    if (input$mission %in% c("Gemini"))  { 
      sidebarMenu(id = "tabs",
                  menuItem("Home", tabName = "home_tabname", icon = icon("home"), selected = T),
                  menuItem("Plots", icon = icon("chart-bar"),
                           menuSubItem("Geyser 1", tabName = "geyser1_tabname"),
                           menuSubItem("Geyser 2", tabName = "geyser2_tabname"),
                           menuSubItem("ggplot2 1", tabName = "ggplot1_tabname")
                  ),
                  menuItem("DataTable", icon = icon("table"),
                           menuSubItem("DataTable 1", tabName = "datatable1_tabname"),
                           menuSubItem("DataTable 2", tabName = "datatable2_tabname")
                  ),
                  menuItem("TimeSeries", icon = icon("chart-line"),
                           menuSubItem("TimeSeries 1", tabName = "timeseries1_tabname"),
                           menuSubItem("TimeSeries 2", tabName = "timeseries2_tabname")
                  ),
                  menuItem("Weather", icon = icon("sun"),
                           menuSubItem("Weather 1", tabName = "weather1_tabname"),
                           menuSubItem("Weather 3", tabName = "weather3_tabname")
                  ),
                  menuItem("WebScrape", icon = icon("binoculars"),
                           menuSubItem("WebScrape 1", tabName = "webscrape1_tabname")
                  )
      )
    }
    # Apollo
    else if (input$mission %in% c("Apollo")) {
      sidebarMenu(id = "tabs",
                  menuItem("Welcome to Apollo", tabName = "welcome_tabname", selected = T),
                  menuItem("Home", tabName = "home_tabname", icon = icon("home")),
                  # Place your menu items here.
                  menuItem("Your Tab", tabName = " ", icon = icon("user-astronaut"))
                  
      )  
    }
    
  })
}