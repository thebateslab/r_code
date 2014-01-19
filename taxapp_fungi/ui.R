library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("TaxApp:Fungi"),
  
  #
  sidebarPanel(
    
    textInput("theTx", "Enter Taxon", value = ""),
    br(),
    submitButton("Submit"),
    br(),
    h4("Putative Function:"),
    #br("Ectomycorrhizal"),
    textOutput("funct"),
    br()
    ),
  
  mainPanel(
    wellPanel(
    br(),
    h3("Index Fungorum:"),
    #br("k__Fungi;p_Basidiomycota;c__Agaricomycetes;o__Agaricales;f__Agaricaceae;g__Agaricus;s__Agaricus_campestris"),
    textOutput("tx1"),
    br(),
    h4("Current Name:"),
    br("Agaricus campestris"),
    #textOutput("nam1"),
    br(),
    h3("MycoBank:"),
    br("k__Fungi;p_Basidiomycota;c__Agaricomycetes;o__Agaricales;f__Agaricaceae;g__Agaricus;s__Agaricus_campestris"),
    #textOutput("tx2"),
    br(),
    h4("Current Name:"),
    br("Agaricus campestris"),
    #textOutput("nam2"),
    br()
           )

    )
))
