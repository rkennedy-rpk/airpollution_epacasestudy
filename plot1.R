library(tidyverse)
library(here)

NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

totalUS <- NEI %>% 
        group_by(year) %>% 
        summarise(total = sum(Emissions))

png(filename = "total_emissions1.png")
with(totalUS, plot(year, total, 
                   xlab = "Year", 
                   ylab = "PM2.5 emissions (tons)",
                   pch = 20,
                   col = "red"))
     title(main = "Total Emissions from PM2.5 in the United States")
     model <- lm(total ~ year, totalUS)
     abline(model, lwd = 2)
dev.off()

