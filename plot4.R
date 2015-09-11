## 
## Course Project 1: Plot 4
##

## change the location to the raw data file 
file = "../data/household_power_consumption.txt"
household <- read.table(file, header=T, sep=";")

## change the date format
household$NewDate <- as.Date(household$Date, format="%d/%m/%Y")

## restrict to the days of interest
cohort <- household[household$NewDate=="2007-02-01" | household$NewDate=="2007-02-02",]

##  create a 2x2 matrix of nrows and ncols
par(mfrow=c(2,2))

## reformat to numeric to support graphing && date transform
cohort$Global_active_power <- as.numeric(as.character(cohort$Global_active_power))
cohort$Voltage <- as.numeric(as.character(cohort$Voltage))
cohort$Global_reactive_power <- as.numeric(as.character(cohort$Global_reactive_power))

cohort <- transform(cohort, timestamp=as.POSIXct(paste(NewDate, Time)), "%d/%m/%Y %H:%M:%S")
cohort$Sub_metering_1 <- as.numeric(as.character(cohort$Sub_metering_1))
cohort$Sub_metering_2 <- as.numeric(as.character(cohort$Sub_metering_2))
cohort$Sub_metering_3 <- as.numeric(as.character(cohort$Sub_metering_3))

## Plot Chart 1
plot(cohort$timestamp,cohort$Global_active_power, type="l", xlab="", ylab="Global Active Power")

## Plot Chart 2
plot(cohort$timestamp,cohort$Voltage, type="l", xlab="datetime", ylab="Voltage")

## plot Chart 3
with(cohort, plot(timestamp,Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
lines(cohort$timestamp,cohort$Sub_metering_1)
lines(cohort$timestamp,cohort$Sub_metering_2,col="red")
lines(cohort$timestamp,cohort$Sub_metering_3,col="blue")

## create the legend for plot 3
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

## Plot Chart 4
plot(cohort$timestamp,cohort$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

## Save as PNG format
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()