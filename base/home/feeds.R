require(xml2)
require(RCurl)
require(lubridate)

safe_xml_find_first <- safely(xml_find_first)
safe_xml_find_all <- safely(xml_find_all)

safe_run <- function(res) {
  if (is.null(res$error)) {
    ret <- res$result
  } else {
    ret <- read_xml("<p></p>")
  }
  return(ret)
}

safe_xml_feed <- function(url){
  doc = NULL
  while(is.null(doc)) {
    if(url.exists(url)){
      doc <- try(read_xml(url))}
  }
  return(doc)
}

formats <- c("a d b Y H:M:S z", "a, d b Y H:M z",
             "Y-m-d H:M:S z", "d b Y H:M:S",
             "d b Y H:M:S z", "a b d H:M:S z Y",
             "a b dH:M:S Y")

googleRSS <- function(feed){
  
  doc <- safe_xml_feed(feed)
  
  channel <- xml_find_all(doc, "channel")
  
  site <- xml_find_all(channel, "item")
  
  tibble(
    feed_link = safe_xml_find_first(channel, "link") %>%
      safe_run() %>%
      xml_text(),
    feed_description = safe_xml_find_first(channel, "description") %>%
      safe_run() %>%
      xml_text(),
    feed_last_updated = safe_xml_find_first(channel, "lastBuildDate") %>%
      safe_run() %>%
      xml_text() %>%
      parse_date_time(orders = formats),
    feed_language = safe_xml_find_first(channel, "language") %>%
      safe_run() %>%
      xml_text(),
    item_title = safe_xml_find_first(site, "title") %>%
      safe_run() %>%
      xml_text(),
    item_date_published = safe_xml_find_first(site, "pubDate") %>%
      safe_run() %>%
      xml_text() %>%
      parse_date_time(orders = formats),
    item_description = safe_xml_find_first(site, "description") %>%
      safe_run() %>%
      xml_text(),
    item_link = safe_xml_find_first(site, "link") %>%
      safe_run() %>%
      xml_text()
  )
}


safe_html_feed <- function(url){
  doc = NULL
  while(is.null(doc)) {
    if(url.exists(url)){
      doc <- try(read_html(url))}
  }
  return(doc)
}


redditRSS <- function(feed){
  
  doc <- safe_html_feed(feed)
  
  tibble(
    item_title = html_nodes(doc, "title") %>%
      html_text(),
    item_link = html_nodes(doc, "link") %>%
      map(xml_attrs) %>%
      map_df(~as.list(.)) %>%
      slice(-1) %>%
      .$href
  )
}


listScrape <- function(url, li, a) {
  
  doc <- read_html(url)
  
  tibble(
    item_title = html_nodes(doc, li) %>%
      html_text() %>%
      trimws(),
    item_link = html_nodes(doc, a) %>%
      html_attr('href') %>%
      trimws()
  )
}
