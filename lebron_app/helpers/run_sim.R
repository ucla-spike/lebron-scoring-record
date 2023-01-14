source('./helpers/data_read.R')
source('./helpers/he_plays.R')
run_sim <- function(career_pts) {
  game_log <- sched[sched$Result == '', ]
  game_log$game_number <- 1:nrow(game_log)
  game_log$points_left <- NA
  points_left <- 38387 - career_pts
  i <- 1
  while(points_left > 0) {
    this_score <- he_plays()
    if (points_left < this_score) {
      game_log[i, 'points_left'] <- 0
      points_left <- 0
      break
    } else {
      game_log[i, 'points_left'] <- points_left - this_score
      points_left <- points_left - this_score
      i <- i + 1
    }
  }
  i
}