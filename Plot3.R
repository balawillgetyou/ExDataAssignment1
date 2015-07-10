# This code generates Plot3.
# Detailed comments included in Plot1.R and not repeated here.

require(data.table)
hpc<- fread("household_power_consumption.txt")
str(hpc)

library(dplyr)
hpc2 <- filter(hpc, Date == "1/2/2007" | Date == "2/2/2007")
str(hpc2)

hpc2$DT <- paste(hpc2$Date, hpc2$Time, sep =" ")
DT2 <- strptime(hpc2$DT, format = "%d/%m/%Y%H:%M:%S")
wd <- weekdays(as.Date(hpc2$DT, format = "%d/%m/%Y%H:%M:%S"))
Global_active_power2 <- as.numeric(hpc2$Global_active_power)
class(Global_active_power2)
Global_reactive_power2 <- as.numeric(hpc2$Global_reactive_power)
class(Global_reactive_power2)
Voltage2 <- as.numeric(hpc2$Voltage)
class(Voltage2)
Global_intensity2 <- as.numeric(hpc2$Global_intensity)
class(Global_intensity2)
Sub_metering_12 <- as.numeric(hpc2$Sub_metering_1)
class(Sub_metering_12)
Sub_metering_22 <- as.numeric(hpc2$Sub_metering_2)
class(Sub_metering_22)


hpc3 <- cbind(hpc2, DT2, wd, Global_active_power2, Global_reactive_power2, Voltage2, Global_intensity2, Sub_metering_12, Sub_metering_22)
str(hpc3)
head(hpc3)

hpc4 <- select (hpc3, DT2, wd, Global_active_power2, Global_reactive_power2, Voltage2, Global_intensity2, Sub_metering_12, Sub_metering_22, Sub_metering_3)
str(hpc4)

plot(DT2, hpc4$Sub_metering_12, type = "n", ylab = "Energy sub metering", xlab ="")
lines(DT2, hpc4$Sub_metering_12)
lines(DT2, hpc4$Sub_metering_22, col = "red")
lines(DT2, hpc4$Sub_metering_3, col = "blue")
legend("topright", lty=c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
dev.copy(png, file = "plot3.png")
png("plot3.png",  width = 480, height = 480, units = "px")
dev.off()
dev.off()
dev.off()