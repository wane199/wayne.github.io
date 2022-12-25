# [create beautiful GANTT Chart in R with progress tracking.]()
# https://rpubs.com/techanswers88/gantt-chart-in-r
# Packages used
# GGPLOT GANTT CHART
library(ggplot2)
library(tidyr)
library(lubridate)

# Prepare the data
# url is the location of your computer eg. c:\\tmp\\yourdata.csv"
# df <- read.csv("e:\\tmp\\ProjectSchedule.csv")
df <- data.frame(
  Stage = c(
    "Review literature", "Hypothesis formulation",
    "Get Data", "Data Cleansing",
    "Data Validation", "Analysis",
    "Write Report"
  ),
  Start = c(
    "2023-01-01", "2023-02-01",
    "2023-01-15", "2023-02-15",
    "2023-02-17", "2023-02-17",
    "2023-03-01"
  ),
  End = c(
    "2023-02-01", "2023-02-15",
    "2023-01-27", "2023-02-20",
    "2023-03-01", "2023-03-17",
    "2023-03-30"
  ),
  Complete = c(TRUE, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE)
)
df$Start <- ymd(df$Start)
df$End <- ymd(df$End)
df.melt <- df %>%
  tidyr::pivot_longer(col = c(Start, End))

today <- as.Date("2022-12-25")
# For live tracking you can use the current date using Sys.Date as shown below
# today <- Sys.Date()

# First Chart
pl <- ggplot(df.melt, aes(x = value, y = Stage, colour = Complete))
pl <- pl + geom_line(alpha = 0.5, size = 7)
pl <- pl + geom_label(aes(label = format(value, "%d %b")), vjust = -0.5, angle = 45, size = 3, color = "black")
pl <- pl + theme_bw()
pl <- pl + geom_vline(xintercept = today, color = "grey", size = 2, alpha = 0.5)
pl <- pl + labs(title = "Gantt Chart")
pl <- pl + labs(subtitle = "created in ggplot #techanswers88")
pl <- pl + labs(caption = "#techanswers88")
pl <- pl + labs(x = "Date")
pl <- pl + labs(y = "Items")
pl <- pl + scale_color_manual(values = c("red", "blue"))
pl <- pl + theme(legend.position = "none")
pl <- pl + scale_x_date(
  name = "Dates",
  date_labels = "%d %b",
  date_breaks = "1 week",
  minor_breaks = "1 day",
  sec.axis = dup_axis(name = "Week number", labels = scales::date_format("%W"))
)
pl

# Second Chart
pl <- ggplot(df.melt, aes(x = value, y = Stage, colour = Complete))
pl <- pl + geom_line(alpha = 0.5, size = 7)
pl <- pl + geom_label(aes(label = format(value, "%d %b")), vjust = -0.5, angle = 45, size = 3, color = "black")
pl <- pl + theme_bw()
pl <- pl + geom_vline(xintercept = today, color = "grey", size = 2, alpha = 0.5)
pl <- pl + labs(title = "Gantt Chart")
pl <- pl + labs(subtitle = "created in ggplot #techanswers88")
pl <- pl + labs(caption = "#techanswers88")
pl <- pl + labs(x = "Date")
pl <- pl + labs(y = "Items")
pl <- pl + scale_color_manual(values = c("red", "blue"))
pl <- pl + theme(legend.position = "none")
pl <- pl + scale_x_date(
  name = "Dates",
  date_labels = "%d %b",
  date_breaks = "1 week",
  minor_breaks = "1 day",
  sec.axis = dup_axis(name = "Week number", labels = scales::date_format("%W"))
)
pl

# Third Chart
pl <- ggplot(df.melt, aes(x = value, y = Stage, colour = Complete))
pl <- pl + geom_line(alpha = 0.2, size = 10)
pl <- pl + geom_text(aes(label = format(value, "%d %b")), vjust = -0.5, angle = 45, size = 3, color = "black")
pl <- pl + theme_classic()
pl <- pl + geom_vline(xintercept = today, color = "red", size = 2, alpha = 0.5)
pl <- pl + labs(title = "Gantt Chart")
pl <- pl + labs(subtitle = "created in ggplot #techanswers88")
pl <- pl + labs(caption = "#techanswers88")
pl <- pl + labs(x = "Date")
pl <- pl + labs(y = "Items")
pl <- pl + scale_color_manual(values = c("red", "blue"))
pl <- pl + theme(legend.position = "none")
pl <- pl + theme(panel.background = element_rect(color = "black"))
pl <- pl + scale_x_date(
  name = "Dates",
  date_labels = "%d %b",
  date_breaks = "1 week",
  minor_breaks = "1 day",
  sec.axis = dup_axis(name = "Week number", labels = scales::date_format("%W"))
)
pl

# Fourth Chart
pl <- ggplot(df.melt, aes(x = value, y = Stage, colour = Complete))
pl <- pl + geom_line(alpha = 0.2, size = 10)
pl <- pl + geom_text(aes(label = format(value, "%d %b")), vjust = 0, angle = 0, size = 3, color = "black")
pl <- pl + theme_gray()
pl <- pl + geom_vline(xintercept = today, color = "red", size = 2, alpha = 0.5)
pl <- pl + labs(title = "Gantt Chart")
pl <- pl + labs(subtitle = "created in ggplot #techanswers88")
pl <- pl + labs(caption = "#techanswers88")
pl <- pl + labs(x = "Date")
pl <- pl + labs(y = "Items")
pl <- pl + scale_color_manual(values = c("red", "blue"))
pl <- pl + theme(legend.position = "none")
pl <- pl + scale_x_date(
  name = "Dates",
  date_labels = "%d %b",
  date_breaks = "1 week",
  minor_breaks = "1 day",
  sec.axis = dup_axis(name = "Week number", labels = scales::date_format("%W"))
)
pl


# You can use this snippet to save your chart to a powerpoint file
library(officer)
my_pres <- read_pptx()
my_pres <- add_slide(my_pres, layout = "Title and Content", master = "Office Theme")
my_pres <- ph_with(x = my_pres, value = pl, location = ph_location_fullsize())
print(my_pres, target = "./gantt charts in ggplot.pptx") # give your folder location and file name
