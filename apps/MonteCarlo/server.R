source("global.R")
set.seed(NULL)
# ANOVA Server
shinyServer(function(input, output, session){
    output$random_parameter <- renderUI({
      textInput("rolling_dice_sum", label = h5("Expected sum"), value=8)
        })
    
    observeEvent(input$disconnect, {
        session$close()
    })
    
})