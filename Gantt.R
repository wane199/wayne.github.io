# [create beautiful GANTT Chart in R with progress tracking.](https://www.youtube.com/watch?v=evHOtG0wDIs)
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
    "Chapter1/Review Literature", "Chapter2/Task 1: Classification",
    "Chapter3/Task 2: Survival Analysis",
    "Write Paper: Cox-nomogram"
  ),
  Start = c(
    "2022-12-01", "2022-12-01",
    "2022-12-17",
    "2022-12-21"
  ),
  End = c(
    "2023-01-20", "2023-01-25",
    "2023-01-30", 
    "2023-01-15"
  ),
  Complete = c(FALSE, FALSE, FALSE, FALSE)
)
df$Start <- ymd(df$Start)
df$End <- ymd(df$End)
df.melt <- df %>%
  tidyr::pivot_longer(col = c(Start, End))

today <- as.Date("2023-01-09")
# For live tracking you can use the current date using Sys.Date as shown below
# today <- Sys.Date()

# First Chart
pl <- ggplot(df.melt, aes(x = value, y = Stage, colour = Complete))
pl <- pl + geom_line(alpha = 0.5, size = 7)
pl <- pl + geom_label(aes(label = format(value, "%d %b")), vjust = -0.5, angle = 45, size = 3, color = "black")
pl <- pl + theme_bw()
pl <- pl + geom_vline(xintercept = today, color = "grey", size = 2, alpha = 0.5)
pl <- pl + labs(title = "项目进度")
pl <- pl + labs(subtitle = "Ceated by Huanhua_Wu")
pl <- pl + labs(caption = "")
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
pl <- pl + geom_vline(xintercept = today, color = "black", size = 2, alpha = 0.5)
pl <- pl + labs(title = "论文进度")
pl <- pl + labs(subtitle = "Ceated by Huanhua_Wu")
pl <- pl + labs(caption = "")
pl <- pl + labs(x = "Date")
pl <- pl + labs(y = "Items")
pl <- pl + scale_color_manual(values = c("orange", "blue"))
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
pl <- pl + labs(title = "论文进度")
pl <- pl + labs(subtitle = "Created by Huanhua_Wu")
pl <- pl + labs(caption = "")
pl <- pl + labs(x = "Date")
pl <- pl + labs(y = "Items")
pl <- pl + scale_color_manual(values = c("blue"))
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
library(export)
graph2pdf(file="gantt.pdf",width=15,font="GB1")

# Fourth Chart
pl <- ggplot(df.melt, aes(x = value, y = Stage, colour = Complete))
pl <- pl + geom_line(alpha = 0.2, size = 10)
pl <- pl + geom_text(aes(label = format(value, "%d %b")), vjust = 0, angle = 0, size = 3, color = "black")
pl <- pl + theme_gray()
pl <- pl + geom_vline(xintercept = today, color = "red", size = 2, alpha = 0.5)
pl <- pl + labs(title = "论文进度")
pl <- pl + labs(subtitle = "Ceated by Huanhua_Wu")
pl <- pl + labs(caption = "")
pl <- pl + labs(x = "Date")
pl <- pl + labs(y = "Items")
pl <- pl + scale_color_manual(values = c("blue")) # "red",
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
