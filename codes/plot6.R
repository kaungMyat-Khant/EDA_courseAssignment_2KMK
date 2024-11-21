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

cities <- subset(NEI, fips %in% c("24510","06037"))
dim(cities)
cities$city <- ifelse(cities$fips == "24510", "Baltimore", "Los Angeles")
str(cities)

cityVehiclePM2.5 <- subset(cities,SCC %in% vehicle)
cityVehiclePM2.5$year <- as.factor(as.character(cityVehiclePM2.5$year))
str(cityVehiclePM2.5)



bal <- with(cityVehiclePM2.5[cityVehiclePM2.5$city == "Baltimore",],
            tapply(Emissions, as.factor(as.character(year)), mean))    
LA <- with(cityVehiclePM2.5[cityVehiclePM2.5$city == "Los Angeles",],
            tapply(Emissions, as.factor(as.character(year)), mean))  
bal ; LA
bal <- data.frame(year = names(bal), emission=bal)
bal$city <- rep("Baltimore", nrow(bal))
LA <- data.frame(year = names(LA), emission=LA)
LA$city <- rep("Los Angeles", nrow(LA))

twoCity <- rbind(bal, LA)
str(twoCity)
twoCity

p <- ggplot(cityVehiclePM2.5, aes(x = year, y = Emissions, group = city,
                             colour = city))
png(filename = "./outputs/plot6.png", width = 480, height = 480)
p +
    stat_summary(fun = "sum", geom = "point", size = 3)+
    stat_summary(fun = "sum", geom = "line", linewidth = 1)+
    labs(title = "PM2.5 emissions from Baltimore and Los Angeles",
         x = "Year of emission recorded",
         y = "Total amount of PM2.5 emission in tons",
         colour = "City")+
    scale_color_manual(values = RColorBrewer::brewer.pal(3,"Dark2"))+
    theme_minimal()
dev.off()    
