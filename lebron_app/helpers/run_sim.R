run_sim <-
  function(year,
           mu_play,
           ppg_shape,
           ppg_scale,
           career_pts,
           pts_next_game) {
    # Wrapper to run he_plays multiple times
    points_left <- 38387 - (career_pts + pts_next_game) + 1
    i <- 1
    
    # if points next game is positive, then it assumes the points of the next game,
    # so that value is known. The simulation then starts from the game after next.
    if (pts_next_game > 0) {
      i <- i + 1
    }
    
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
