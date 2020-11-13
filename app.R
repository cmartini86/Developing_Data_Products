library(shiny)
setwd("C:/DevDataProd")

data <- read.csv("QB_STATS.csv", header=TRUE)
dat <- read.csv("QB_STATS.csv", header=TRUE, row.names="NAME")

server <- function(input, output) {
  
  # Fill in the spot we created for a plot
  output$statPlot <- renderPlot({
    
    par(mar=c(11,4,4,4))
    # Render a barplot
    barplot(dat[,input$stat], 
            main=input$stat,
            ylab="Amount",
            xlab="",
            names.arg=data$NAME, 
            cex.names=1,
            axis.lty=1,
            angle = 90,
            las= 2
    )
  })
}

ui <- fluidPage(    
    
    # Give the page a title
    titlePanel("Quarterback Statistics"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        selectInput("stat", "Stat:", 
                    choices=colnames(dat)),
        hr(),
        helpText("Data from 2020-2021 Season (through 5 weeks)")
      ),
      
      # Create a spot for the barplot
      mainPanel(
        plotOutput("statPlot")  
      )
      
    )
)

shinyApp(ui = ui, server = server)
