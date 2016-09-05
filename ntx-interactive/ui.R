#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel('Aedes aegypti neurotranscriptome expression data'),
  sidebarLayout(position = "right",
                sidebarPanel(
                  checkboxGroupInput("tissues", 
                                     label = h3("Tissues to plot"), 
                                     choices = list("Brain" = 'brain', 
                                                    "Antenna" = 'antenna', 
                                                    "Maxillary palp" = 'palps',
                                                    "Proboscis" = 'proboscis',
                                                    "Rostrum" = 'rostrum',
                                                    "Forelegs" = 'forelegs',
                                                    "Midlegs" = 'midlegs',
                                                    "Hindlegs" = 'hindlegs',
                                                    "Ovaries" = 'ovaries',
                                                    "Abdominal tip" = 'abdominaltip'
                                     )),
                  radioButtons("id.type", label = h3("Identifier type"),
                               choices = list("Vectorbase identifiers" = 1, "Vosshall lab identifiers" = 2),selected = 1),
                  textInput("genes", label = h3("Gene names (separated by commas)"), 
                            value = "AAEL000582"),
                  actionButton("goButton", "Go!")),
                
                mainPanel(
                  plotOutput('plot1')
                )
  )))