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
shinyUI(
  
  fluidPage(
    
    # Application title
    titlePanel("Selecione o item e os órgãos:"),
    
    sidebarLayout(
      sidebarPanel(width=2,
                   textInput("num_questao", "Questão", value = "1111"),
                   textInput("orgao1", "Órgão 1 - Sigla", value = "UFERSA"),
                   textInput("orgao2", "Órgão 2 - Sigla", value = "UFRN")
      ),
      
      mainPanel(
        fluidRow(
          tableOutput("orgao1_kable"), 
          tableOutput("orgao2_kable"),
          tableOutput("orgao3_kable")
        )
        
      )
    )
  )
  
)
