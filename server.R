library(shiny)
library(DT)
library(shinyjs)
library(shinycssloaders)
library(shinythemes)
library(ape)
library(otuSummary)
library(ggplot2)
library(geosphere)
library(scales)

options(shiny.maxRequestSize = 922*1024^2)
server <- function(input, output) {
  
# ---------DISTANCE PLOT GO BUTTON  
  
  observeEvent(
    input$goButton2, {

      if (! is.null(input$file_alignment$datapath)){
        file = input$file_alignment$datapath
      } 
      if (! is.null(input$file_coordinates$datapath)){
        file2 = input$file_coordinates$datapath
      } 
      bin_number = input$num
      
      withProgress(message = "fasta file was read", value = 0, {

      aln = read.dna(file, format="fasta" )
      
      Sys.sleep(0.5)
      
})

      withProgress(message = "genetic distances are calculated", value = 0, {
        

            st1=1
      e1=length(aln[1,])
      
      
      dna_sl1=aln[1:nrow(aln), seq(from = st1, to = e1, by=1)]
      dist_sl1 = dist.gene(dna_sl1, method = "percentage",  pairwise.deletion = TRUE)
      dist1 <- matrixConvert(dist_sl1, colname = c("sp1", "sp2", "distance")) 
      dist2=cbind (sub(".*_", "", dist1[,1]), sub(".*_", "", dist1[,2]), dist1[,3], 
                   sub("_____", "", dist1[,1]),sub("_____", "", dist1[,2])) #strange code ( sub("NO PATTERN", "", dist1[,1] preserves id)

      Sys.sleep(0.5)
      })

      withProgress(message = "coordinates are parsed", value = 0, {
        
      df=read.table(file2, sep=",", header= F) ;  
      key=df[,1]
      val=df[,2]
      
      lapply(1:length(key),FUN = function(i){dist2[dist2 == key[i]] <<- val[i]})
      dist3=dist2
      colnames(dist3)=c("latlong1", "latlong2", "gendist","id2","id1") 
      df=as.data.frame(dist3)
      rm(dist1,dist2,dist3, aln, dist_sl1, dna_sl1, e1, st1, key, val)

      Sys.sleep(0.5)
      })
      
      withProgress(message = "geographic distances are calculated", value = 0, {
        
      
      df$gendist100=100*as.numeric(df$gendist)
      

      
      df$long1 <- as.numeric(lapply(strsplit(as.character(df$latlong1), "\\_"), "[", 2))
      df$lat1 <- as.numeric(lapply(strsplit(as.character(df$latlong1), "\\_"), "[", 1))
      df$long2 <- as.numeric(lapply(strsplit(as.character(df$latlong2), "\\_"), "[", 2))
      df$lat2 <- as.numeric(lapply(strsplit(as.character(df$latlong2), "\\_"), "[", 1))
      
      p1=cbind(df$long1,df$lat1)
      p2=cbind(df$long2,df$lat2)
      
      df$geodist=distGeo(p1, p2, a=6378137, f=1/298.257223563)/1000
      

      df$gendist=NULL
      df$latlong1=NULL
      df$latlong2=NULL
      df$long1=NULL
      df$lat1=NULL
      df$long2=NULL
      df$lat2=NULL

    
      geo_vector=as.vector(df$geodist)
      gen_vector=as.vector(df$gendist)
    
      
      df2=data.frame(geo_vector, gen_vector)
      
      
      Sys.sleep(0.5)
      })
      withProgress(message = "gene-geo plots are created", value = 0, {
        
      plot1=ggplot (
        df2,aes(geo_vector,gen_vector)
      )+
        geom_bin2d(bins=bin_number)+ 
        scale_fill_gradientn(colours=c("blue","red"),trans = "log10")+ 
        theme(legend.justification=c(1,0))+
        labs(fill = "count")+ 
        xlab("geographical distance, km")+ylab("evolutionary distance, %")+
        scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0), breaks= pretty_breaks())+
        theme(
          panel.background = element_rect(fill = "grey75", colour = "grey50"),
          axis.line = element_line(colour = "black", size = 2),
          axis.title.x = element_text( size = 20, angle = 0, hjust = .5, vjust = 2, face = "plain"),
          axis.title.y = element_text( size = 20, angle = 90, hjust = .5, vjust = 0, face = "plain"),
          axis.text.x = element_text(color = "black", size = 15,  hjust = .5, vjust = .5, face = "plain"),
          axis.text.y = element_text(color = "black", size = 15,  hjust = .5, vjust = .5, face = "plain"),
          axis.ticks.length=unit(.25, "cm"),
          plot.background=element_rect(fill="grey100")
        )
      
      
      output$dist_plot <- renderPlot(plot1)
      Sys.sleep(0.5)
      }
      )
      
      observeEvent(input$plot1_brush, {
        brushed_points <- brushedPoints(df2, input$plot1_brush)
        min_1 = input$plot1_brush$xmin
        max_1 = input$plot1_brush$xmax
        
        min_2 = input$plot1_brush$ymin
        max_2 = input$plot1_brush$ymax
        
        output$min_max <- DT::renderDataTable(brushed_points)
        
        output$brush_info <- DT::renderDataTable({
 
          df2=df[as.numeric(df$geodist) >= min_1,] 
          df3=df2[as.numeric(df2$geodist) <= max_1,] 
          df4=df3[as.numeric(df3$gendist100) >= min_2,] 
          df5=df4[as.numeric(df4$gendist100) <= max_2,]
          df5=df5[rowSums(is.na(df5)) == 0,]
          rownames(df5) <- NULL
          names(df5)[names(df5) == 'gendist100'] <- 'gendist, %' 
          names(df5)[names(df5) == 'geodist'] <- 'geodist, km' 
          df5

        }, options = list(pageLength = 200))
        
      })
      
      
      
    }
  )
  
}
