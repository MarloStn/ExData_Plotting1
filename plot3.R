##plot3 R script. Made by O.Pascual nov-2020
##
# Objective of the script: create the plot3 png file requested by the week 1 project
# of the Explanatory Data Analysis course
#
#
# Output: plot3.png file
#
# Prerequisite: download exdata_data_household_power_consumption.zip and put it in your working directory
#
# ----------Step 0-----------------------------------------------------------------------------------------
#
# unziping the getdata_projectfiles_UCI file
unzip("exdata_data_household_power_consumption.zip")
library(dplyr)
library(reshape2)
#
# reading of exdata_data_household_power_consumption.txt
all_data <- read.table("household_power_consumption.txt", header = TRUE, sep=";")
#
# filtering on relevant data, day 2/2/2007 and 1/2/2007
relevant_data <- filter(all_data, Date=="2/2/2007" | Date=="1/2/2007")
#
# converting sub metering in numeric
#
relevant_data$Sub_metering_1 <- as.numeric(relevant_data$Sub_metering_1)
relevant_data$Sub_metering_2 <- as.numeric(relevant_data$Sub_metering_2)
relevant_data$Sub_metering_3 <- as.numeric(relevant_data$Sub_metering_3)
#
#
#
# ----------Step 1: reshaping the data-----------------------------------------------------------------------------------------
#
relevant_data <- select(relevant_data, Date,Time, Sub_metering_1, Sub_metering_2,Sub_metering_3)
relevant_data <- mutate(relevant_data,Date_Time=paste(Date, Time))
relevant_data$Date_Time <- strptime(relevant_data$Date_Time,"%d/%m/%Y %H:%M:%S")
#
# ----------Step 2: creating the graph-----------------------------------------------------------------------------------------
#
png(file="plot3.png")
plot(y=relevant_data$Sub_metering_1,x=relevant_data$Date_Time,type="l",ylab="Energy sub metering", xlab="")
lines(y=relevant_data$Sub_metering_2,x=relevant_data$Date_Time, type="l", col="red")
lines(y=relevant_data$Sub_metering_3,x=relevant_data$Date_Time, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), lty = c(1,1,1))
dev.off()