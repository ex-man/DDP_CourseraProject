library(shiny)

shinyServer(function(input, output) {
  
  dataset <- cars #read data
  
  my_mean <- reactive(function() {
    mean(dataset[,input$x])
  })
  my_sd <- reactive(function() {
    sd(dataset[,input$x])
  })
  
  #dynamic UI 1
  output$ui_mean <- renderUI({
    if (is.null(input$x))
      return()
    
    # Depending on input$input_type, we'll generate a different
    # UI component and send it to the client.
    sliderInput('mu', 'Mean',
                min=round(my_mean()-my_sd(),0),
                max=round(my_mean()+my_sd(),),
                value=my_mean(), step=1, round=0)
  })
  #dynamic UI 2
  output$ui_sd <- renderUI({
    if (is.null(input$x))
      return()
    
    # Depending on input$input_type, we'll generate a different
    # UI component and send it to the client.
    
   sliderInput('sd', 'Standard Deviation',
                       min=round(my_sd()/2,0),
                       max=round(my_sd()*2,0),
                       value=my_sd(), step=1, round=0)

  })
  
  output$plot <- reactivePlot(function() {
    
    data<-dataset[,input$x]
    
    p <- hist(data
              , prob=TRUE
              , main=paste('Fitting normal distribution to', input$x)
              , xlab=input$x
              )
    my_x<-seq(min(data),max(data),1)
    lines(dnorm(my_x,mean=input$mu,sd=input$sd),col="red")
    
    print(p)
    
  }, height=300)
  
  output$ecdf <- reactivePlot(function() {
    
    data<-dataset[,input$x]
    
    p <- plot(ecdf(data)
              , main=paste('Distribution function vs. ECDF of', input$x)
              , xlab=input$x
              , ylab='Probability'
              )
    my_x<-seq(min(data),max(data),1)
    lines(pnorm(my_x,mean=input$mu,sd=input$sd),col="red")
    
    print(p)
    
  }, height=300)
  
  output$input_mu <- renderText({
    input$mu
  })
  
  output$input_sd <- renderText({
    input$sd
  })
  
})