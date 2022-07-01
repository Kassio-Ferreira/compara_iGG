#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(readxl)
library(kableExtra)
library(tidyverse)
library(tidyr)
library(dplyr)
library(readr)


respostas_brutas <- read_excel("./tabela_respostas_brutas.xlsx")
#View(respostas_brutas)

dados <- read_excel("./iGG2021_resultados.xlsx", 
                    sheet = "iGG2021")

questionario <- read_excel("Questionario-iGG-2021.xlsx")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$orgao1_kable <- function() {
    
    req(input$orgao1)
    req(input$orgao2)
    req(input$num_questao)
    
    dados %>% filter(resp_sigla %in% c(input$orgao1)) %>% 
      dplyr::select(resp_nome, starts_with(input$num_questao) & !ends_with("X") & !ends_with("Z")) ->
      resposta_marcacoes
    
    respostas_brutas %>% filter((SIGLA_ORGAO %in% c(input$orgao1)) &
                                  NUM_QUESTAO == input$num_questao) %>% 
      dplyr::select(CAMPO_TEXTUAL) ->
      respostas_texto
    
    questionario %>% filter(substr(QUESTAO,1,4) == input$num_questao) %>%
      dplyr::select(SUBQUESTAO) -> alternativas
    
    
    data.frame(resposta_marcacoes, respostas_texto, alternativas) -> saida
    
    read.table(text = saida$SUBQUESTAO[1], sep = '\n') %>% as.data.frame() -> 
      tabela_subquestao
    
    colnames(tabela_subquestao) = c("Subquestões")
    
    # orgao 1: linhas destacadas
    
    knitr::kable(tabela_subquestao, caption=resposta_marcacoes$resp_nome[1]) %>% 
      kable_styling() %>%
      row_spec(which(resposta_marcacoes[1,3:ncol(resposta_marcacoes)] == 1), 
               bold = T, color = "white", 
               background = "red") 
    
  }
  
  output$orgao2_kable <- function() {
    
    req(input$orgao2)
    req(input$num_questao)
    
    dados %>% filter(resp_sigla %in% c(input$orgao2)) %>% 
      dplyr::select(resp_nome, starts_with(input$num_questao) & !ends_with("X") & !ends_with("Z")) ->
      resposta_marcacoes
    
    respostas_brutas %>% filter((SIGLA_ORGAO %in% c(input$orgao2)) &
                                  NUM_QUESTAO == input$num_questao) %>% 
      dplyr::select(CAMPO_TEXTUAL) ->
      respostas_texto
    
    questionario %>% filter(substr(QUESTAO,1,4) == input$num_questao) %>%
      dplyr::select(SUBQUESTAO) -> alternativas
    
    
    data.frame(resposta_marcacoes, respostas_texto, alternativas) -> saida
    
    read.table(text = saida$SUBQUESTAO[1], sep = '\n') %>% as.data.frame() -> 
      tabela_subquestao
    
    colnames(tabela_subquestao) = c("Subquestões")
    
    # orgao 1: linhas destacadas
    
    knitr::kable(tabela_subquestao, caption=resposta_marcacoes$resp_nome[1]) %>% 
      kable_styling() %>%
      row_spec(which(resposta_marcacoes[1,3:ncol(resposta_marcacoes)] == 1), 
               bold = T, color = "white", 
               background = "blue") 
    
  }
  
  output$orgao3_kable <- function() {
    
    req(input$orgao1)
    req(input$orgao2)
    req(input$num_questao)
    
    dados %>% filter(resp_sigla %in% c(input$orgao1, input$orgao2)) %>% 
      dplyr::select(resp_nome, starts_with(input$num_questao) & !ends_with("X") & !ends_with("Z")) ->
      resposta_marcacoes
    
    knitr::kable(resposta_marcacoes, caption="Notas no item") %>% 
      kable_styling()  
    
  }
  
  
})
