## Exploratory Data Analysis with R - Course Project
## Plot 1

# This script reads data from the Electric power consumption dataset from the 
# UC Irvine Machine Learning Repository and creates a histogram of global active
# power consumption from Feb 1, 2007 and Feb 2, 2007

# Check if data exists in wd
if(!exists("HPC_filtered")){
        # Download data if not found in the current working directory:
        if(!file.exists("household_power_consumption.txt")){
                if(!file.exists("Electric power consumption.zip")){
                        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                        download.file(fileUrl, "Electric power consumption.zip")
                }
                unzip("Electric power consumption.zip")
        }
        
        # Read data
        householdPowerConsumption <- read.table(
                file = "household_power_consumption.txt", 
                na.strings = "?",
                header = TRUE,
                sep = ";",
                colClasses = c(rep("character", 2), rep("numeric", 7))
        )
        # Convert Date variable from character to date format
        householdPowerConsumption$Date <- as.Date(householdPowerConsumption$Date, format = "%d/%m/%Y")
        
        # Convert Time variable from character to time format
        datetime_temp <- paste(householdPowerConsumption$Date, householdPowerConsumption$Time, sep = " ")
        householdPowerConsumption$Time <- strptime(datetime_temp, format = "%Y-%m-%d %H:%M:%S")
        
        # Get data only for Feb 1 and 2, 2007
        HPC_filtered <- subset(householdPowerConsumption, between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))
}

# create graphic device, plot and close
png("plot1.png", width = 480, height = 480, units = "px")
hist(HPC_filtered$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power"
     )
dev.off()





