library(tidyverse)
library(here)

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

isvehicle <- grepl("Vehicle", SCC$Short.Name)
SCC_vehicle <- SCC[isvehicle,] 
isvehicle2 <-   NEI$SCC %in% SCC_vehicle$SCC
NEI_vehicle <- NEI[isvehicle2,]
NEI_vehicle_baltimore <- NEI_vehicle %>% 
        filter(fips == "24510")

png(filename = "baltimore_vehicle5.png")
qplot(year, log10(Emissions), data = NEI_vehicle_baltimore) +
        geom_smooth(method = "lm") +
        theme(axis.text.x = element_text(angle = 90))+
        ggtitle(label = "Emission trends from motor vehicle related sources")+
        labs(subtitle = "Baltimore City 1999-2008")
dev.off()
