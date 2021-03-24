make_plot <- function(data){
  ggplot(data) +
  aes(x = language, y = relative_perc) +
  geom_col() +
  scale_y_continuous(breaks = seq(0, 1, 0.2), limits = c(0, 1)) +
  theme(
      axis.title = element_blank()
  ) +
  coord_flip() 
}