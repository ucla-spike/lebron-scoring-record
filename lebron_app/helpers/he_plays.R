source('./helpers/data_read.R')

he_plays <- function(year) {
  df <- df[df$YR %in% year, ]
  mu_play <- mean(df$game_played_flag, na.rm = T)
  mu_ppg <- mean(df[df$game_played_flag == 1, 'points_clean'], na.rm = T)
  sd_ppg <- sd(df[df$game_played_flag == 1, 'points_clean'], na.rm = T)
  plays_rng <- sample(c(0, 1), prob = c(1-mu_play, mu_play), size = 1, replace = F)
  if (plays_rng == 1) {
    score <- round(rnorm(1, mean = mu_ppg, sd = sd_ppg))
  } else {
    score <- 0
  }
  score
}