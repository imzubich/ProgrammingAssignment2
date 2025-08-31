download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",
              destfile = "zubair.xlsx", mode = "wb")


dat <- read_excel("zubair.xlsx",
                  range = "G18:O23")
