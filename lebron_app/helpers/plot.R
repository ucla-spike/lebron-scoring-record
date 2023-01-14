library(ggplot2)

get_plot <- function() {
  fin %>%
    ggplot(aes(
      x = as.character(Date),
      y = prob,
      fill = home_flag
    )) +
    geom_bar(stat = 'identity') +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
          axis.title.x = element_blank()) +
    geom_image(aes(image = img))
}
