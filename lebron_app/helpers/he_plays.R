he_plays <- function(year, mu_play, ppg_shape, ppg_scale) {
  plays_rng <- sample(c(0, 1), prob = c(1-mu_play, mu_play), size = 1, replace = F)
  if (plays_rng == 1) {
    score <- round(rgamma(1, shape = ppg_shape, scale = ppg_scale))
  } else {
    score <- 0
  }
  score
}
