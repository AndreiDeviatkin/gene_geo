# Define UI for application
ui <- navbarPage(
        "Exploring concordance between genetic and geographic distances",
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
                      
                         tagList(h4("Gene-geo distance plot"), plotOutput("dist_plot",
                                                                          height = "700px",
                                                                          width  = "700px",
                                                                  brush = brushOpts(id = "plot1_brush"),
                                                                  click = clickOpts(id = "plot1_click")
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
        tabPanel("About application using",
                   mainPanel(
                      p("
                        For citation please use this paper:
                       "),
                      p("
                      UNDER REVISION
                       "),
                     p("
                        This application is implemented on the shinyapps.io platform for demonstration of its possibilities. However, free plan on this platform has some computational limitations.
                       "),
                     p("
                       To run this application on personal computer please complete the following steps:
                       "),
                     p("
                       1. Install R  (Version 4.0 or above). 
                       "),
                     a("
                     https://cran.r-project.org/bin/windows/base/
                     "),
                     p("
                       2. Install Rstudio. 
                                             "),
                     a("
                      https://www.rstudio.com/products/rstudio/
                     "),
                     p("
                     3. Download all files from 
                     "),
                     a("
                      https://github.com/AndreiDeviatkin/gene_geo
                               "),
                     p("
                       into separate folder. 
                      "),                     
                      p("
                       Open in Rstudio 'packages_installation.R' -> select all lines -> click on 'Run' button at topright corner of the console. Packages needed for the application running will be installed.
                      "),
                     p("
                        
                       Open in Rstudio 'ui.R' -> click on 'Run App' button at topright corner of the console. 
                       Application will begin to process your task.
                      "),
                     p("
                       If you have any problems while using 'Gene-geo' please don't hesistate to contact with me,
                       "),
                     a("
                       andreideviatkin@gmail.com
                      "),
                     p("
                       kind regards,
                       "),
                     p("
                       Andrei
                       ")
                   )
        ),
tabPanel("About data format",
         mainPanel(
                 p("
                       This application needs two files:
                       "),
                 p("
                     1. fasta alignment
                       "),
                 p("
                        fasta descriptor (symbols after '>') must contain information about place of virus collection
                       "),
                 p("
                       separator in fasta descriptor should be '_'
                       "),
                 p("
                    place of virus collection should be located at the last place   
                       "),
                 p("
                       Fasta descriptor example: '>AY352458_isolate_857r_country_Russia-Khabarovsk'
                                             "),
                  p("
                       Fasta file example: 
                     "),
                 a("

https://raw.githubusercontent.com/AndreiDeviatkin/gene_geo/main/data/fasta/arctic-like_geo_natural.fas            
                   
                   "),
                 p("
                    2.   text file with coordinates of used regions
                      "),
                 p("
                       One line example: REGION,LAT_LONG
                       "),
                 p("
                       File example:
                       "),
                 a("
https://raw.githubusercontent.com/AndreiDeviatkin/gene_geo/main/data/regions_coordinates/regions_coord.txt                   
                   
                   "),

         )
)
)
