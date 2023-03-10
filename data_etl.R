library(tidyverse)
source('./lebron_app/helpers/get_br.R')
# Read in data
rs_2020 <- read.csv('./data/rs_2020.csv')
rs_2020$YR <- '2020'
rs_2021 <- read.csv('./data/rs_2021.csv')
rs_2021$YR <- '2021'
rs_2022 <- read.csv('./data/rs_2022.csv')
rs_2022$YR <- '2022'
# 2023 is live, so get this using rvest
rs_2023 <- get_br('https://www.basketball-reference.com/players/j/jamesle01/gamelog/2023',
                  '#pgl_basic > tbody')
names(rs_2023) <- names(rs_2020)[-31]
rs_2023$YR <- '2023'

df <- rbind(rs_2020, rs_2021, rs_2022, rs_2023)
df$Date <- as.Date(df$Date)
df <- df[df$PTS != 'PTS', ]
df$points_clean <- as.numeric(with(df, ifelse(PTS %in% c('Inactive', 'Did Not Dress', 'Not With Team'), NA, PTS)))
df$game_played_flag <- with(df, ifelse(PTS %in% c('Inactive', 'Did Not Dress', 'Not With Team'), 0, 1))

saveRDS(df, './lebron_app/data/df.RDS')
# Read in the schedule
sched <- get_br("https://www.basketball-reference.com/teams/LAL/2023_games.html", css_selector = '#games > tbody')
# Clean some elements of the schedule
names(sched)[c(1, 2, 6, 7, 8)] <- c('Game', 'Date', 'Loc', 'Opp', 'Result')
sched <- sched[sched$Date != 'Date', ]
sched$Date <- as.Date(sched$Date, format = '%a, %b %d, %Y')
sched$home_flag <- with(sched, ifelse(Loc == '@', 'Away', 'Home'))
sched$img <- paste('./images/', sched$Opp, '.png', sep = '')
saveRDS(sched, './lebron_app/data/sched.RDS')
# Get lebron's career points using rvest
career_pts <- get_br(url = 'https://www.basketball-reference.com/players/j/jamesle01.html',
                     '#totals > tfoot')[1, 30][[1]]
saveRDS(career_pts, './lebron_app/data/career_pts.RDS')
# Modify game_log to be used for the run_sim() function

game_log <- sched[sched$Result == '', ]
game_log$game_number <- 1:nrow(game_log)
game_log$points_left <- NA
saveRDS(game_log, './lebron_app/data/game_log.RDS')