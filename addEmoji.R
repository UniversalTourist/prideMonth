#source("https://bioconductor.org/biocLite.R")
#biocLite("EBImage")
#install.packages("ggimage")
library(ggimage)

newEmojis <- data.frame(numberofEmojis = c(1591, 590, 385, 371, 319, 310, 109, 90, 74, 67, 58, 51, 50, 48, 45),
                        orderofEmojis = c(1:15),
                        image = c("/Users/hazelkavili/Desktop/prideMonth/file/1591rainbow.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/590blackheart.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/385purpleheart.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/371blueheart.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/319yellowheart.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/310greenheart.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/109eyeswithheart.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/90twopink.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/74sparkling.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/67tearsofjoy.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/58sparks.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/51twowomen.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/50twomen.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/48growingheart.png",
                                  "/Users/hazelkavili/Desktop/prideMonth/file/45sendingkiss.png"
                                  ))


p <- ggplot(newEmojis, aes(y = numberofEmojis, x = orderofEmojis)) + 
  geom_image(aes(image = image), size = .04) +
  ylab("Number of Emojis") + xlab("Order of Emojis") + 
  theme_gray()

p +  scale_x_continuous(breaks = c(2,4,6,8,10,12,14))




