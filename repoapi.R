url <- "https://api.github.com/users/jtleek/repos"
response <- GET(url)
data <- content(response, "text")   # response ko text form me lo
repos <- fromJSON(data) 

repos[repos$name == "datasharing", c("name", "created_at")]