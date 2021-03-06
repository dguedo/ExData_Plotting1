## 
## Course Project 1: Plot 1
##

## change the location to the raw data file 
file = "../data/household_power_consumption.txt"
household <- read.table(file, header=T, sep=";")

## change the date format
household$NewDate <- as.Date(household$Date, format="%d/%m/%Y")

## restrict to the days of interest
cohort <- household[household$NewDate=="2007-02-01" | household$NewDate=="2007-02-02",]

## reformat to numeric to support graphing
cohort$Global_active_power <- as.numeric(as.character(cohort$Global_active_power))

## plot cohort
hist(cohort$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")

## Save as PNG format
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
