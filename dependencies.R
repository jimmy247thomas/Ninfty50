# dependencies.R
list.of.packages <- c("shiny", "quantmod", "ggplot2", "lubridate", "DT", "shinydashboard", "scales")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(shiny)
library(quantmod)
library(ggplot2)
library(lubridate)
library(DT)
library(shinydashboard)
library(scales)
