library(tidyverse)
library(EnvStats)
library(ggimage)

df <- readRDS('./lebron_app/data/df.RDS')
sched <- readRDS('./lebron_app/data/sched.RDS')
career_pts <- readRDS('./lebron_app/data/career_pts.RDS')
game_log <- readRDS('./lebron_app/data/game_log.RDS')
source('./lebron_app/helpers/run_sim.R')
source('./lebron_app/helpers/he_plays.R')
source('./lebron_app/helpers/mc_lebron.R')
source('./lebron_app/helpers/plot.R')

fin <- mc_lebron(10000, '2023')
get_plot(fin)