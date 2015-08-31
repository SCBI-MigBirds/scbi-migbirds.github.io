### OPTIONAL!

Three simple words have a surprising tendency to strike fear into the hearts of intermediate R users ... nested ... for ... loops (<A HREF="http://soundbible.com/2090-Night-Time-Storm.html">link</a>). Nested for loops are not fundamentally different from for loops -- to explain how they work, let's take a look at what should be a now familiar subset of the bird counts data frame:

```{r, eval=FALSE}
birdCounts[birdCounts$foraging == 'bark',]
```

Let's use a for loop to subset the data for each foraging guild. This time let's turn our output into a list of data frames (note that list elements are called using double backets "[[ ]]"):

```{r, eval=FALSE}
foragingGuilds <- unique(birdCounts$foraging)

foragingList <- list(length = length(foragingGuilds))

for(i in 1:length(foragingGuilds)){
  foragingList[[i]] <- birdCounts[birdCounts$foraging == foragingGuilds[i],]
}

foragingList[[3]]

```

We now have a list of data frame objects, one for each foraging guild. We can name each of the data frames by the guild they represent, and call the list object by name:

```{r, eval=FALSE}
names(foragingList) <- foragingGuilds

foragingList[['bark']]
```

Perhaps we would now like to get counts of represented across sites for each foraging guild. This is where the nested _for loop_ comes in. Prior to adding the nested component of the loop, let's see how a non-nested _for loop_ would extract this information for just bark-foraging species. First, we'll extract a unique vector of species, then create an empty data frame to store the results:

```{r, eval=FALSE}
barkForagingSpecies <- unique(foragingList[['bark']]$species)

barkForagingSpeciesCounts <- data.frame(guild = 'bark', species = barkForagingSpecies, count =0)

barkForagingSpeciesCounts
```

Next, we'll population our data frame the species counts using a (non-nested) _for loop_. To help clarify the output, I've included broken the subset _for instructions_ below into multiple steps. 

1. Bark foragers are subset from the list
2. The species for which the counts will be summed are isolated
3. The data frame is subset into just target species
4. The count column is summed.

```{r, eval=FALSE}
for (i in 1:length(barkForagingSpecies)){
  foragingSubsetFrame <- foragingList[['bark']]
  
  targetSpecies <- barkForagingSpecies[i]
  
  speciesSubsetFrame <- foragingSubsetFrame[foragingSubsetFrame$species  == targetSpecies,]
  
  barkForagingSpeciesCounts$count[i] <- sum(speciesSubsetFrame$count)
}
```

The nested _for loop_ will allow to calculate the above for each of the foraging guilds simultaneously. To do so, we start the foraging list loop. Within that loop, we specify a new position, _j_, that represents each species within a guild. The remaining steps are unchanged. To help clarify, I've added comments above each step:


```{r, eval=FALSE}
# Get unique guilds and make an empty list that the loop will population:

foragingGuilds <- unique(birdCounts$foraging)

foragingList <- list(length = length(foragingGuilds))

# Set the for loop initialization:

for(i in 1:length(foragingGuilds)){
  
  # Subset the bird counts data frame to just the guild in question:
  
  foragingSubsetFrame <- birdCounts[birdCounts$foraging == foragingGuilds[i],]
  
  # Get a unique vector of species for the selected guild:
  
  foragingSpecies <- unique(foragingSubsetFrame$species)
  
  # Create a data frame where the results will be stored:
  
  foragingSpeciesCounts <- data.frame(guild = foragingGuilds[i], species = foragingSpecies, count =0)
  
  # Run a for loop to fill the species column for this data frame:
  
    for (j in 1:length(foragingSpecies)){

      targetSpecies <- foragingSpecies[j]
      
      speciesSubsetFrame <- foragingSubsetFrame[foragingSubsetFrame$species  == targetSpecies,]
      
      foragingSpeciesCounts$count[j] <- sum(speciesSubsetFrame$count)
}
  # Store output within the list:
  
    foragingList[[i]] <- foragingSpeciesCounts
}

names(foragingList) <- foragingGuilds

```

Let's take a look at the output

```{r, eval=FALSE}
foragingList[['ground']]

foragingList[['foliage']]

foragingList[['bark']]

foragingList[['aerial']]
```

If we'd like to simplify the output, we can turn the entire foragingList into a data frame using the "do.call" function (execute a function call) in conjunction with the "rbind" function (bind rows):

```{r, eval=FALSE}
do.call(rbind, foragingList)
```

----

> **OPTIONAL exercise:**
>
> Create a nested for loop that will calculate the sum of diet and foraging guilds across sites.
