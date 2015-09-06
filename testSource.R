# testSource


# Load the library

require(RCurl)

# Provide the web address of the file:

fileURL <- getURL('https://raw.githubusercontent.com/SCBI-MigBirds/MigBirds/master/data/exampleBirdData.csv')

# Read in the data:

birdCounts <- read.csv(text = fileURL)

birdCounts
