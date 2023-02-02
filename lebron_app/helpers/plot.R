get_plot <- function(x) {
  # Insert if else to decide how to label the plot's subtitle
  # If he didn't play in his most recent game it should be formatted as:
  # Date vs. OPP (Inactive)
  # If he did play, it should be:
  # Date vs, OPP (X pts)
  if (!is.na(df[nrow(df), 'points_clean'])) {
    caboose <- paste(df[nrow(df), 'Opp'],
    " (", df[nrow(df), 'points_clean'],
    " pts)", sep = '')
  } else {
    caboose <- paste(df[nrow(df), 'Opp'],
    " (Inactive)", sep = '')
  }
  pretty_sub_date <- format(df[nrow(df), 'Date'], format = '%b %d')
  psub_final <- paste("Last games: ", pretty_sub_date, ' vs. ',
                      caboose,
                      sep = '')
  # Make the graph itself
  #labels_subset <- x %>% filter(prob > 5) # Filter which to label
  x %>% 
    filter(prob > 0.5) %>% 
    ggplot(aes(x = date_cleaned, y = prob, fill = home_flag)) +
    geom_bar(stat = 'identity', width = .95) +
    ylab('Probability (%)') +
    ggtitle('10,000 simulations of when LeBron breaks the NBA scoring record',
            subtitle = paste(psub_final,
                             ', Jan 30 vs. BKN (Inactive)', sep = '')) +
    geom_image(aes(image = img), size = .125) +
    geom_textbox(inherit.aes = F, aes(x = date_cleaned, y = prob, label = paste(round(prob), '%', sep = '')),
              family = 'Chivo', fill = 'white', col = 'black', size = 10, vjust = -1, height = NULL,
              width = NULL, box.margin = unit(c(0, 0, 0, 0), 'pt'), box.padding = unit(c(.15), 'cm'),
              show.legend = FALSE) +
    scale_x_discrete(breaks = (x$date_cleaned)[c(T, rep(F, 2))]) +
    ylim(0, max(x$prob) + 4) +
    dark_theme_gray() +
    theme(text = element_text(family = 'Chivo'),
          plot.margin = margin(.5, 2, .5, 2, "cm"),
          axis.text.x = element_text(size = 20, colour = 'white'),
          axis.text.y = element_text(size = 20, colour = 'white'),
          axis.ticks = element_line(unit(0, 'pt')),
          axis.title.y = element_text(size = 20),
          axis.title.x = element_blank(),
          title = element_text(size = 18),
          legend.position = c(.9, .85),
          legend.key.size = unit(2, 'cm'),
          legend.text = element_text(size = 18),
          legend.spacing.y = unit(0, 'pt'),
          plot.subtitle = element_text(size = 18),
          panel.grid.major = element_line(color = "grey30", size = 0.2),
          panel.grid.minor = element_line(color = "grey30", size = 0.2)) +
    scale_fill_manual(name = NULL, values = c('#552583', '#FDB927'))
    
}


# fin %>% 
#   ggplot() +
#   geom_col(
#     aes(
#       x = as.character(Date), y = prob,
#       fill = home_flag
#     ),
#     width = 0.4
#   ) + 
#   scale_color_identity(aesthetics =  c("fill", "color")) +
#   geom_vline(xintercept = 0, color = "black", linewidth = 1) +
#   theme_minimal() +
#   scale_x_continuous(breaks = scales::pretty_breaks(n = 10)) +
#   labs(x = "\nQBR",
#        y = NULL,
#        title = "QBR - 2020 Season",
#        subtitle = "Weeks: 1-4",
#        caption = "<br>**Data:** espnscrapeR | **Plot:** @thomas_mock") +
#   theme(
#     text = element_text(family = "Chivo"),
#     panel.grid.minor = element_blank(),
#     panel.grid.major.y = element_blank(),
#     plot.title = element_text(face = "bold", size = 20),
#     plot.subtitle = element_text(size = 16),
#     plot.caption = element_markdown(size = 12),
#     axis.text = element_text(size = 14, face = "bold"),
#     axis.title.x = element_text(size = 16, face = "bold"),
#     axis.text.y = element_text(margin = margin(r = -25, unit = "pt")),
#     axis.ticks.y = element_blank()
#   )
