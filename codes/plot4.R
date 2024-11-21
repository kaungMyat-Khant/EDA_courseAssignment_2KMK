dir.reset <- getwd() ; dir.reset
setwd("./data")
dir()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
setwd(dir.reset)

baltimore <- NEI[which(NEI[,"fips"] == "24510"),]
head(SCC)

str(NEI)
coal <- as.character(SCC[grepl("Coal$",SCC$EI.Sector),"SCC"])
head(coal)
coalPM2.5 <- subset(NEI, SCC %in% coal)
summary(coalPM2.5$Emissions)
totalCoalPM2.5 <- with(coalPM2.5, tapply(Emissions, as.factor(year), sum))
totalCoalPM2.5

png(filename = "./outputs/plot4.png", width = 480, height = 480)
par(mar = c(4,4,4,2))
plot(totalCoalPM2.5, pch = 17, xaxt = "n",
     xlab = "Year of emission recorded",
     ylab = "Total amount of PM2.5 emissions in tons",
     main = "Total emission of PM2.5 from coal combustion across USA")
lines(totalCoalPM2.5 ,col = "black", lwd = 1)
axis(1, at = c(1,2,3,4), labels = names(totalCoalPM2.5))
dev.off()
