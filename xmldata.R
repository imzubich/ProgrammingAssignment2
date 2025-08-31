fileurl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

tempfile <- tempfile()
download.file(fileurl2, tempfile, mode = "wb")

# Step 2: parse the XML from the downloaded file
doc <- xmlTreeParse(tempfile, useInternalNodes = TRUE)

# Step 3: extract root node
rootNode <- xmlRoot(doc)


# XPath expression use karke filter
zipcode_nodes <- xpathSApply(rootNode, "//row[zipcode='21231']", xmlValue)
length(zipcode_nodes)

