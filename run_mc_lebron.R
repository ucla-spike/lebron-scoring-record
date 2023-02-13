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
source('./lebron_app/helpers/impute_games.R')
# If you need to impute values for a game that hasn't been updated in Basketball
# Reference yet use this code (modify as needed):

game_log <- impute_game('Active', opps = 'OKC',
                        dates = '2023-02-07', pts = 38, career_pts = career_pts)$game_log
df <- impute_game('Active', opps = 'OKC',
                  dates = '2023-02-07', pts = 38, career_pts = career_pts)$df
career_pts <- impute_game('Active', opps = 'NYK',
                          dates = '2023-02-07', pts = 38, career_pts = career_pts)$career_pts

# Needed to show the Chivo font
showtext_auto()
# If Chivo font is not installed, run this:
sysfonts::font_add_google("Chivo")

fin <- mc_lebron(10000, '2023')

png(file = paste('./results_img/update_', Sys.Date(), '.png', sep = ''), width = 1080, height = 700,
    units = 'px')
get_plot(fin, 10000)
dev.off()
