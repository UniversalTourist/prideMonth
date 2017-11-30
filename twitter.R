# Pride Tweet Analysis
library(rtweet)
library(dplyr)
library(tidytext)
library(stringr)
library(purrr)
library(janitor)
library(fuzzyjoin)
library(rms)
library(gridSVG)
library(webshot)
library(gganimate)
library(ggimage)
library(magick)
library(knitr)

tweetsPride <- search_tweets(q = '#pridemonth', n = 10000, include_rts = FALSE, parse = TRUE)
                           
cleanTweetsPride <- janitor::remove_empty_cols(tweetsPride)
readr::write_csv(cleanTweetsPride, path = "PrideTweets.csv")

tidyTweetPride <- cleanTweetsPride %>% 
  select(screen_name, user_id, created_at, status_id, text,
         retweet_count, favorite_count, hashtags, source)

# Basic descriptions
# What is the most retweeted tweet?
mostRetweeted <- tidyTweetPride %>% arrange(desc(retweet_count)) %>% select(text) %>% head(1)

getURLinsideTweet <- gsub(".*(https://)", "https://",mostRetweeted$text)
browseURL(getURLinsideTweet)


# What is the most favorited tweet?
mostFavourited <- tidyTweetPride %>% arrange(desc(favorite_count)) %>% select(text) %>% head(1) 
getURLinsideFavTweet <- gsub(".*(https://)", "https://",mostFavourited$text)
browseURL(getURLinsideFavTweet)

# What are the most used hashtags?
tidy_hashtags <- tidyTweetPride %>% unnest_tokens(newhashtags, hashtags) 

tidy_hashtags <- tidy_hashtags %>%
  count(newhashtags, sort = TRUE) %>% top_n(n = 10, wt = n)

q <- ggplot(data = tidy_hashtags) + 
  geom_bar(aes(x = reorder(newhashtags, -n), y = n), 
           stat = "identity", fill = rainbow(n=length(tidy_hashtags$newhashtags))) + 
  theme_bw() + 
  ylab("Hashtag Count") + xlab("Hashtags")

q + theme(axis.text.x = element_text(angle = 60, hjust = 1))

## load in the emoji dictionary
dico <- readr::read_csv2("https://raw.githubusercontent.com/today-is-a-good-day/emojis/master/emDict.csv")

# get emojis
emojis <- regex_left_join(tidyTweetPride, dico, by = c(text = "Native")) %>%
  group_by(Native) %>%
  filter(!is.na(Native)) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(15) %>%
  mutate(num = 1:15)

#readr::write_csv(emojis, path = "emojisFreq.csv")
