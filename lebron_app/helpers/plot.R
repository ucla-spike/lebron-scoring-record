library(ggplot2)
library(ggimage)

get_plot <- function(x) {
  x %>% 
    filter(prob > 0.01) %>% 
    ggplot(aes(x = date_cleaned, y = prob, fill = home_flag)) +
    geom_bar(stat = 'identity', width = .95) + 
    theme(axis.text.x = element_text(angle = 45, hjust=1, size = 12),
          axis.title.y = element_text(size = 12),
          axis.title.x = element_blank(),
          title = element_text(size = 18),
          legend.position = c(.90, .80),
          legend.key.size = unit(2, 'cm'),
          legend.text = element_text(size = 12)) +
    ylab('Probability (%)') +
    ggtitle('10,000 simulations of when LeBron breaks the NBA scoring record') +
    geom_image(aes(image = img), size = .075) +
    scale_x_discrete(breaks = (x$date_cleaned)[c(T, rep(F, 3))]) +
    scale_fill_discrete(name = NULL)
    
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
