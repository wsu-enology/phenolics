require(shiny)
require(e1071)
require(httr)
require(plotly)
require(ggplot2)
require(rdrop2)
require(dplyr)
require(tools)
require(reshape2)
require(DBI)
require(DT)

source("predict.R")
source("wineries.R")
source("list.R")

shinyServer(function(input, output, session) {
  
  token <- readRDS('droptoken.rds')
  drop_auth()
  
  year <- format(Sys.time(), "%Y")
  Sys.setenv(TZ='UTC-5')
  
  users_data <- data.frame(START = Sys.time())
  
  session$onSessionEnded(function() {
    users_data$END <- Sys.time()
    write.table(x = users_data, file = file.path(getwd(), "users_data.txt"),
                append = TRUE, row.names = FALSE, col.names = FALSE, sep = "\t")
  })
  
  drop_upload('users_data.txt', path=("Users/"))
    
    output$calTable <- DT::renderDataTable(datatable(
      CalTable, rownames = F
      ))
  
  newTable <- reactive({
    
    input$refresh
    invalidateLater(1000 * 60 * 5, session)
    
    startTime <- format(Sys.time(), '%b-%d, %I:%M')
    
    temp <- tempdir()
    
    if (is.null(input$newfile)) {
      return(NULL)}
  
  newData <-read.csv(input$newfile$datapath, header = T, check.names = F)
  
  newData.df <- data.frame(input$cult,  input$tank, year, startTime, pred(newData))
  rownames(newData.df) <- NULL
  colnames(newData.df) <- c("Cultivar",  "Tank Number", "Vintage", "Prediction Date", "Anthocyanins (mg/L Malv EQ)", 
                            "Tannins (mg/L CE)", "Total Iron Reactive Phenolics (mg/L CE)")
  
  if (drop_exists(paste0("Fermentation logs", '/', year, '/',  'WSUWSC', '.csv') == TRUE)) {
    oldData <- drop_read_csv(paste0("Fermentation logs", '/', year, '/', 'WSUWSC', '.csv'), check.names = F)
    names(newData.df) <- names(oldData)
    merged <- rbind(oldData, newData.df)
    write.csv(merged, file = paste0(temp, '/', 'WSUWSC', '.csv'), row.names = FALSE, , check.names = F)
    drop_upload(paste0(temp, '/', 'WSUWSC', '.csv'),
                paste0("Fermentation logs", '/', year, '/'), overwrite = TRUE)
  } else {
    write.csv(newData.df, file = paste0(temp, '/', 'WSUWSC', '.csv'), row.names = FALSE)
    drop_upload(paste0(temp, '/', 'WSUWSC', '.csv'), paste0("Fermentation logs", '/', year, '/'))
  }
  
  if (drop_exists(paste0('Comparisons', "/", year, '/', "Washington", " ", "Yakima Valley", " ", input$cult, '.csv') == TRUE)) {
    oldStack <- drop_read_csv(paste0('Comparisons', "/", year, '/', "Washington", " ", "Yakima Valley", " ", input$cult, '.csv'))
    newStack <- drop_read_csv(paste0("Fermentation logs", '/', year, '/', "WSUWSC", '.csv'), check.names = F)
    newStack <- newStack[newStack$Cultivar == input$cult, ]
    newStack.df <- stack(newStack[,5:7])
    mergedStack <- rbind(oldStack, newStack.df)
    mergedStack.order <- mergedStack[order(mergedStack$ind), ]
    write.csv(mergedStack.order, file = paste0(temp, '/', "Washington", " ", "Yakima Valley", " ", input$cult, '.csv'), 
              row.names = FALSE)
    drop_upload(paste0(temp, '/', "Washington", " ", "Yakima Valley", " ", input$cult, '.csv'), 
                paste0("Comparisons", '/', year, '/'), overwrite = TRUE)
  } else {
    newStack <- drop_read_csv(paste0("Fermentation logs", '/', year, '/', "WSUWSC", '.csv'), check.names = F)   
    newStack <- newStack[newStack$Cultivar == input$cult, ]
    newStack.df <- stack(newStack[,5:7])
    write.csv(newStack.df, file = paste0(temp, '/', "Washington", " ", "Yakima Valley", " ", input$cult, '.csv'), 
              row.names = FALSE)
    drop_upload(paste0(temp, '/', "Washington", " ", "Yakima Valley", " ", input$cult, '.csv'), 
                paste0("Comparisons", '/', year, '/'))
  }
  
  if (drop_exists(paste0('Comparisons', "/", year, '/', "Washington", " ", input$cult, '.csv') == TRUE)) {
    oldStack <- drop_read_csv(paste0('Comparisons', "/", year, '/', "Washington", " ", input$cult, '.csv'))
    newStack <- drop_read_csv(paste0("Fermentation logs", '/', year, '/', "WSUWSC", '.csv'), check.names = F)
    newStack <- newStack[newStack$Cultivar == input$cult, ]
    newStack.df <- stack(newStack[,5:7])
    mergedStack <- rbind(oldStack, newStack.df)
    mergedStack.order <- mergedStack[order(mergedStack$ind), ]
    write.csv(mergedStack.order, file = paste0(temp, '/', "Washington", " ", input$cult, '.csv'), 
              row.names = FALSE)
    drop_upload(paste0(temp, '/', "Washington", " ", input$cult, '.csv'), 
                paste0("Comparisons", '/', year, '/'), overwrite = TRUE)
  } else {
    newStack <- drop_read_csv(paste0("Fermentation logs", '/', year, '/', "WSUWSC", '.csv'), check.names = F)
    newStack <- newStack[newStack$Cultivar == input$cult, ]
    newStack.df <- stack(newStack[,5:7])
    write.csv(newStack.df, file = paste0(temp, '/', "Washington", " ", input$cult, '.csv'), 
              row.names = FALSE)
    drop_upload(paste0(temp, '/', "Washington", " ",input$cult, '.csv'), 
                paste0("Comparisons", '/', year, '/'))
  }
  
  if (drop_exists(paste0('Comparisons', "/", year, '/', input$cult, '.csv') == TRUE)) {
    oldStack <- drop_read_csv(paste0('Comparisons', "/", year, '/', input$cult, '.csv'))
    newStack <- drop_read_csv(paste0("Fermentation logs", '/', year, '/', "WSUWSC", '.csv'), check.names = F)
    newStack <- newStack[newStack$Cultivar == input$cult, ]
    newStack.df <- stack(newStack[,5:7])
    mergedStack <- rbind(oldStack, newStack.df)
    mergedStack.order <- mergedStack[order(mergedStack$ind), ]
    write.csv(mergedStack.order, file = paste0(temp, '/', input$cult, '.csv'), 
              row.names = FALSE)
    drop_upload(paste0(temp, '/', input$cult, '.csv'), 
                paste0("Comparisons", '/', year, '/'), overwrite = TRUE)
  } else {
    newStack <- drop_read_csv(paste0("Fermentation logs", '/', year, '/', "WSUWSC", '.csv'), check.names = F)
    newStack <- newStack[newStack$Cultivar == input$cult, ]
    newStack.df <- stack(newStack[,5:7])
    write.csv(newStack.df, file = paste0(temp, '/', input$cult, '.csv'), 
              row.names = FALSE)
    drop_upload(paste0(temp, '/', input$cult, '.csv'), 
                paste0("Comparisons", '/', year, '/'))
  }
  
  pred(newData)
  })
  
  output$table <- DT::renderDataTable({
    
    validate(
      need(input$cult != "", "Please Select a Cultivar or Blend"),
      need(input$tank != "", "Please Select a Tank")
    )
    datatable(newTable(), rownames = T)
  })
  
  historyTable <- reactive({
    
    input$refresh
    invalidateLater(1000 * 60 * 5, session)
    
    history <- drop_read_csv(paste0('Fermentation logs', '/', input$vintage, "/", "WSUWSC", '.csv'))
    dataHistory <- data.frame(history)
    dataHistory1 <- dataHistory[,1:4]
    dataHistory2 <- dataHistory[,5:7]
    dataHistory3 <- data.frame(format(dataHistory2, nsmall = 1))
    dataHistoryFinal <- cbind(dataHistory1, dataHistory3)
    colnames(dataHistoryFinal) <- c("Cultivar",  "Tank Number", "Vintage", "Prediction Date", "Anthocyanins (mg/L Malv EQ)", "Tannins (mg/L CE)", "Total Iron Reactive Phenolics (mg/L CE)")
    
    dataHistoryFinal
  })
  
  output$table1 <- renderDataTable({
    validate(
      need(input$vintage != '', 'Please Select a Vintage')
    )
    datatable(historyTable(), rownames = F)
  })
  
  output$download <- downloadHandler(
      filename = function() { paste0("WSUWSC", " ", "phenolics",  " ", year, " ", "tank = ", " ",input$tank1, '.csv') },
    content = function(file) {
      write.csv(historyTable(), file, row.names = FALSE)
    }
  )
  
  compareRegion <- reactive({
    
    input$refresh
    invalidateLater(1000 * 60 * 5, session)
    
    ph_region <- drop_read_csv(paste0('Comparisons', '/', input$vintage1, '/', input$country1, " ", input$region1,  " ", input$cult1, '.csv'))
    
    ph_region.dens <- density(ph_region$values)
    ph_region.conc <- ph_region.dens$x
    ph_region.min <- min(ph_region.conc)
    ph_region.max <- max(ph_region.conc)
    
    ph_region.plotMaster <- ggplot(data=ph_region, aes(x=values, fill =ind)) + geom_density(alpha=0.5, aes(y=(..count..))) + 
      theme_linedraw() + theme(axis.line = element_line(colour = "black"), panel.grid.major = element_blank(),  legend.title=element_blank(),
                               panel.grid.minor = element_blank())  + labs(x = "Concentration (mg/L)", y="Count") + scale_fill_manual(
                                 values = c("firebrick4", "gold2", "dodgerblue")) + xlim(ph_region.min, ph_region.max)
    
    ggplotly(ph_region.plotMaster, tooltip = c(1, 2))
    
  })
  
  output$plot1 <- renderPlotly  ({
    validate(
      need(input$country1 != '', "Please Select a State or Country"),
      need(input$region1 != '', "Please Select an AVA or Region"),
      need(input$cult1 != '', "Please Select a Cultivar or Blend"),
      need(input$vintage1 != '', "Please Select a Vintage")
      
    )
    compareRegion()
  })
  
  compareCountry <- reactive({
    
    input$refresh
    invalidateLater(1000 * 60 * 5, session)
    
    ph_country <- drop_read_csv(paste0('Comparisons', '/', input$vintage2, '/', input$country2, " ", input$cult2, '.csv'))
    
    ph_country.dens <- density(ph_country$values)
    ph_country.conc <- ph_country.dens$x
    ph_country.min <- min(ph_country.conc)
    ph_country.max <- max(ph_country.conc)
    
    ph_country.plotMaster <- ggplot(data=ph_country, aes(x=values, fill =ind)) + geom_density(alpha=0.5, aes(y=(..count..))) + 
      theme_linedraw() + theme(axis.line = element_line(colour = "black"), panel.grid.major = element_blank(),  legend.title=element_blank(),
                               panel.grid.minor = element_blank())  + labs(x = "Concentration (mg/L)", y="Count") + scale_fill_manual(
                                 values = c("firebrick4", "gold2", "dodgerblue")) + xlim(ph_country.min, ph_country.max)
    
    ggplotly(ph_country.plotMaster, tooltip = c(1,2))
    
  })
  
  output$plot2 <- renderPlotly  ({
    validate(
      need(input$country2 != '', "Please Select a State or Country"),
      need(input$cult2 != '', "Please Select a Cultivar or Blend"),
      need(input$vintage2 != '', "Please Select a Vintage")
      
    )
    compareCountry()
  })
  
  compareWorld <- reactive({
    
    input$refresh
    invalidateLater(1000 * 60 * 5, session)
    
    ph_world <- drop_read_csv(paste0('Comparisons', '/', input$vintage3, '/', input$cult3, '.csv'))
    
    ph_world.dens <- density(ph_world$values)
    ph_world.conc <- ph_world.dens$x
    ph_world.min <- min(ph_world.conc)
    ph_world.max <- max(ph_world.conc)
    
    ph_world.plotMaster <- ggplot(data=ph_world, aes(x=values, fill=ind)) + geom_density(alpha=0.5, aes(y=(..count..))) + 
      theme_linedraw() + theme(axis.line = element_line(colour = "black"), panel.grid.major = element_blank(),  legend.title=element_blank(),
                               panel.grid.minor = element_blank())  + labs(x = "Concentration (mg/L)", y="Count") + scale_fill_manual(
                                 values = c("firebrick4", "gold2", "dodgerblue")) + xlim(ph_world.min, ph_world.max)
    
    ggplotly(ph_world.plotMaster, tooltip = c(1,2))
    
  })
  
  output$plot3 <- renderPlotly  ({
    validate(
      need(input$cult3 != '', "Please Select a Cultivar or Blend"),
      need(input$vintage3 != '', "Please Select a Vintage")
      
    )
    compareWorld()
  })
  
})
  