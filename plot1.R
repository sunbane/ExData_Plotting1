#
# plot1.R
#
# plot 1 for project 1 in Coursera Johns Hopkins Exploratory Data Analysis Class
#
# Source dataset
#
# Data from the UC Irvine Machine Learning Repository on individual household electric power consumption
#
dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# file that will extract from the zip
#
datafile <- "./data/household_power_consumption.txt"

# where I want to put the data and the temporary name for my zip
#
datadir <- "./data"
datazip <- "./data/temp.zip"

# do we already have the datafile?  If not, get it
#
if (! file.exists(datafile)) {
  
   # download the file
   #
   download.file(dataurl,datazip,method="curl")
  
   # unzip the file, note that if datadir does not exist unzip should create it
   #
   unzip(datazip,exdir = datadir)
   
   # remove the downloaded zipfile
   #
   unlink(datazip)
}

# read data file in
#
# sample contents:
#
# Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
# 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
#
# Note they mention that we could potentially load in a smaller part of data but I have 64GB memory so
# I am not worried about that, separator is a ; and missing data is indicated with a ?
#
data <- read.csv(datafile, header=TRUE,sep=";",na.strings="?")

# We only want to use the data from the dates 2007-02-01 and 2007-02-02
#
plotdata <- subset(data, Date=="1/2/2007" | Date == "2/2/2007")

# Set graphics device to png
#
png(filename = "plot1.png")

# Add histogram with options to make it look correct
#
hist(plotdata$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

# Close device
#
dev.off()

