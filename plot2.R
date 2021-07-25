library(tidyverse)
library(here)

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

baltimore <- NEI %>% 
        filter(fips == "24510") %>% 
        group_by(year) %>% 
        summarise(total = sum(Emissions))

png(filename = "baltimore_emissions2.png")
with(baltimore, plot(year, total, 
                   xlab = "Year", 
                   ylab = "PM2.5 emissions (tons)",
                   pch = 20,
                   col = "red"))
title(main = "Total Emissions from PM2.5 in Baltimore City")
model <- lm(total ~ year, baltimore)
abline(model, lwd = 2)
dev.off()
