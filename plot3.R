## 
## Course Project 1: Plot 3
##

## change the location to the raw data file 
file = "../data/household_power_consumption.txt"
household <- read.table(file, header=T, sep=";")

## change the date format
household$NewDate <- as.Date(household$Date, format="%d/%m/%Y")

## restrict to the days of interest
cohort <- household[household$NewDate=="2007-02-01" | household$NewDate=="2007-02-02",]

## reformat to numeric to support graphing
## date transform
cohort <- transform(cohort, timestamp=as.POSIXct(paste(NewDate, Time)), "%d/%m/%Y %H:%M:%S")
cohort$Sub_metering_1 <- as.numeric(as.character(cohort$Sub_metering_1))
cohort$Sub_metering_2 <- as.numeric(as.character(cohort$Sub_metering_2))
cohort$Sub_metering_3 <- as.numeric(as.character(cohort$Sub_metering_3))

## plot cohort
with(cohort, plot(timestamp,Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
lines(cohort$timestamp,cohort$Sub_metering_1)
lines(cohort$timestamp,cohort$Sub_metering_2,col="red")
lines(cohort$timestamp,cohort$Sub_metering_3,col="blue")

## create the legend
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

## Save as PNG format
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()