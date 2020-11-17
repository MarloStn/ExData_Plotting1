##plot2 R script. Made by O.Pascual nov-2020
##
# Objective of the script: create the plot2 png file requested by the week 1 project
# of the Explanatory Data Analysis course
#
#
# Output: plot2.png file
#
# Prerequisite: download exdata_data_household_power_consumption.zip and put it in your working directory
#
# ----------Step 0-----------------------------------------------------------------------------------------
#
# unziping the getdata_projectfiles_UCI file
unzip("exdata_data_household_power_consumption.zip")
library(dplyr)
#
# reading of exdata_data_household_power_consumption.txt
all_data <- read.table("household_power_consumption.txt", header = TRUE, sep=";")
#
# filtering on relevant data, day 2/2/2007 and 1/2/2007
relevant_data <- filter(all_data, Date=="2/2/2007" | Date=="1/2/2007")
#
# converting Date,Time in Date. converting Global_active_power in numeric
#
relevant_data <- mutate(relevant_data,Date_Time=paste(Date, Time))
relevant_data$Date_Time <- strptime(relevant_data$Date_Time,"%d/%m/%Y %H:%M:%S")
relevant_data$Date <- strptime(relevant_data$Date,"%d/%m/%Y")
relevant_data$Global_active_power <- as.numeric(relevant_data$Global_active_power)
#
# ----------Step 1: creating the graph-----------------------------------------------------------------------------------------
#
png(file="plot2.png")
with(relevant_data, plot(Date_Time, Global_active_power,type="l", ylab = "Global active power (kilowatts)", xlab=""))
dev.off()