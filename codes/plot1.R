dir.reset <- getwd()
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
barplot(totalemission, yaxt = "n", col = "red", ylim = c(0,9000000))
title(main = "PM2.5 emission from all sources decreased in US", 
      ylab = "Total amount of  PM2.5 Emissions from all sources (Tons)",
      xlab = "Year of emissions recorded")
text(totalemission+400000, labels = round(totalemission))
dev.off()
