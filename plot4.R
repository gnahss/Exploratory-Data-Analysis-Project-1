## Exploratory Data Analysis Project 1

# download and read file
file = "hh_power_consum.zip"
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile=file)
unzip(file)
txt <- "household_power_consumption.txt"
all <- read.table(txt, header=TRUE, sep=";")
all$Date <- as.Date(all$Date, "%d/%m/%Y")

# get date and time classes
df <- all[(all$Date==as.Date("2007-02-01")|all$Date==as.Date("2007-02-02")),]
df$dtime <- strptime(paste(df[,1],df[,2]), "%Y-%m-%d %H:%M:%S") # create date-time variable

df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))

png("plot4.png", width=480, height=480, units="px") 
par(mfrow=c(2,2))
with(df, {
  plot(dtime, Global_active_power, type="l", xlab=" ", ylab="Global Active Power")
  
  plot(dtime,Voltage,xlab="datetime",ylab="Voltage", type="l")
  
  plot(dtime, Sub_metering_1, type="l",xlab="", ylab="Energy sub metering")
  points(dtime,Sub_metering_2,type="l",col="red")
  points(dtime, Sub_metering_3, type="l", col="blue")
  legend("topright",lty=rep(1,3),col=c("black","red","blue"),
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
  
  plot(dtime,Global_reactive_power,xlab="datetime",ylab=names(df)[4], type="l")
  
})
dev.off()