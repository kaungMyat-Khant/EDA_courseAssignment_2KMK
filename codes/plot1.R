dir.reset <- getwd()  ; dir.reset
setwd("./data")
dir()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
setwd(dir.reset)

dim(NEI)
str(NEI)
head(NEI)
head(SCC)

unique(NEI$year)
unique(NEI$Pollutant)
summary(NEI$Emissions)
totalemission <- with(NEI, tapply(Emissions, as.factor(as.character(year)),sum))
str(totalemission)
totalemission

png(filename = "outputs/plot1.png", width = 480, height = 480)
plot(totalemission, xaxt = "n", 
     col ="darkred", pch = 18,
     xlab = "Years  of emission recorded",
     ylab = "Total emission of PM2.5 in tons")
lines(totalemission, col = "maroon")
axis(1, at = c(1,2,3,4), labels = names(totalemission))
title(main = "Total emission of PM2.5 from all sources in USA")
dev.off()
