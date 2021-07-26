For citation please use this paper:

UNDER REVISION

This application is implemented on the shinyapps.io platform for demonstration of its possibilities. However, free plan on this platform has some computational limitations.

To run this application on personal computer please complete the following steps:

1. Install R (Version 4.0 or above)

https://cran.r-project.org/bin/windows/base/
2. Install Rstudio.

https://www.rstudio.com/products/rstudio/
3. Download all files from

https://github.com/AndreiDeviatkin/gene_geo
into separate folder. Open Open the file 'ui.R' in Rstudio -> click on 'Run App' button at topright corner of the console. The application will begin to process your task.

If you have any problems while using 'Gene-geo' please don't hesitate to contact me,

andreideviatkin@gmail.com
kind regards,

Andrei

#########################################################
This application needs two files:

1. Fasta alignment

Fasta descriptor (symbols after '>') must contain information about place of virus collection

Separator in fasta descriptor should be '_'

Place of virus collection should be located at the last place

Fasta descriptor example: '>AY352458_isolate_857r_country_Russia-Khabarovsk'

Fasta file example:

https://raw.githubusercontent.com/AndreiDeviatkin/gene_geo/main/data/fasta/arctic-like_geo_natural.fas
2. text file with coordinates of geographic regions

One line example: REGION,LAT_LONG

File example:

https://raw.githubusercontent.com/AndreiDeviatkin/gene_geo/main/data/regions_coordinates/regions_coord.txt
