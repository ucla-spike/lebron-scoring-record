library(tidyverse)
library(EnvStats)
library(ggimage)
library(ggdark)
library(showtext)
library(ggtext)

df <- readRDS('./lebron_app/data/df.RDS')
sched <- readRDS('./lebron_app/data/sched.RDS')
career_pts <- readRDS('./lebron_app/data/career_pts.RDS')
game_log <- readRDS('./lebron_app/data/game_log.RDS')
source('./lebron_app/helpers/data_etl.R')
source('./lebron_app/helpers/run_sim.R')
source('./lebron_app/helpers/he_plays.R')
source('./lebron_app/helpers/mc_lebron.R')
source('./lebron_app/helpers/plot.R')

# Needed to show the Chivo font
showtext_auto()
# If Chivo font is not installed, run this:
# sysfonts::font_add_google("Chivo")

fin <- mc_lebron(10000, '2023')

png(file = paste('./results_img/update_', Sys.Date(), '.png', sep = ''), width = 1080, height = 700,
    units = 'px')
get_plot(fin)
dev.off()
