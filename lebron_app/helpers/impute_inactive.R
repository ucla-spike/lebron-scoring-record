impute_inactive <- function(games_to_miss = 1) {
  game_log <- game_log[-seq_len(games_to_miss), ]
  game_log$game_number <- seq_len(nrow(game_log))
  temp <- df[nrow(df), ]
  temp$Opp <- 'BKN'
  temp$points_clean <- NA
  temp$game_played_flag <- 0
  temp$Date <- as.Date('2023-01-30')
  temp[, 9:30] <- 'Inactive'
  df <- rbind(df, temp)
  list('df' = df, 'game_log' = game_log)
}

game_log <- impute_inactive()$game_log
df <- impute_inactive()$df
