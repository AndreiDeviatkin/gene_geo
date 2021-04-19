##########

about application using
##########

online version is available at:
https://andreideviatkin.shinyapps.io/gene-geo/
##########


For citation please use this paper:

UNDER REVISION

This application is implemented at shinyapps.io platform for demonstration of its possibilities. However, free plan at this platform has some computational limitations.

The same application can be run in a usual computer after completing three steps:

1. Install R.

https://cran.r-project.org/bin/windows/base/

2. Install Rstudio.

https://www.rstudio.com/products/rstudio/

3. Download all files from

https://github.com/AndreiDeviatkin/gene_geo
into separate folder. Open in Rstudio 'ui.R' -> click on 'Run App' button at topright corner of the console. Application will begin to process your task.

If you have any problems while using 'Gene-geo' please don't hesistate to contact with me,

andreideviatkin@gmail.com
have a nice everything,

Andrei

###########

about data format
###########

This application needs two files:

1. fasta alignment

fasta descriptor (symbols after '>') must contain information about place of virus collection

separator in fasta descriptor should be '_'

place of virus collection should be located at the last place

Fasta descriptor example: '>AY352458_isolate_857r_country_Russia-Khabarovsk'

Fasta file example:

https://raw.githubusercontent.com/AndreiDeviatkin/gene_geo/main/data/fasta/arctic-like_geo_natural.fas
2. text file with coordinates of used regions

One line example: REGION,LAT_LONG

File example:

https://raw.githubusercontent.com/AndreiDeviatkin/gene_geo/main/data/regions_coordinates/regions_coord.txt
