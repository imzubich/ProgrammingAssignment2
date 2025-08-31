fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(fileurl, destfile = "./zubair.csv")

getwd()

head("zubair.csv")

data <- read.csv("zubair.csv")

fileurl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"

download.file(fileurl1, destfile = "./codebood.csv")

data1 <- read.csv("codebook.csv")
head(data1)

million_homes <- data[data$VAL == 24, ]

# Count karna
nrow(million_homes)


# Sirf housing units
valid_data <- data[data$TYPE == 1, ]

# Sirf owner-occupied (mortgage ya free)
owner_data <- valid_data[valid_data$TEN %in% c(1, 2), ]

# Million+ properties
million_homes <- owner_data[owner_data$VAL == 24, ]

# Count
nrow(million_homes)

