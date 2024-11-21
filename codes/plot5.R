dir.reset <- getwd() ; dir.reset
setwd("./data")
dir()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
setwd(dir.reset)

baltimore <- NEI[which(NEI[,"fips"] == "24510"),]
str(baltimore)

unique(SCC$SCC.Level.One)
vehicle <- as.character(SCC[SCC$SCC.Level.One == "Mobile Sources","SCC"])

vehiclePM2.5 <- subset(baltimore, SCC %in% vehicle)
dim(vehiclePM2.5)
head(vehiclePM2.5)

totalVehiclePM2.5 <- with(vehiclePM2.5, 
                          tapply(Emissions, as.character(year), sum))
totalVehiclePM2.5

png(filename = "./outputs/plot5.png", width = 480, height = 480)
plot(totalVehiclePM2.5, xaxt = "n",
     pch = 16, col = "navy",
     xlab = "Year of emission recorded",
     ylab = "Total amount of PM2.5 emission in tons",
     main = "PM2.5 Emission from Motor Vehicles in Baltimore city")
lines(totalVehiclePM2.5, col = "navy")
axis(1, at = c(1,2,3,4), labels = names(totalVehiclePM2.5))
dev.off()
