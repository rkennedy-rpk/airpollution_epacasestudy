library(tidyverse)
library(here)

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

baltimore_full <- NEI %>% 
        filter(fips == "24510")

png(filename = "baltimore_type3.png")
qplot(year, log(Emissions), data = baltimore_full, facets = .~type) +
        geom_smooth(method = "lm") +
        theme(axis.text.x = element_text(angle = 90))+
        ggtitle(label = "Emission trends by type 1999-2008")
dev.off()