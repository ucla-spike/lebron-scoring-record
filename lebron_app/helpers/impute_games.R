impute_game <- function(type = 'Inactive', num_games = 1, opps, dates,
                        pts = 30, career_pts) {
  game_log <- game_log[-seq_len(num_games), ]
  game_log$game_number <- seq_len(nrow(game_log))
  temp <- df[nrow(df), ]
  temp$Opp <- opps
  if (type == 'Inactive') {
    temp$points_clean <- NA
    temp$game_played_flag <- 0
    temp$Date <- as.Date(dates)
    temp[, 9:30] <- 'Inactive'
    df <- rbind(df, temp)
    final <- list('df' = df, 'game_log' = game_log)
  } else if(type == 'Active') {
    temp$points_clean <- pts
    temp$game_played_flag <- 1
    temp$Date <- as.Date(dates)
    temp[, 9:30] <- NA # Leave as NA's for now
    df <- rbind(df, temp)
    career_pts = career_pts + sum(pts, na.rm = T)
    final <- list('df' = df, 'game_log' = game_log, 'career_pts' = career_pts)
  } else {
    stop(message('Wrong type.'))
  }
  final
}

