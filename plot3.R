library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Let's filter data for Blatimore City and summarize emission by types and years
data = NEI %>% 
    filter(fips == "24510") %>%
    group_by(type, year) %>%
    summarize(total = sum(Emissions))

# Plot data
ggplot(data, aes(year, total, color=type)) + 
    geom_line() +
    geom_smooth(method = "lm", col = "gray", lwd=0.5, lty=2, se=FALSE) + 
    facet_grid(rows=vars(type), scales = "free", switch="y") +
    labs(x="Year", y="Total Emission (tonns)", title="PM2.5 Emission in Baltimore City")

dev.print(png, file = "plot3.png", width = 640, height = 640)
