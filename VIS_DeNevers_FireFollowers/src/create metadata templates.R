#EMLasseblyline templates
#April 29, 2018

#___Step 1_____setup
#load library and set working directory
library(EMLassemblyline)
setwd("C:/Users/cdodge/Desktop/GIT/EML/VIS_DeNevers_FireFollowers")
#You can examine library functions by typing"EMLassemblyline::"

#___Step 2_____generate templates
import_templates("C:/Users/cdodge/Desktop/GIT/EML/VIS_DeNevers_FireFollowers", 
                 "CCBY", 
                 data.files = c("siteAttributes.csv", 
                                "species.csv", 
                                "surveyRoutes.csv", 
                                "fireFollowerTransects.csv"))

#___Step (not in R)_____populate those templates!
  