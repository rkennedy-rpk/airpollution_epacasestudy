library(tidyverse)
library(here)

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

isvehicle <- grepl("Vehicle", SCC$Short.Name)
SCC_vehicle <- SCC[isvehicle,] 
isvehicle2 <-   NEI$SCC %in% SCC_vehicle$SCC
NEI_vehicle <- NEI[isvehicle2,]

#create dataset for visualization
NEI_vehicle_compare <- NEI_vehicle %>% 
        filter(fips == "06037" | fips == "24510")

#rename "fips" variables for later labeling purposes
LA <- grepl("06037", NEI_vehicle_compare$fips)
NEI_vehicle_compare[LA, "fips"] <- "Los Angeles"
rm(LA)
BALT <- grepl("24510", NEI_vehicle_compare$fips)
NEI_vehicle_compare[BALT, "fips"] <- "Baltimore City"
rm(BALT)

#plot comparison using qplot so that both linear regressions 
#can be overlayed in a single plot

png(filename = "comparison6.png")
qplot(year, log(Emissions), data = NEI_vehicle_compare, color = fips) +
        geom_smooth(method = "lm") +
        theme(axis.text.x = element_text(angle = 90))+
        ggtitle(label = "Emission trends from motor vehicle related sources")+
        labs(subtitle = "Baltimore City vs. Los Angeles 1999-2008")
dev.off()

