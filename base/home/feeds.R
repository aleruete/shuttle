require(xml2)
require(XML)
require(httr)
# require(RCurl)
# require(lubridate)

safe_xml_find_first <- safely(xml_find_first)
safe_xml_find_all <- safely(xml_find_all)
safe_GET <- safely(GET)

GET_result <- function(x) {
  doc = safe_GET(x)
  res = doc$result
  res
}

GET_content <- function(res) {
  res$content
}

GET_type <- function(res) {
  res$headers$`content-type`
}


type_check <- function(res) {
GET_type(res) %>%
  case_when(
    grepl(x = content_type, pattern = "application/xml") ~ "xml_feed",
    grepl(x = content_type, pattern = "text/xml") ~ "xml_feed",
    grepl(x = content_type, pattern = "application/rss\\+xml") ~ "html_feed",
    grepl(x = content_type, pattern = "application/atom\\+xml") ~ "html_feed",
    TRUE ~ "read_html"
  )
}


clean_tibble <- function(tb) {
  tb %>%
    lapply(., function(x) gsub("[^\u0009\u000a\u000d\u0020-\uD7FF\uE000-\uFFFD]", "", x)) %>%
    lapply(., function(x) gsub("[[:cntrl:]]", "", x)) %>%
    lapply(., function(x) gsub("\u00E2", "'", x)) %>%
    as_tibble()
}


xml_feed <- function(url){
  doc = NULL
  while(is.null(doc)) {
    if(!http_error(url)){
      doc <- try(
        GET_result(url) %>%
          GET_content() %>%
          read_xml()
      )}
  }
  return(doc)
}


ExtractRSS <- function(feed){
  
  doc <- xml_feed(feed)
  
  channel <- xml_find_all(doc, "channel")
  
  site <- xml_find_all(channel, "item")
  
  tibble(
    item_title = safe_xml_find_first(site, "title") %>%
      .$result %>%
      xml_text(),
    item_link = safe_xml_find_first(site, "link") %>%
      .$result %>%
      xml_text()
  ) %>%
    clean_tibble()
}


html_feed <- function(url){
  doc = NULL
  while(is.null(doc)) {
      doc <- try(
          read_html(url)
        )}
  return(doc)
}


redditRSS <- function(feed){
  
  doc <- html_feed(feed)
  
  tibble(
    item_title = html_nodes(doc, "title") %>%
      html_text(),
    item_link = html_nodes(doc, "link") %>%
      map(xml_attrs) %>%
      map_df(~as.list(.)) %>%
      slice(-1) %>%
      .$href
  ) %>%
    clean_tibble()
}


kdRSS <- function(feed){
  
  doc <- html_feed(feed)
  
  tibble(
    item_title = html_nodes(doc, "title") %>%
      html_text(),
    item_link = html_nodes(doc, "link") %>%
      map(xml_attrs) %>%
      map_df(~as.list(.)) %>%
      .$href
  ) %>%
    clean_tibble()
}


soRSS <- function(feed){
  
  doc <- html_feed(feed)
  
  tibble(
    item_title = html_nodes(doc, "title") %>%
      html_text(),
    item_link = html_nodes(doc, "link") %>%
      map(xml_attrs) %>%
      map_df(~as.list(.)) %>%
      slice(-1) %>%
      .$href
  ) %>%
    clean_tibble()

}


listScrape <- function(url, li, a) {
  
  doc <- html_feed(url)
  
  tibble(
    item_title = html_nodes(doc, li) %>%
      html_text() %>%
      trimws(),
    item_link = html_nodes(doc, a) %>%
      html_attr('href') %>%
      trimws()
  ) %>%
    clean_tibble()
}
