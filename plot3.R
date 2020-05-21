#load libraries
    library(lubridate)
#load the data from the txt file; 
    full_dataset <- read.csv("./household_power_consumption.txt", header=TRUE, sep =";",na.strings="?",colClasses = "character")
#Format the Date and subset only the dates required "2007-02-01" and "2007-02-01"
    full_dataset$FixedDate <- as.Date(full_dataset$Date,format="%d/%m/%Y")
    md <- subset(full_dataset, FixedDate ==as.Date("2007-02-01") | FixedDate==as.Date("2007-02-02")  ,select=c(Date:Sub_metering_3))
#Format the Date column  
    md$Date<- as.Date(md$Date,format="%d/%m/%Y")
#Format the Time column
    x<-paste(md$Date , md$Time)
    md$Time<- strptime(x,format="%Y-%m-%d %H:%M:%S")
#Format the numeric columns
    col.num<-names(md[3:9])
    md[col.num]<-sapply(md[col.num],as.numeric)
    
#Create plot3
    plot(md$Time,md$Sub_metering_1, type="l",ylab = "Energy sub metering",xlab = "")
    lines(md$Time,md$Sub_metering_2,col="red")
    lines(md$Time,md$Sub_metering_3,col="blue")
    leg.txt <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
    legend("topright" , col = c("black", "red","blue"),leg.txt ,lty = 1)
    
# #Export to png
    dev.copy(png, file = "plot3.png",width = 480, height = 480)
    dev.off()