###################################
# Exploratory Data Analysis       #
# Project 01                      #
###################################

# 0) Set system environment ----
Sys.setlocale("LC_MESSAGES", 'en_GB.UTF-8')
Sys.setenv(LANG = "en_US.UTF-8")


# 1) Read data ------------------------------------------------------------
household_power_consumption <- read.csv("~/R_Projects/EDA_Project01/household_power_consumption.txt", 
                                        sep=";",
                                        dec=".",
                                        header = TRUE,
                                        colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                                        na.strings = "?")


# 2) Format Data --------------------------
# 2.1) Create Date/Time Column
household_power_consumption$DateTime <- paste(household_power_consumption$Date, 
                                              household_power_consumption$Time)

# 2.2) Convert Date Datatype
household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")

# 2.3) Convert Timeseries
#household_power_consumption$Time <- strptime(household_power_consumption$Time, "%H:%M:%S")

# 2.4) Add Column for weekdays
household_power_consumption$weekday <- weekdays(household_power_consumption$Date)

#2.5) Convert Date/Time Timeseries
household_power_consumption$DateTime <- strptime(household_power_consumption$DateTime, "%d/%m/%Y %H:%M:%S")

#2.6) View data
#View(household_power_consumption)

# 2.7) We will only be using data from the dates 2007-02-01 and 2007-02-02
household_power_consumption_subset <- subset(household_power_consumption, 
                                             Date >= "2007-02-01" & Date <= "2007-02-02")

#2.8) View reduced data
#View(household_power_consumption_subset)



#3) Generate Plots ----
#3.1) Histogram
png(filename="Plot_01.png", width=480, height=480)
hist(household_power_consumption_subset$Global_active_power, 
     col="red", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     main="Global Active Power")
dev.off()

#3.2) Linechart
png(filename="Plot_02.png", width=480, height=480)
plot(household_power_consumption_subset$DateTime,
     household_power_consumption_subset$Global_active_power, 
     type="l", 
     xlab=NA, 
     ylab="Global Active Power (kilowatts)")
dev.off()


#3.3) Submetering chart - plot without lines first, then add content
png(filename="Plot_03.png", width=480, height=480)
plot(household_power_consumption_subset$DateTime,
     household_power_consumption_subset$Sub_metering_1,
     type="l", 
     xlab=NA, 
     ylab="Energy sub metering")

lines(household_power_consumption_subset$DateTime,
      household_power_consumption_subset$Sub_metering_2, 
      col="red", 
      type="l")

lines(household_power_consumption_subset$DateTime,
      household_power_consumption_subset$Sub_metering_3, 
      col="blue", 
      type="l")

legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), 
       pch="-")

dev.off()

#3.4) Combined Graph
png(filename="Plot_04.png", width=480, height=480)
par(mfrow=c(2,2))

#3.4.1) Global Active Power Chart
plot(household_power_consumption_subset$DateTime,
     household_power_consumption_subset$Global_active_power, 
     type="l", 
     xlab=NA, 
     ylab="Global Active Power (kilowatts)")

#3.4.2) Voltage Chart
plot(household_power_consumption_subset$DateTime,
     household_power_consumption_subset$Voltage, 
     type="l", 
     xlab="datetime", 
     ylab="Voltage")

#3.4.3) Sub metering
plot(household_power_consumption_subset$DateTime,
     household_power_consumption_subset$Sub_metering_1,
     type="l", 
     xlab=NA, 
     ylab="Energy sub metering")

lines(household_power_consumption_subset$DateTime,
      household_power_consumption_subset$Sub_metering_2, 
      col="red", 
      type="l")

lines(household_power_consumption_subset$DateTime,
      household_power_consumption_subset$Sub_metering_3, 
      col="blue", 
      type="l")

legend("topright", 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), 
       pch="-")

#3.4.4) Global Reactive Power
plot(household_power_consumption_subset$DateTime,
     household_power_consumption_subset$Global_reactive_power, 
     type="l", 
     xlab="datetime",
     ylab="Global_reactive_power")

dev.off()