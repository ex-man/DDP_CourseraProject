library(shiny)

dataset <- cars #read data

shinyUI(pageWithSidebar(
  
  headerPanel("Fitting distribution to Cars data"),
  
  sidebarPanel(
    
    #Instructions
    
    
    h2('Fit the model'),
    p('Welcome to the application, that should help you in fitting Normal Distribution to data.'),
    p('Please select the data, you want to model from the dropdown (this is comes from standard cars dataset)'),
    selectInput('x', 'Data to be modelled', names(dataset)),
    h3('Model parameters'),
    p('Now you can play with the Mean and SD parameters to improve the fit (red line will be changing based on your choises)'),
    uiOutput("ui_mean"),
    uiOutput("ui_sd"),
    h3('Your choice of variables for the model'),
    tags$p("Mean Selected:"),
    verbatimTextOutput("input_mu"),
    tags$p("SD Selected:"),
    verbatimTextOutput("input_sd")
  ),
  
  mainPanel(
    h2('Use graphics to help you in choosing the parameters'),
    plotOutput('plot'),
    plotOutput('ecdf')
  )
))