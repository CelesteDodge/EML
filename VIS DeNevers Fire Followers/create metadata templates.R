#EMLasseblyline templates
#March 27, 2018

#___Step 1_____setup
#load library and set working directory
library(EMLassemblyline)
setwd("S:/Pepperwood/RPM PROGRAM MANAGEMENT/Data Management/EML Metadata/templates")
#You can examine library functions by typing"EMLassemblyline::"

#___Step 2_____generate templates
import_templates("S:/Pepperwood/RPM PROGRAM MANAGEMENT/Data Management/EML Metadata/templates", "CCBY", data.files = c("table1", "table2"))

#___Step (not in R)_____populate those templates!
  