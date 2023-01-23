mc_lebron <- function(n, year = c('2021', '2022', '2023')) {
  # Wrapper function for run_sim to replicate n times and clean results
  # Get meta data to pass into the other functions
  sub_df <- df[df$YR %in% year, ]
  # Since we subset df to only include necessary years now, we can 
  mu_play <- mean(sub_df$game_played_flag, na.rm = T)
  ppg_shape <- egamma(sub_df[!is.na(sub_df$points_clean),
                         'points_clean'])$parameter[1]
  ppg_scale <- egamma(sub_df[!is.na(sub_df$points_clean),
                         'points_clean'])$parameter[2]
  
  # Run the simulation
  results <- replicate(n, run_sim(year, mu_play, ppg_shape,
                                  ppg_scale, career_pts))
  # Put results in a data frame (count and summarise first)
  results_df <- data.frame(game_number = as.integer(names(table(results))),
                           prob = as.integer(table(results))/n)
  # Join results to game_log to see what game number this corresponds to
  fin <- left_join(game_log, results_df, by = 'game_number')
  # Replace NA's with 0's
  fin[is.na(fin$prob), 'prob'] <- 0
  # Get prob as a percent
  fin$prob <- fin$prob * 100
  # Clean dates for formatting in graph
  fin$date_cleaned <- format(as.Date(fin$Date,format="%Y-%m-%d"),
                           format = "%m-%d")
  fin
}
