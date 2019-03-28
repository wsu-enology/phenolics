require(shiny)
require(plotly)
require(rdrop2)
require(dplyr)
require(tools)
require(DBI)
require(DT)
require(shinyjs)

source("list.R")
source("wineries.R")

shinyUI(fluidPage(theme = "bootstrap.css",
                  title = "Phenolics Gateway WSUWSC",
                  navbarPage(position = 'static-top', img(src = "WSU-VE.png", height = "100px", width = "280px", style = " margin-left: 25px; 
                             margin-right: 160px; margin-top: -5px;"), 
                             tabPanel(h3("Predict Phenolics"),
                                      tabsetPanel(
                                        tabPanel(h4('Make a new Prediciton'),
                                                 sidebarLayout(
                                                   sidebarPanel(style = "background-color: #262b2e; color: #ffffff",
                                                                selectizeInput('cult', 'Select a Cultivar or Blend',
                                                                               choices = c(cultivarMaster, options = list(
                                                                                 placeholder = ' ',
                                                                                 onInitialize = I('function() { this.setValue(""); }')
                                                                               )
                                                                )),
                                                                  selectizeInput('tank', 'Select a Tank',
                                                                                 choices = tank,  options = list(
                                                                                   placeholder = ' ',
                                                                                   onInitialize = I('function() { this.setValue(""); }')
                                                                                 )
                                                                  ),
                                                                tags$head(tags$style(".progress-bar{background-color:#660000;}")),
                                                                tags$head(tags$style(".btn{background-color:#660000;}")),
                                                                tags$head(tags$style(".btn:hover{background-color:#34000d;}")),
                                                                  fileInput("newfile", "Upload spectra",
                                                                            accept = c(
                                                                              "text/csv",
                                                                              "text/comma-separated-values",
                                                                              "text/tab-separated-values",
                                                                              "text/plain",
                                                                              ".xlsx",
                                                                              ".csv",
                                                                              ".tsv")
                                                                  ),
                                                                tags$head(
                                                                  tags$style(".predictNew{background-color:#660000;}
                                                                             .predictNew{color: white;}
                                                                             .predictNew{border: none;}
                                                                             .predictNew:hover{background-color: #34000d;}")
                                                                )),
                                                   mainPanel(
                                                     tabPanel(' ', DT::dataTableOutput('table'))
                                                   )
                                                 )),
                                        tabPanel(h4('Fermentation History'),
                                                 sidebarLayout(
                                                   sidebarPanel(style = "background-color: #262b2e; color: #ffffff",
                                                                selectizeInput('vintage', 'Select a vintage',
                                                                               choices = vintage, options = list(
                                                                                 placeholder = ' ',
                                                                                 onInitialize = I('function() { this.setValue(""); }')
                                                                               )
                                                                ),
                                                                downloadButton('download', 'Save vintage history', class = 'mybutton'),
                                                                tags$head(
                                                                  tags$style(".mybutton{background-color:#660000;}
                                                                             .mybutton{color: white;}
                                                                             .mybutton{border: none;}
                                                                             .mybutton:hover{background-color: #34000d;}")
                                                                )),
                                                   mainPanel(
                                                     tabPanel(' ', DT::dataTableOutput('table1'))
                                                   )))
                                        )
                                      ),
                             tabPanel(h3("Compare Phenolics"),
                                      tabsetPanel(
                                        tabPanel(h4('Region/AVA Comparison'),
                                                 sidebarLayout(
                                                   sidebarPanel(style = "background-color: #262b2e; color: #ffffff",
                                                                selectizeInput('country1', 'Select a state or country',
                                                                               choices = country, options = list(
                                                                                 placeholder = ' ',
                                                                                 onInitialize = I('function() { this.setValue(""); }')
                                                                               )
                                                                ),
                                                                selectizeInput('region1', 'Select a AVA or region',
                                                                               choices = regionMaster, options = list(
                                                                                 placeholder = ' ',
                                                                                 onInitialize = I('function() { this.setValue(""); }')
                                                                               )
                                                                ),
                                                                selectizeInput("cult1", "Select cultivar or blend",
                                                                               choices = cultivarMaster, options = list(
                                                                                 placeholder = ' ',
                                                                                 onInitialize = I('function() { this.setValue(""); }')
                                                                               )
                                                                ),
                                                                selectizeInput("vintage1", "Select Vintage",
                                                                               choices = vintage,  options = list(
                                                                                 placeholder = ' ',
                                                                                 onInitialize = I('function() { this.setValue(""); }')
                                                                               )
                                                                ),
                                                                tags$head(
                                                                  tags$style(".compareRegion{background-color:#660000;}
                                                                             .compareRegion{color: white;}
                                                                             .compareRegion{border: none;}
                                                                             .compareRegion:hover{background-color: #34000d;}")
                                                                  )                                                                ),
                                                   mainPanel(
                                                     tabPanel(" ", plotlyOutput("plot1"))
                                                   )
                                                   )
                                        ),
                                        tabPanel(h4('State/Country Comparison'),
                                                 sidebarLayout(
                                                   sidebarPanel(style = "background-color: #262b2e; color: #ffffff",
                                                                selectizeInput('country2', 'Select a state or country',
                                                                               choices = country, options = list(
                                                                                 placeholder = ' ',
                                                                                 onInitialize = I('function() { this.setValue(""); }')
                                                                               )
                                                                ),
                                                                selectizeInput("cult2", "Select cultivar or blend",
                                                                               choices = cultivarMaster, options = list(
                                                                                 placeholder = ' ',
                                                                                 onInitialize = I('function() { this.setValue(""); }')
                                                                               )
                                                                ),
                                                                selectizeInput("vintage2", "Select Vintage",
                                                                               choices = vintage,  options = list(
                                                                                 placeholder = ' ',
                                                                                 onInitialize = I('function() { this.setValue(""); }')
                                                                               )
                                                                ),
                                                                tags$head(
                                                                  tags$style(".compareCountry{background-color:#660000;}
                                                                             .compareCountry{color: white;}
                                                                             .compareCountry{border: none;}
                                                                             .compareCountry:hover{background-color: #34000d;}")
                                                                  )                                                                ),
                                                   mainPanel(
                                                     tabPanel(' ', plotlyOutput(('plot2')))
                                                   )
                                                   )
                                        ),
                                        tabPanel(h4('Global Comparison'),
                                                 sidebarLayout(
                                                   sidebarPanel(style = "background-color: #262b2e; color: #ffffff",
                                                                selectizeInput('cult3', 'Select cultivar or blend',
                                                                               choices =  cultivarMaster, options = list(
                                                                                 placeholder = ' ',
                                                                                 onInitialize = I('function() { this.setValue(""); }')
                                                                               )
                                                                ),
                                                                selectizeInput('vintage3', 'Select Vintage',
                                                                               choices = vintage,  options = list(
                                                                                 placeholder = ' ',
                                                                                 onInitialize = I('function() { this.setValue(""); }')
                                                                               )
                                                                ),
                                                                tags$head(
                                                                  tags$style(".compareWorld{background-color:#660000;}
                                                                             .compareWorld{color: white;}
                                                                             .compareWorld{border: none;}
                                                                             .compareWorld:hover{background-color: #34000d;}")
                                                                )                                                   ),
                                                   mainPanel(
                                                     tabPanel(' ', plotlyOutput(('plot3')))
                                                   )
                                                 )
                                        )
                                      )
                             ),
                             tabPanel(h3("Sample Dilution"),
                                      tabsetPanel(
                                        tabPanel(h4('Recommended Sample Dilution'),
                                                 mainPanel(
                                                   tabPanel(' ', DT::dataTableOutput('calTable'))
                                                 )
                                        )
                                      )
                             )
                  )
))




