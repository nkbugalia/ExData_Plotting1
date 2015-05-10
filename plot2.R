# Retrieve complete dataset
powerData <- read.csv("./household_power_consumption.txt", header=T, sep=';')
powerData$Date <- as.Date(powerData$Date, format="%d/%m/%Y")

# Subset the dataset for given dates
subsetPowerData <- subset(powerData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(powerData)

# Convert the dates
datetime <- paste(as.Date(subsetPowerData$Date), subsetPowerData$Time)
subsetPowerData$Datetime <- as.POSIXct(datetime)

# Convert Global_Active_Power to numeric
subsetPowerData$Global_active_power <- as.numeric(as.character(subsetPowerData$Global_active_power))

# Plot 2
plot(subsetPowerData$Global_active_power~subsetPowerData$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

# Save to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()