library(rvest)
get_br <- function(url, css_selector) {
  final <- url %>%
    read_html() %>%
    html_element(css = css_selector) %>% 
    html_table()
  final
}
