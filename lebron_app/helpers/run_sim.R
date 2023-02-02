run_sim <-
  function(year,
           mu_play,
           ppg_shape,
           ppg_scale,
           career_pts) {
    # Wrapper to run he_plays multiple times
    points_left <- 38387 - career_pts + 1
    i <- 1
    while (points_left > 0) {
      this_score <- he_plays(year, mu_play, ppg_shape, ppg_scale)
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
