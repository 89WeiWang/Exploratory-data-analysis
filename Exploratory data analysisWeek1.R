file <- file("household_power_consumption.txt")
EPC <- read.table(text = grep("^[1,2]/2/2007",readLines(file),value=TRUE), sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')
library(lubridate)
EPC$Date <- dmy(EPC$Date)
EPC$Time <- hms(EPC$Time)
EPC$DateTime <- EPC$Date + EPC$Time

png('plot1.png')
with(EPC, hist(Global_active_power, xlab = "Global Active Power(kilowatts)", ylab = "frequency", col = 'red', main = "Global Active Power"))
dev.off()

png('plot2.png')
Sys.setlocale(category = "LC_ALL", locale = "english")
with(EPC, plot(DateTime, Global_active_power, type = 'l'), xlab='', ylab='Global Active Power(kilowatts)')
dev.off()

png('plot3.png')
Sys.setlocale(category = "LC_ALL", locale = "english")
plot(EPC$DateTime, EPC$Sub_metering_1, type = 'n', xlab = '', ylab = 'Energy sub metering')
lines(EPC$DateTime, EPC$Sub_metering_1, col = 'black')
lines(EPC$DateTime, EPC$Sub_metering_2, col = 'red')
lines(EPC$DateTime, EPC$Sub_metering_3, col = 'blue')
legend('topright', col = c('black', 'red','blue'), lwd = 1, legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off

png('plot4.png')
par(mfrow= c(2,2))
plot(EPC$DateTime, EPC$Voltage, type = 'l')
plot(EPC$DateTime, EPC$Global_reactive_power, type = 'l')
