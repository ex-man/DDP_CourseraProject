library(shiny)

dataset <- cars #read data

shinyUI(pageWithSidebar(
  
  headerPanel("Fitting distribution to Cars data"),
  
  sidebarPanel(
    
    selectInput('x', 'X', names(dataset)),
    uiOutput("ui_mean"),
    uiOutput("ui_sd"),
    tags$p("Mean Input:"),
    verbatimTextOutput("input_mu"),
    tags$p("SD Input:"),
    verbatimTextOutput("input_sd")
  ),
  
  mainPanel(
    plotOutput('plot'),
    plotOutput('ecdf')
  )
))