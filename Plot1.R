# This code generates Plot1

# Step 1 is to read the data. Use of colClasses at this stage failed. The "?" lead to coercion into
# character class anyway.
require(data.table)
hpc<- fread("household_power_consumption.txt")
#str(hpc)

# Step 2 is to subset for the specific dates of interest
library(dplyr)
hpc2 <- filter(hpc, Date == "1/2/2007" | Date == "2/2/2007")
#str(hpc2)

# Step 3 includes concatenating date and time + converting all column classes.
# Recognizing that converting column classes one at a time is inefficient, other options like 
#"apply" were explored and discarded.
hpc2$DT <- paste(hpc2$Date, hpc2$Time, sep =" ")
DT2 <- strptime(hpc2$DT, format = "%d/%m/%Y%H:%M:%S")
wd <- weekdays(as.Date(hpc2$DT, format = "%d/%m/%Y%H:%M:%S"))
Global_active_power2 <- as.numeric(hpc2$Global_active_power)
#class(Global_active_power2)
Global_reactive_power2 <- as.numeric(hpc2$Global_reactive_power)
#class(Global_reactive_power2)
Voltage2 <- as.numeric(hpc2$Voltage)
#class(Voltage2)
Global_intensity2 <- as.numeric(hpc2$Global_intensity)
#class(Global_intensity2)
Sub_metering_12 <- as.numeric(hpc2$Sub_metering_1)
#class(Sub_metering_12)
Sub_metering_22 <- as.numeric(hpc2$Sub_metering_2)
#class(Sub_metering_22)

# Step 4 is to add the new columns in the class form needed for analysis
hpc3 <- cbind(hpc2, DT2, wd, Global_active_power2, Global_reactive_power2, Voltage2, Global_intensity2, Sub_metering_12, Sub_metering_22)
#str(hpc3)
#head(hpc3)

# Step 5 trimmed out columns not needed
hpc4 <- select (hpc3, DT2, wd, Global_active_power2, Global_reactive_power2, Voltage2, Global_intensity2, Sub_metering_12, Sub_metering_22, Sub_metering_3)
#str(hpc4)

# Step 6 is the actual plot generation. First on the screen and then copying the desired graph to a
# PNG file. 
# The dev.off() instruction had to be called thrice. Else the PNG could not be opened and a message
# about the file being in use by another program kept popping up.
hist(hpc4$Global_active_power2, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png")
png("plot1.png",  width = 480, height = 480, units = "px")
dev.off()
dev.off()
dev.off()