dir.reset <- getwd() ; dir.reset
setwd("./data")
dir()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
setwd(dir.reset)

baltimore <- NEI[which(NEI[,"fips"] == "24510"),]
dim(baltimore)
head(baltimore)
summary(baltimore$Emissions)
totalemission <- with(baltimore, 
                      tapply(Emissions, as.factor(as.character(year)), sum))
totalemission
png(filename = "./outputs/plot2.png", height = 480, width = 480)
plot(totalemission, xaxt = "n", 
     col ="darkred", pch = 20,
     xlab = "Years  of emission recorded",
     ylab = "Total emission of PM2.5 in tons")
lines(totalemission, col = "red")
axis(1, at = c(1,2,3,4), labels = names(totalemission))
title(main = "Total emission of PM2.5 from all sources in Baltimore")
dev.off()
