# Retrieve complete dataset
powerData <- read.csv("./household_power_consumption.txt", header=T, sep=';')
powerData$Date <- as.Date(powerData$Date, format="%d/%m/%Y")

# Subset the dataset for given dates
subsetPowerData <- subset(powerData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(powerData)

# Convert the dates
datetime <- paste(as.Date(subsetPowerData$Date), subsetPowerData$Time)
subsetPowerData$Datetime <- as.POSIXct(datetime)

# Convert required variables to numeric
subsetPowerData$Sub_metering_1 <- as.numeric(as.character(subsetPowerData$Sub_metering_1))
subsetPowerData$Sub_metering_2 <- as.numeric(as.character(subsetPowerData$Sub_metering_2))
subsetPowerData$Sub_metering_3 <- as.numeric(as.character(subsetPowerData$Sub_metering_3))

# Plot 3
with(subsetPowerData, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()