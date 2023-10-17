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

# The graph
png(file = "plot2.png", width = 480, height = 480, units = "px")
with(PData,
     plot(posix,
          Global_active_power,
          type = "l",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"))
dev.off()  # Close the png file device