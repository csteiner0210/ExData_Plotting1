#### data
hhpwrconsumpdata <- read.table("household_power_consumption.txt", sep = ";",header = TRUE)

# Best way to convert data to date
cc <- paste(as.Date(hhpwrconsumpdata$Date, format="%d/%m/%Y"),hhpwrconsumpdata$Time, sep = " ")
head(cc)
strptime(cc[1:5], format="%Y-%m-%d %H:%M:%S")
hhpwrconsumpdata$Time <- strptime(cc, format="%Y-%m-%d %H:%M:%S")
head(hhpwrconsumpdata$Time)
class(hhpwrconsumpdata$Time)
hhpwrconsumpdata$Time <- as.POSIXct(hhpwrconsumpdata$Time)
head(hhpwrconsumpdata$Time)
# just in case convert Date to a date class
hhpwrconsumpdata$Date <- as.Date(hhpwrconsumpdata$Date, "%d/%m/%Y")

# use the dplyr package
library(dplyr)
Date1 <- as.Date("2007-02-01")
Date2 <- as.Date("2007-02-02")
powersubset <- filter(hhpwrconsumpdata, hhpwrconsumpdata$Date >= Date1 & hhpwrconsumpdata$Date <= Date2)


#### plot 1
png("plot1.png",height=480,width=480)
with(powersubset,hist(Global_active_power/500, col = "red",xlab="Global active power (kilowatts)",main = "Global Active Power"))
dev.off()
