library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Let's summarize emission by years
data = NEI %>% 
    group_by(year) %>%
    summarize(total = sum(Emissions) / 1000)

# Plot data
plot(data, pch=16, cex=2, xlab="Year", ylab="Total Emission (10^3 tonns)", main="PM2.5 Emission")
lines(data)

dev.print(png, file = "plot1.png", width = 640, height = 640)
