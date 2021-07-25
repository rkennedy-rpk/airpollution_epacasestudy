library(tidyverse)
library(here)

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

iscoal <- grepl("Coal", SCC$Short.Name)
SCC_coal <- SCC[iscoal,] 
iscoal2 <-   NEI$SCC %in% SCC_coal$SCC
NEI_coal <- NEI[iscoal2,]

png(filename = "coal_emissions4.png")
qplot(year, log10(Emissions), data = NEI_coal) +
        geom_smooth(method = "lm") +
        theme(axis.text.x = element_text(angle = 90))+
        ggtitle(label = "Emission trends from coal combustion-related sources 1999-2008")
dev.off()
