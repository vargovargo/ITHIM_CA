library(shiny)
library(tidyverse)


devtools::install_github("syounkin/ITHIM", ref="devel")
library("ITHIM")

PAexample <- read.csv("https://raw.githubusercontent.com/ITHIM/ITHIM/devel/inst/activeTransportTime.csv", header=T)

ui <- shinyUI(pageWithSidebar(
headerPanel("ITHIM Physical Activity Module Demo"),
sidebarPanel(
  # Upload PA Data
  fileInput('file1', 'Choose PhysActivity File (csv)',
            accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
  
  # Download Button
  downloadButton("downloadPAexample", "Download Sample Transport Times")
  
  
),
mainPanel(
  tableOutput('contents')
  )
))


server <- function(input, output, session) {
  
  output$contents <- renderTable({
  # input$file1 will be NULL initially. After the user selects
  # and uploads a file, it will be a data frame with 'name',
  # 'size', 'type', and 'datapath' columns. The 'datapath'
  # column will contain the local filenames where the data can
  # be found.
  
  inFilePA <- input$file1
  
  if (is.null(inFilePA))
    return(NULL)
  
  read.csv(inFilePA$datapath, header = T, sep=",")
  })
  
  
  # Downloadable csv of selected dataset ----
  output$downloadPAexample <- downloadHandler(
    filename = "ActiveTransportTime.csv",
    content = function(file) {
      write.csv(PAexample, file, row.names = FALSE)
    }
  )
  
  
}




shinyApp(server = server, ui = ui)
