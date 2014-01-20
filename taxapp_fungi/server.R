library(shiny)
library(datasets)
library(RCurl)

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
 
  observe({
  get_data <- function(txt){
    the_url <- "http://www.indexfungorum.org/ixfwebservice/fungus.asmx/NameSearchDs?SearchText="
    the_url <- paste(the_url, txt, "&AnywhereInText=FALSE&MaxNumber=10", sep="")
    tax_file <- getURL(the_url)
    
   # err_rep <- grep(GENUS, tax_file)
   # err_rep_l <- length(err_rep)
    
   # if (err_rep_l > 0){
      tax_file <- gsub("\"", ";", tax_file)
      tax_file <- gsub(";:", ":", tax_file)
      tax_file <- gsub(":;", ":", tax_file)
      tax_file <- gsub(",;", ";", tax_file)
      tax_file <- gsub(";;", ";", tax_file)
      tax_file <- gsub(";key", "key", tax_file)
      tax_file <- strsplit(tax_file,";")
      tax_file <- tax_file[[1]]
      print(tax_file)
    #}else taxa_file <- "Not Found"
                     }
  output$tx1 <- renderText({get_data(input$theTx)})

  })
  
})
