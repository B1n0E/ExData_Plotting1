#plot4 code
library(dplyr)
Sys.setenv("LANGUAGE"="En")
Sys.setlocale("LC_ALL", "English")
#loading dataframe
data1 <- read.table("household_power_consumption.txt", header=TRUE,sep = ';')
data1[data1 == "?"] <- NA
#chaing date time columns
data1$Date = as.Date(data1$Date,format = "%d/%m/%Y")
data1$Time <- strptime(data1$Time, format ="%H:%M:%S")
#loading only specific dates
start_date <- as.Date("2007-02-01")
end_date <- as.Date("2007-02-02")
subdata1 <- data1[data1$Date >= start_date & data1$Date <=end_date, ]
subdata1$Time <- gsub("2023-07-15", "", subdata1$Time)
datetime_str <- paste(subdata1$Date, subdata1$Time)
datetime <- as.POSIXlt(datetime_str, format = "%Y-%m-%d %H:%M:%S")
#switching all numbers into numeric class
subdata1$Global_active_power = as.numeric(subdata1$Global_active_power)

# Generating plot 4 png file
file_path = 'plot4.png'
width <- 480
height <- 480
png(file = file_path, width = width, height = height)
par(mfrow = c(2, 2))
plot2 = plot(datetime,subdata1$Global_active_power, type = "l",ylab = "Global Active Power (kilowatts)",xlab = "")
subplot4_2 = plot(datetime,subdata1$Voltage, type = "l",ylab = "Voltage",xlab = "")
plot3 <- plot(datetime, subdata1$Sub_metering_1, type = "n", ylab = "Energy Sub Metering", xlab = "")
#lines
lines(datetime, subdata1$Sub_metering_1, col = "black", pch = 16)
lines(datetime, subdata1$Sub_metering_2, col = "orange", pch = 16)
lines(datetime, subdata1$Sub_metering_3, col = "blue", pch = 16)
#legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "orange", "blue"), lty = c(1,1,1))
subplot4_1 = plot(datetime,subdata1$Global_reactive_power, type = "l",ylab = "Global Active Power (kilowatts)",xlab = "")
dev.off()