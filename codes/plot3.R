dir.reset <- getwd() ; dir.reset
setwd("./data")
dir()

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
setwd(dir.reset)

baltimore <- NEI[which(NEI[,"fips"] == "24510"),]
dim(baltimore)
head(baltimore)

library(ggplot2)
p <- ggplot(data = baltimore, aes(as.character(year),Emissions,
                                  group = type, colour = type))
summary(p)

png(filename = "./outputs/plot3.png", width = 480, height = 480)
p + stat_summary(fun = "sum", geom = "point", size = 3) + 
    stat_summary(fun = "sum", geom = "line", linewidth = 1.5)+
    facet_wrap(~ type) +
    scale_fill_manual(values = RColorBrewer::brewer.pal(8, "Dark2"))+
    labs(title = "Emission of PM2.5 in Baltimore by type of sources",
         x = "Year of emission recorded",
         y = "Total amount of emission from all sources in tons")+
    theme_minimal()+
    theme(legend.position = "")
dev.off()
