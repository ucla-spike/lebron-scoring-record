library(ggplot2)

fin %>% 
  ggplot(aes(x = as.character(Date), y = prob, fill = home_flag)) +
  geom_bar(stat = 'identity') +
