library(dplyr)
library(stringr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Let's filter data from motor vehicle sources in Baltimore City and summarize emission by years
data = NEI %>% 
    inner_join(SCC, by="SCC") %>%
    filter(type=="ON-ROAD", fips == "24510") %>%
    group_by(year) %>%
    summarize(total = sum(Emissions))

# Plot data
ggplot(data, aes(year, total)) + 
    geom_line(col="blue") +
    geom_smooth(method = "lm", col = "gray", lwd=0.5, lty=2, se=FALSE) + 
    labs(x="Year", y="Total Emission (tonns)", title="PM2.5 Emissions from Motor Vehicle Sources in Baltimore City")

dev.print(png, file = "plot5.png", width = 640, height = 640)