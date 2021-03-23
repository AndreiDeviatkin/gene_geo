# Define UI for application
ui <- navbarPage(
        "Exploring concordance between genetics and geography",
         theme = "styles.css",

        
#------------------DISTANCE PLOT TAB
         tabPanel("Gene-geo plot",
                  sidebarLayout(
                    sidebarPanel(
                      h4("Upload alignment in fasta-format"),
                      fileInput(
                        "file_alignment", "", accept = c(".fasta", ".fas")
                      ),
                      h4("Upload file with regions and coordinates in txt format 'REGION,LAT_LONG'"),
                      fileInput(
                        "file_coordinates", "", accept = c(".*")
                      ),                      
                      actionButton("goButton2", "Run"),
                      numericInput("num", 
                                   h4("Please specify number of bins at the plot (optional)"), 
                                   value = 45) 
                    ),
                    mainPanel(
                      fluidRow(
                        splitLayout(
                                cellWidths = c("100%", "100%"), 
                         tagList(h4("Gene-geo distance plot"), plotOutput("dist_plot",
                                                                  brush = brushOpts(id = "plot1_brush"),
                                                                  click = clickOpts(id = "plot1_click")
                                                                  )
                                 
                          )
                        )
                    ),
                    fluidRow(
                      #verbatimTextOutput("mm"),
                      #DT::dataTableOutput("min_max"),
                      DT::dataTableOutput("brush_info")
                    )
                  )
         )
        ),

#------------------ABOUT APP TAB
        tabPanel("About",
                   mainPanel(
                     p("The description of this app")
                   )
        )

)
