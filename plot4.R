#
# plot4.R
#
# plot 4 for project 1 in Coursera Johns Hopkins Exploratory Data Analysis Class
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
  
  # create dir if doesn't exist
  #
  dir.create(datadir, showWarnings=FALSE)
  
  # download the file
  #
  download.file(dataurl,datazip,method="curl",quiet=TRUE)
  
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

# create a Date and Time column 
#
plotdata$DT <- with(plotdata, as.POSIXct(paste(Date,Time,sep=" "),format="%d/%m/%Y %H:%M:%S"))

# Set graphics device to png
#
png(filename = "plot4.png")

# Add plots with options to make them look correct
#
par(mfrow = c(2,2))

# 1st plot - same as Plot 2 without (kilowatts on label), Global Active Power
#
plot(plotdata$DT,plotdata$Global_active_power,xlab="",ylab="Global Active Power",type="l")

# 2nd plot - Voltage
#
plot(plotdata$DT,plotdata$Voltage,xlab="datetime",ylab="Voltage",type="l")

# 3rd plot - same as Plot 3, Sub metering plots
#
plot(plotdata$DT,plotdata$Sub_metering_1,xlab="",ylab="Energy sub metering",type="n")
points(plotdata$DT,plotdata$Sub_metering_1,type="l",col="black")
points(plotdata$DT,plotdata$Sub_metering_2,type="l",col="red")
points(plotdata$DT,plotdata$Sub_metering_3,type="l",col="blue")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),bty="n")

# 4th plot - Global_reactive_power
#
plot(plotdata$DT,plotdata$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")

# Close device
#
dev.off()