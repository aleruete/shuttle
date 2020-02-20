source("ui.R")

server<- function(input, output, session) {
  
  # Keeps the app awake----
  stayAwake <- reactiveTimer(10000)
  observe({
    stayAwake()
    cat(".")
  })
  
  # Calling all the modules that are being used----
  user_info <- callModule(login, "login")
  
  callModule(home, "home")
  
  callModule(welcome, "welcome")
  
  # Lesson 1
  
  callModule(geyser1, "geyser1")
  
  callModule(ggplot1, "ggplot1")
  
  callModule(weather1, "weather1")
  
  callModule(datatable1, "datatable1")
  
  callModule(timeseries1, "timeseries1")
  
  callModule(webscrape1, "webscrape1")

  # Lesson 2
  
  callModule(geyser2, "geyser2")
  
  callModule(datatable2, "datatable2")
  
  callModule(timeseries2, "timeseries2")
  
  # Lesson 3
  
  callModule(weather3, "weather3")
  
  # Rendering the Userpanel----
  output$userpanel <- renderUI({
    sidebarUserPanel(name = span(icon("user-astronaut"), username()),
                     subtitle = span(icon("globe-americas"), location),
                     image = img_url())
  })
  
  # Creating the username----
  username <- reactive({
    if(user_info()$user_login) {
      if (input$ichooseyou == 0) {
        user_info()$user
      }
      else {
        "Charizard"
      }
    } else {
      return(NULL)
    }
  })
  
  # Creating the user image----
  img_url <- reactive({
    if(user_info()$user_login) {
      if (input$ichooseyou == 0) {
        paste0("https://avatars2.githubusercontent.com/u/54476948?s=460&v=4")
      }
      else {
        paste0("https://vignette.wikia.nocookie.net/iso33private/images/9/95/Charizard.png") #RAWR
      }
    } else {
      return(NULL)
    }
  })
  
  # Creating the hyperlinks and icons----
  github_username <<- "shuttleds" #type your github username in here
  location <- "New York" #type your location in here
  
  instagram <- a(icon("instagram"), href="https://www.instagram.com/shuttleds/", target="_blank")
  twitter <- a(icon("twitter"), href="https://twitter.com/shuttledatasci/", target="_blank")
  github <- a(icon("github-square"), href=paste0("https://github.com/",github_username), target="_blank")
  youtube <- a(icon("youtube"), href="https://www.youtube.com/channel/UCHIge2lulmLXhEhWpajOT3Q", target="_blank")
  stackoverflow <- a(icon("stack-overflow"), href="https://stackoverflow.com/questions/tagged/shiny", target="_blank")
  stackexchange <- a(icon("stack-exchange"), href="https://stackoverflow.com/questions/tagged/quantmod", target="_blank")
  
  output$links <- renderUI({
    span(tagList(youtube,instagram,twitter,github,stackoverflow,stackexchange))
  })
  
  # Collapses the Sidebar before the user logs in----
  observe({
    if(user_info()$user_login) {
      shinyjs::removeClass(selector = "body", class = "sidebar-collapse")
    } else if (!isTruthy(user_info()$user_login)) {
      shinyjs::addClass(selector = "body", class = "sidebar-collapse")
    }
  })
  
  # Rendering the Sidebar----
  output$sidebar <- renderMenu({
    req(user_info()$user_login)
    
    if (input$mission %in% c("Gemini"))  { 
      sidebarMenu(id = "tabs",
                  menuItem("Home", tabName = "home_tabname", icon = icon("home"), selected = T),
                  menuItem("Lesson 1",
                           menuSubItem("Geyser", tabName = "geyser1_tabname", icon = icon("chart-bar")),
                           menuSubItem("Weather", tabName = "weather1_tabname", icon = icon("sun")),
                           menuSubItem("DataTable", tabName = "datatable1_tabname", icon = icon("table")),
                           menuSubItem("TimeSeries", tabName = "timeseries1_tabname", icon = icon("chart-line")),
                           menuSubItem("WebScrape", tabName = "webscrape1_tabname", icon = icon("binoculars")),
                           menuSubItem("ggplot2", tabName = "ggplot1_tabname", icon = icon("cube"))
                           
                  ),
                  menuItem("Lesson 2",
                           menuSubItem("Geyser", tabName = "geyser2_tabname", icon = icon("chart-bar")),
                           menuSubItem("DataTable", tabName = "datatable2_tabname", icon = icon("table")),
                           menuSubItem("TimeSeries", tabName = "timeseries2_tabname", icon = icon("chart-line"))
                  ),
                  menuItem("Lesson 3",
                           menuSubItem("Weather", tabName = "weather3_tabname", icon = icon("sun"))
                  )
      )
    } 
    else if (input$mission %in% c("Apollo")) { 
      sidebarMenu(id = "tabs",
                  menuItem("Home", tabName = "home_tabname", icon = icon("home")),
                  menuItem("Welcome", tabName = "welcome_tabname", icon = icon("rocket"), selected = T)
      )  
    }
    
  })
  
  # Rendering the Browser Button----
  output$browser <- renderUI({
    actionButton("browser", "Browser", icon = icon("code"))
  })
  
  observeEvent(input$browser,{
    browser()
  })
  
  # # Rendering the Dropdown Menus in the top bar----
  # output$messages <- renderMenu({
  #   
  #   dropdownMenu(type = "messages",
  #                messageItem(
  #                  from = "Sales Dept",
  #                  message = "Sales are good"
  #                ),
  #                messageItem(
  #                  from = "New User",
  #                  message = "How do I register?",
  #                  icon = icon("question"),
  #                  time = "3:20"
  #                ),
  #                messageItem(
  #                  from = "Support",
  #                  message = "New server is ready",
  #                  icon = icon("life-ring"),
  #                  time = "2019-06-29"
  #                )
  #   )
  #   
  # })
  # 
  # output$notifications <- renderMenu({
  #   
  #   dropdownMenu(type = "notifications", badgeStatus = "warning",
  #                notificationItem(
  #                  text = "10 new users",
  #                  icon("users")
  #                ),
  #                notificationItem(
  #                  text = "20 items delivered",
  #                  icon("truck"),
  #                  status = "success"
  #                ),
  #                notificationItem(
  #                  text = "Server load at 70%",
  #                  icon = icon("exclamation-triangle"),
  #                  status = "warning"
  #                )
  #   )
  #   
  # })
  # 
  # output$tasks <- renderMenu({
  #   
  #   dropdownMenu(type = "tasks", badgeStatus = "success",
  #                taskItem(value = 90, color = "green",
  #                         "Documentation"
  #                ),
  #                taskItem(value = 17, color = "aqua",
  #                         "Project Everest"
  #                ),
  #                taskItem(value = 75, color = "yellow",
  #                         "Server Deployment"
  #                )
  #   )
  #   
  # })
  
}