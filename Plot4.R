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


#### plot 4
library(png)
png("plot4.png",height=480,width=480)
op <- par(mfrow=c(2,2))
attach(powersubset) 
#first plot
plot(Time,Global_active_power,type='l',
     ylab="Global active power (kilowatts)",
     xlab="")
#second plot
plot(Time,Voltage,type='l',
     ylab="Voltage",
     xlab="datetime")
#third plot
plot(Time,Sub_metering_1,type='l',col="black",
     main='',xlab='',ylab='Energy sub metering')
lines(Time,Sub_metering_2,col="red")
lines(Time,Sub_metering_3,col="blue")
legend("topright",pch = 1, col  = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#fourth plot
plot(Time,Global_reactive_power,type='l',
     ylab="Global_reactive_power",
     xlab="datetime")

detach(powersubset)
par(op)
dev.off()