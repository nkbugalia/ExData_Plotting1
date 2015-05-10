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
subsetPowerData$Global_active_power <- as.numeric(as.character(subsetPowerData$Global_active_power))
subsetPowerData$Global_reactive_power <- as.numeric(as.character(subsetPowerData$Global_reactive_power))
subsetPowerData$Voltage <- as.numeric(as.character(subsetPowerData$Voltage))
subsetPowerData$Sub_metering_1 <- as.numeric(as.character(subsetPowerData$Sub_metering_1))
subsetPowerData$Sub_metering_2 <- as.numeric(as.character(subsetPowerData$Sub_metering_2))
subsetPowerData$Sub_metering_3 <- as.numeric(as.character(subsetPowerData$Sub_metering_3))

# Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subsetPowerData, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5)
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global_Reactive_Power",xlab="datetime")
})

# Save to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()