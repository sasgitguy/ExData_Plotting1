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

# make plot 1
hist(hp$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
