#Date:11/15/2017
#Author: Celeste Dodge
#Purpose: use the new 'EMLAssemblyline' package to create EMl using the EDI templates
 #Dataset is the BBS
#Requirements: 
 #Prefix data file names with project name/code followed by word(s) descriptive of content
 #For detailed instructions type '?view_instrctions()'
#New tricks: Type '?' before a command to get documentiaton. 
 #R cannot interpet spaces in file names.
#improvements to package
 #within template files a description of content requirements fo rtab delimited files would help (maybe a line 1 that says 'erase this line. Instuctions to fill template are as follows...')
 #how can new users tell the difference between text delimited files versus plain text files since all are .txt
 #standard units - unit number 132 (are) maybe should be acre?
 #EDI template/personnel: should list preffered roles other than PI (creator, contact)
 #apparently required to include project for pi roles (good to communicate in documentation)
 #it is not clear what step the attributes table is pulled into EML. If we goof then fix error, how does one reload or redefine attributes
 #Intellectual rights: do or do not edit text?

#____Step 1_______clear workspace and set working directory where data and metadata files are______________
rm(list=(ls))
setwd("C:/Users/IT Lab/Desktop/CDodge")


#____Step 2_______Install and load packages______________
install.packages("devtools")  #devtools allow access to library in Git Repository and others
library(devtools)

install_github("EDIorg/EMLassemblyline")
library(EMLassemblyline)

#____Step 3_______Take a look at the instructions to walk through interactive steps
view_instructions()


#____Step 3.1_______import templates______________
  #Enter file path first, then the desired prefix for all the files which will be sent to the directory
import_templates("C:/Users/IT Lab/Desktop/CDodge", "BBS_RawDatabase")


#____Step 3.2_______Continue viewing/following instructions for the following elements______________
 #______
 #abstract: delete prompt. Enter text content 
 #______
 #additional info: good to include other pulications or internal use. Not required. 
 #______
 #intellectual rights: delete unneeded file, edit retained text file as necessary
 #change name of file to be DataSetPrefix_intellectual_rights
 #______
 #Keywords: tab delimted - keep headers. 
    #Each keyword on a new line, followed by a tab then the source vocab for keyword
    #Be as specific (as far down the LTER controleld vocabulary tree as possible)
 #______
 #methods: delete prompt. Enter text content
 #______
 #personnel: tab delimted - keep headers
   #must include project for pi roles
   #set roles can be: contact, creator or pi (case sensitive). Or any other made up role.
   #suggestion for longevity: include research team as a contact with research@pepperwoodpreserve.org
 

#____Step 4_______Describe the data table(s)______________
#Each data table has it's own attribute file 
  #will have a prefix of project name/code followed by same word(s) descriptive of data content in data file

#attributes: tab delimted - keep headers.

  #classes are case sensitive Date, categorical, character or numeric
    #Date: have dateTime format string, all others empty cells
    #numeric: have units, all others empty cells
        #view standard units table below
#use these standard units only or create a table for special units
standardUnits <- get_unitList()
View(standardUnits$units)

#missing value codes must have missing value explanations

#____Step 4.1_______Describe categortical (factor) variables______________
#create catvars tabel from attributes and data table
define_catvars(path= "C:/Users/IT Lab/Desktop/CDodge")

#_______________________________________
#___trouble shooting specific to BBS data
#
#merge existing factors definitions table with new catvars table
CV<-read.csv("BBS_RawDatabase_pointCounts_catvars.txt", sep="\t")
factors<- read.csv("BBS_Raw_Factors _2017-11-15_2.csv", sep=",")
#examine and change header so a key matches
head(CV)
head(factors)
#merge tables
newCatvars<- merge(CV,factors,by="code")
write.csv(newCatvars,file = "newCatvars", sep = "\t")
#___________________________________________

#skipping extract geocoverage for now and opting to upload a Sites table instead
?extract_geocoverage()

make_eml(path= "C:/Users/IT Lab/Desktop/CDodge")


#__________________________________________________
#
#note you will need to create a check sum value for the data set manually and enter that into EML
#
#To calculate MD5 checksum for your data package:
#1 Open Windows Command Prompt
#2 Use CertUtil to calculate MD5 hash. Enter this text as appears below:
 #CertUtil -hashfile "full_path_to_your_data_file_including_file_extension" MD5
#4 Your MD5 value should look something like this: cc14e22acb7f62237db9478706e8cc51
#5 This value is what you paste into the <authentication> element
#__________________________________________________

#EDI REPOSITORY STAGING
#https://portal-s.edirepository.org/nis/home.jsp


