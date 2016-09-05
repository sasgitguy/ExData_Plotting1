library(dplyr)
library(data.table)

# download the file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile="./power-data.zip")
unzip(zipfile="./power-data.zip",exdir=".")

# ingest training txt files
house_power <- read.table("./household_power_consumption.txt", header=T, sep=";")
house_power$Date <- as.Date(house_power$Date, format="%d/%m/%Y")
hp <- filter(house_power,Date=="2007-02-01" | Date=="2007-02-02")

# convert to numeric
hp$Global_active_power <- as.numeric(as.character(hp$Global_active_power))

# make plot 4
hp$Voltage <- as.numeric(as.character(hp$Voltage))
hp$Global_reactive_power <- as.numeric(as.character(hp$Global_reactive_power))
par(mfrow=c(2,2))

plot(hp$timestamp,hp$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(hp$timestamp,hp$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(hp$timestamp,hp$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(hp$timestamp,hp$Sub_metering_2,col="red")
lines(hp$timestamp,hp$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5)

plot(hp$timestamp,hp$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
