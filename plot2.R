library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Let's filter data for Blatimore City and summarize emission by years
data = NEI %>% 
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarize(total = sum(Emissions))

# Plot data
barplot(data$total, names.arg = data$year, col="blue4", xlab="Year", ylab="Total Emission (tonns)", main="PM2.5 Emission in Baltimore City")
dev.print(png, file = "plot2.png", width = 640, height = 640)
