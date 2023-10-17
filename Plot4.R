PData <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";")
###Glancing the data 
View(PData)
save(PData, file = "PowerData.R")
names(PData)

# Convert "?" in NAs
PData[PData == "?"] <- NA

# Selecting adequate lines
PData$Date <- as.Date(PData$Date, format = "%d/%m/%Y")
PData <- PData[PData$Date >= as.Date("2007-02-01") & PData$Date <= as.Date("2007-02-02"),]
save(PData, file = "PowerDataExtract.R")
# Joining day and time to create a new posix date
PData$posix <- as.POSIXct(strptime(paste(PData$Date, PData$Time, sep = " "),
                                   format = "%Y-%m-%d %H:%M:%S"))

# Convert column that we will use to correct class
PData$Global_active_power <- as.numeric(PData$Global_active_power)

# the graph
png(file = "plot4.png", width = 480, height = 480, units = "px")

## Setting 4 graphs
par(mfrow = c(2, 2))

## Graph 1
with(PData,
     plot(posix,
          Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power"))

## Graph 2
with(PData,
     plot(posix,
          Voltage,
          type = "l",
          xlab = "datetime",
          ylab = "Voltage"))

## Graph 3
with(PData,
     plot(posix,
          Sub_metering_1,
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"))
with(PData,
     points(posix,
            type = "l",
            Sub_metering_2,
            col = "red")
)
with(PData,
     points(posix,
            type = "l",
            Sub_metering_3,
            col = "blue")
)
legend("topright", col = c("black", "blue", "red"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)

## Graph 4
with(PData,
     plot(posix,
          Global_reactive_power,
          type = "l",
          xlab = "datetime",
          ylab = "Global_reactive_power"))
dev.off()  # Close the png file device