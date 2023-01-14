library(ggplot2)
library(ggimage)

get_plot <- function(x) {
  x %>% 
    ggplot(aes(x = as.character(Date), y = prob, fill = home_flag)) +
    geom_bar(stat = 'identity') + 
    theme(axis.text.x = element_text(angle = 45, hjust=1),
          axis.title.x = element_blank()) +
    geom_image(aes(image = img))
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
