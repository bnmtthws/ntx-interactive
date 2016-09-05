#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(reshape2)
library(plyr)

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

shinyServer(function(input, output, session) {

  
  output$plot1 <- renderPlot({
    
    if (input$goButton == 0)
      return()
    
    isolate({
      if(input$id.type == 1) {
        p <- plotData(input$genes,input$tissues)
      }
      
      if(input$id.type == 2) {
        p <- plotDataRU(input$genes,input$tissues)
      }
      
      print(p)
    })
    
  })
  
})