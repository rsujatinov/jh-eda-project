library(dplyr)
library(stringr)
library(ggplot2)
library(tidyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Let's filter data from motor vehicle sources in Baltimore City and Los Angeles County and summarize emission by years
# data = NEI %>% 
#     inner_join(SCC, by="SCC") %>%
#     filter(type=="ON-ROAD" & fips %in% c("24510", "06037")) %>%
#     group_by(fips, year) %>%
#     summarize(total = sum(Emissions)) %>%
#     spread(fips, total) %>%
#     rename("Baltimore City" = "24510", "Los Angeles" = "06037")

data = NEI %>% 
    inner_join(SCC, by="SCC") %>%
    filter(type=="ON-ROAD" & fips %in% c("24510", "06037")) %>%
    mutate(fips = ifelse(fips == "24510", "Baltimore City" , "Los Angeles")) %>%
    group_by(fips, year) %>%
    summarize(total = sum(Emissions))

# Plot data
ggplot(data, aes(year, total, color=fips)) + 
    geom_line() + 
    geom_boxplot() +
    labs(x="Year", y="Total Emission (tonns)", title="PM2.5 Emissions from Motor Vehicle Sources in Baltimore City and Los Angeles")

dev.print(png, file = "plot6.png", width = 640, height = 640)
