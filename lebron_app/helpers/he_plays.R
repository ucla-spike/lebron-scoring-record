source('./data_read.R')

he_plays <- function() {
  mu_ppg <- mean(df[df$game_played_flag == 1, 'points_clean'], na.rm = T)
  sd_ppg <- sd(df[df$game_played_flag == 1, 'points_clean'], na.rm = T)
  plays_rng <- sample(c(0, 1), prob = c(1-mu_ppg, mu_ppg), size = 1, replace = F)
  if (plays_rng == 1) {
    score <- round(rnorm(1, mean = mu_ppg, sd = sd_ppg))
  } else {
    score <- 0
  }
  score
}