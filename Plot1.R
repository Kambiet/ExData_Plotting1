###Reading text data 

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

# Convert column that we will use to correct class
PData$Global_active_power <- as.numeric(PData$Global_active_power)

# The graph
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(PData$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()  # Close the png file device

# # Converting the rest (Both date and time at once)
# PData$posix <- paste(PData$Date, PData$Time, sep = " ")
# PData$posix <- strptime(PData$fulldate, format = "%d/%m/%Y %H:%M:%S")

