
---
output: html_document
---

<img style="float:right;padding-right:25px;border:none" src="https://upload.wikimedia.org/wikipedia/en/thumb/e/e3/GMU_logo.svg/1280px-GMU_logo.svg.png" height="150px" width = "150px"/>
    
  <img align = "right" src="https://upload.wikimedia.org/wikipedia/en/6/6a/Smithsonian_Conservation_Biology_Institute_logo.png" height="150px" width = "150px"/>
  
# Introduction to Program R: _Object structure, indexing, and logic_

_Brian S. Evans  
Smithsonian Conservation Biology Institute  
Migratory Bird Center_

This document will introduce you to some of the basic structure of R objects and teach you how to extract data from these objects using a process known as **indexing**. 

We will be conducting all of our R analyses from R Studio. R Studio is a user interface to Program R that can be used to streamline and organize workflow. The interface consists of four primary panes:

![alt text](http://urbanpolicy.net/wp-content/uploads/2014/09/R-Studio_Panel-names.jpg)


The **Source Pane** is where we will write our R code, which is then executed in the **Console Pane**.

## Before we begin:

Open R Studio. Use the keyboard combination _CTRL+SHIFT+N_ to create a new R script. You will notice that there is now a blank script in your **Source Pane**. 

Copy-and-paste the following code into your new script. Highlight the entire section with your mouse and use the keyboard combination _CTRL+R_ to run the code. This will automatically load all of the data and functions we will be using for this lesson.


```r
library(RCurl)

url <-'https://raw.githubusercontent.com/SCBI-MigBirds/MigBirds/master/source/sourceStructureIndexLogic.R'
sourceURL <- getURL(url)

eval(parse(text = sourceURL))
```

Take a look at your Workspace Pane. You will notice that the "Data"" section of the **Global Environment** now includes the R objects "birdCounts", "exampleData", and "exampleData2".

Use the keyboard combination _CTRL+S_ to save this script. Name the file "MigBirdsIndexingAndLogic" and save it to your Dropbox folder.

----

### Functions

The **function** is what Hadley Wickham calls the "fundamental building block of R". Functions are a special type of R object that allow you to conduct often lengthy evaluations with limited work. The R environment contains many functions for data management, graphical display, and statistical analysis. To run a function, you type the name of the function followed by a set of parentheses enclosing what you want your function to evaluate. For example, perhaps you would like to **combine** the integers 1, 1, and 2, as above into a single object. The combine function in R is "c". To combine these values you would type:


```r
threeValuesOneObject <- c(1,1,2)
```

R has comprehensive help files associated with each function. To access the help file for a given function, simply the "?" and then the name of the function. The help file will be displayed in the **View Pane**. For example, the function "sum" adds the values in a vector. To view this function type the following into the Source or Console Pane:


```r
?sum
```

Many functions contain **arguments** in addition to the object you are evaluating. These arguments modify the behavior of the function (_Note: Some arguments are necessary while some are optional_). For example, the function "mean" contains an argument "na.rm" that tells R whether you want to remove NA (data Not Available) prior to running the function. Let's make an object with two integers and an NA and calculate the mean of the data with (na.rm = TRUE) and without (na.rm = FALSE) the modifier argument:


```r
twoValuesWithNA <- c(5,8,NA)

mean(twoValuesWithNA, na.rm = FALSE)

mean(twoValuesWithNA, na.rm = TRUE)
```

Functions can also be **nested** inside other functions. This means that you run a function inside of another function. For example, we could have completed the above mean operation using:


```r
mean(c(5,8,NA), na.rm = TRUE)
```

_In the next lesson, we will learn how to make custom functions in R that can be used to execute specific tasks. For many complex tasks, functions are available in user-built **libraries** (also called **packages**), that are simply collections of custom functions._

----

> **Exercise One:**
>
> 1. Create an object that contains the values 5,8, and 13. 
2. Assign the name "gen1" to the object and use the "sum" function to add these values together.

----

### Classes of R objects

Above, we used combine to create an object that contained multiple integer values. The object that we created and its component values have a unique class structure that defines what type of object they are. R functions may behave quite differently (or fail completely) across classes of objects, thus knowing the type object you are analyzing is often crucial.

#### Common classes of values

There are numerous classes of **values**, however, those that we normally interact with are: 

* **Numeric**: May be decimals or integers
* **Character**: A string of letters of numbers
* **Factor**: Characters that have been assigned an integer value or, in practice, integers with character labels 

As we've only worked with numeric integer values so far, let's create a character value as an example. To do so, you surround the character in single or double quotation marks. For example, to create an R object of the character string "Hello world", you would type:


```r
exampleCharacterValue0 <- "hello world"

exampleCharacterValue0
```

To convert a character value to a factor, you can use the "factor" function. Factor values take up less system memory than characters and can be implemented in statistical modeling as categorical variables. Run the following and note how the output differs from that of the character:


```r
factor(exampleCharacterValue0)
```

We can find out the class of a value by using the function "class":


```r
class(generation1)

class(exampleCharacterValue0)

class(factor(exampleCharacterValue0))
```

#### Common classes of objects containing multiple values

Multiple values may be strung together into a single object, as we did with generation1 above. The class of object we create will depend on the structure of the data and what we intend to do with it.

* **Vector**: A one-dimensional collection of values. All values must be of the same class. If this is not the case, the class of the component values will be modified.


```r
vector1 <- c(1,1,2,3,5,8)

vector1
```

```
## [1] 1 1 2 3 5 8
```

You can determine how many values comprise a vector using the "length" function:


```r
length(vector1)
```

* **Matrix**: A two-dimensional collection of values, arranged as rows and columns. Matrices can essentially be thought as a data structure that combines multiple vectors into a single object. Component vectors MUST be of the same class. If this is not the case, the class of the component values will be modified.

Let's turn vector1 into a two-column matrix using the matrix function. Arguments "ncol" and "nrow" specify the number of columns and rows, respectively, of the matrix:


```r
matrix1 <- matrix(vector1,  nrow = 3, ncol = 2)

matrix1
```

```
##      [,1] [,2]
## [1,]    1    3
## [2,]    1    5
## [3,]    2    8
```

* **Data frame**: A two-dimensional collection of values, arranged as rows and columns. Component vectors may be of different classes -- because of this, data frames are very useful for storing data. For example, banding (ringing) data most often include numeric  (e.g., measurement data) and categorical (e.g., species of bird) variables. Let's create and explore a simple data frame composed of two vectors:


```r
vector1a <- c(1,1,2)
vector2 <- c('a', 'b','c')

dataframe1 <- data.frame(vector1a, vector2)

dataframe1
```

```
##   vector1a vector2
## 1        1       a
## 2        1       b
## 3        2       c
```

To determine the number of rows in a data frame or matrix you can use the "nrow" function:


```r
nrow(dataframe1)
```

To determine the number of columns in a data frame, you can use the "ncol" or "length" function (because the columns of data frames and matrices are vectors):


```r
ncol(dataframe1)

length(dataframe1)
```

And also view the number of rows and columns (values one and two, respectively) in one step using the "dim" function:


```r
dim(dataframe1)
```

It may be unclear whether an object is a vector, matrix, or data frame. If this is the case, you can use "class" as above to determine the class of the object.



```r
class(matrix1)

class(dataframe1)
```

As objects such as data frames may contain multiple object classes, you may be interested in knowing the classes of each of the components. To do so, you use the "str" (structure) function:


```r
str(dataframe1)
```

----

> **Exercise Two:**
>
> 1. Your global environment contains the R objects birdCounts, exampleData, and exampleData2. Use the `class` function to determine the type of object that each represent.
>
> 2. Use the `dim` function to determine the number of rows and columns in birdCounts.
>
> 3. Use the `str` function to determine class structure of birdCounts.

----

### Indexing

Values within an R object such as a vector, matrix, or data frame can be referred to by their location within the object -- this is known as **Indexing**.

#### Indexing vectors

In a vector, the location of a value is identified using brackets ("[ ]"), with the i^th^ location of within a vector, "v", mapped as v[i]. Consider the following vector:

\[\begin{array}
{rrrrrrrrr}
rabbits = 3 & 6 & 9 & 15 & 24 & 39 & 63 \\
\end{array}
\]

Create the vector "rabbits" in R using the combine function.

To extract the second value (6) of the vector rabbits, we would use:


```r
rabbits[2]
```

We can also extract multiple values at a time. To extract the 1^st^ through 3^rd^ values (3, 6, and 9) within rabbits, we separate the starting and ending location values with a ":" symbol:


```r
rabbits[1:3]
```

Or use the combine function to select non-adjacent (or adjacent!) values:


```r
rabbits[c(1,3)]
```

Additionally, we can nest functions within our vector location map. For example, perhaps we're interested in the last value of a vector but the vector is so long that it is unfeasible to count. To address this, we can nest the function "length" within our mapping operation. In the below, notice how the "length" function returns the number of values that make up the vector, which is also the location of the last value:


```r
length(rabbits)

rabbits[7]

rabbits[length(rabbits)]
```

----

> **Exercise Three:**
>
> 1. Extract the fifth value (24) of the rabbits vector.
2. Use the ":" symbol to extract the third through fifth values in the rabbits vector.
3. Use the combine function to extract the third and fifth values in the rabbits vector.

----

#### Indexing matrices and data frames

The location map of values within matrices and data frames are similar to that of vectors but have two components, one representing the row and the other the column. These components are written as [row, column]. To illustrate this, lets take another look at matrix1:


```
##      [,1] [,2]
## [1,]    1    3
## [2,]    1    5
## [3,]    2    8
```

You'll notice that the column location is provided after the the comma at the top of each column. Likewise, the row location is provided before the comma.

You can use this row and column address to extract the value at that location. For example, use the following to determine the value at row three, column one of the matrix:


```r
matrix1[3,1]
```

Notice what happens when you do not provide any address information for matrix1:


```r
matrix1[,]
```

By leaving out the address information on either side of the comma, you are telling R to return all of the rows and all of the columns of matrix1. You can extract a vector representing a single column or row by providing the address of the row or column you are interested in and leaving the other side of the comma blank:


```r
# Example One:

matrix1[1,] # Extracts row one of matrix1

# Example Two. 

matrix1[,1] # Extracts column one of matrix1
```

The above tells R to return all of the values in row one across columns in Example One and all of the values in column two across rows in Example Two. 

Similar to our use of the function "length" in our vector assignment, we can nest the functions "nrow" and "ncol" inside matrix or data frame addresses to extract the vector associated with the last row or column, respectively:


```r
# Example One:

matrix1[nrow(matrix1),] # Extracts the last row of matrix1

# Example Two. 

matrix1[,ncol(matrix1)] # Extracts the last column of matrix1
```

As with vectors, you can use the ":" to extract adjacent columns and rows from data frames and matrices:


```r
dataframe1[2:3,]
```

Or use the combine function to select non-adjacent (or adjacent!) rows or columns:


```r
matrix1[c(1,3),]
```

----

>**Exercise Four:** 
>
> 1. Extract the value at the cell address associated with row two, column two in birdCounts.
2. Extract the vector of values associated with row one of exampleData.
3. Extract the vector of values associated with column two of exampleData.
4. Use the nrow and ncol functions to extract the value contained in the last row and column of birdCounts.
5. Use the ":" symbol to extract the first and second rows of exampleData2.
6. Use the combine function to extract the second and third rows of birdCounts.

----

#### Naming columns and rows and extracting by name

Just as you can assign a name to an object, you can also provide names for the columns or rows of matrices and data frames. This allows you to refer to an object within a matrix or data frame by name rather than just by location. To add names to a dataframe you use the "name" function, followed by a vector of names (in quotations):


```r
names(dataframe1) <- c('popSize', 'population')
```

To add names to a matrix, you use the "colnames" function


```r
colnames(matrix1) <- c('N0', 'N1')
```

You can add names the rows of a matrix or data frame using the "row.names" function:


```r
row.names(dataframe1)<-c('Population.A','Population.B','Population.C')
```

Because names are a vector, you can access a single name or assign a different name using its address within a vector. For example, you could change the name of the second column in dataframe1:


```r
names(dataframe1)

names(dataframe1)[2]

names(dataframe1)[2]<-'N0'

names(dataframe1)
```

Naming columns and rows is useful because you can extract the object from its parent object using the name of the object as its address rather than its numeric location: 


```r
dataframe1[,'N0']

dataframe1['PopulationA',]
```

As a shortcut, you can extract or view columns of a dataframe (but not a matrix) or list elements using the "$":


```r
dataframe1$N0
```

----

> **Exercise Five:**
>
> Use the birdCounts dataset to do the following:
>
> 1. Determine the class of the species field within birdCounts.
>
> 2. Extract the count field of birdCounts as a vector.
> 3. Create a data frame of birdCounts consisting of the first 20 records and assign the name "birdCounts2".
> 4. Change the name of the counts field in birdCounts2 to "abundance".
> 5. Subset birdCount2 to the fields "site",species", "abundance", and "diet". 

----

### Exploring and summarizing data frames

There are a number of useful functions for further exploring the structure of the data.

The function "head" shows the first six rows of birdCounts. If we use the "n" argument, we can specify the number of rows we would like to show in the console:


```r
head(birdCounts)

head(birdCounts, n = 10)
```

You could also extract the first 10 records using the address of the rows. The above is equivalent to:


```r
birdCounts[1:10,]
```

The function "tail" shows the last six rows of data and the "n" argument is used to specify the number of rows:


```r
tail(birdCounts)

tail(birdCounts, n = 10)
```

We may be interested in observing the number of unique factor levels within the object. To do so, we can use the "levels" function (factors only) or "unique" function (any vector data class) to view the number of factor levels for a given vector within the object:


```r
levels(birdCounts$diet)

unique(birdCounts$diet)
```

We can nest the above function in the function "length" to determine how many dietary classes are represented within the dataset:


```r
length(unique(birdCounts$diet))
```

Providing basic summary statistics is often a crucial part of data exploration. Let's view some key summary statistics for the vector birdCounts$count:

* Minimum: `min(birdCounts$count)`
* Maximum: `max(birdCounts$count)`
* Mean: `mean(birdCounts$count)`
* Median: `median(birdCounts$count)`
* Quantile: `quantile(birdCounts$count)`
* Standard deviation: `sd(birdCounts$count)`

Finally, we can view several summary statistics for the dataset across fields using the "summary" function:


```r
summary(birdCounts)
```

----

> **Exercise Six:** For the birdCounts dataset, address the following:
>
> 1. What is the mean count for the birdCounts2 object you created in Exercise 5? 
>
> 2. How many unique species does birdCounts2 contain?

----

### Using logic to subsetting data by value

Recall that we used addresses [row, column] to extract columns and rows above, for example:


```r
birdCounts[,c('foraging', 'count')]
```

In plain English, the code above tells R that you would like to return a subset of birdCounts that includes all of the rows, but only the columns foraging and count. 

You can also specify logical conditions to subset a data frame the values associated with a given field. The logical operators include:

Symbol | Expression | Class
--- | --- | ---
== | Is equal to | numeric, factor, character
!= | Does not equal | numeric, factor, character
< | Less than | numeric
<= | Less than or equal to | numeric
> | Greater than | numeric
>= | Greater than or equal to | numeric
x | y | Or | numeric, factor, character
x & y | And | numeric, factor, character


Before we use logic to subset data frames, let's take a look at what happens when we test a vector with a logical operator. In the following code, we subset the foraging vector to the first 20 entries, and then test which entries matches the term "ground".


```r
foraging2 <- birdCounts$foraging[1:20]

foraging2 == 'ground'
```

We can see that most, but not all, of the foraging2 vector satisfies this condition. If we want to know how many values satisfy this condition, we can use the sum function (TRUE = 1, FALSE = 0):


```r
sum(foraging2 == 'ground')
```

We can also subset the vector foraging2 to only values that satisfy this condition:


```r
foraging2[foraging2 == 'ground']
```

Not a very meaningful result, however, we can use the same principle to subset our birdCounts data frame to include only ground foraging species. In the script below, we are telling R to return all of the columns of the birdCounts frame for which the row values of foraging are equal to ground (_Note: we are returning all columns in which our row condition is TRUE_):


```r
birdCounts[birdCounts$foraging == 'ground',]
```

We can also return a column and row subset using logic. For example, perhaps we are interested in counts of ground foragers. We could return all columns in which the row condition "ground" is true and just the column "count" as:


```r
birdCounts[birdCounts$foraging == 'ground','count']
```

We can use mathematical logical operators, such as our less than or greater than symbols, on our numeric columns. For example, we may be interested only in species counts that are greater than or equal to three:


```r
birdCounts[birdCounts$count >= 3,]
```

Mathematical logical operators can be combined with statistical summary functions. For example, to subset records to only sites that are greater than or equal to the median value of counts:


```r
birdCounts[birdCounts$count >= median(birdCounts$count),]
```

Operators can also be combined. Let's use the "&" symbol to extract rows of birdCounts in which the count is greater than the median and species are ground foragers:


```r
birdCounts[birdCounts$count >= median(birdCounts$count)&birdCounts$foraging == 'ground',]
```

The "or" logical operator can be a bit dangerous. Let's see what happens when we use "|" with the operation above:


```r
birdCounts[birdCounts$count >= median(birdCounts$count)|birdCounts$foraging == 'ground',]
```

The above returned all records for which the count was greater than the median OR the foraging strategy was equal to ground! "Or"" _can_ be quite useful though. For example, we could pull out all records for which foraging stategies are aerial or foliage:


```r
birdCounts[birdCounts$foraging == 'aerial'|birdCounts$foraging == 'foliage',]
```

Note that the above returns a reduced data frame that satisfies our conditions. We can use this to extract a single column of the data frame as well. Let's look at just the counts vector that satisfies the above condition:


```r
birdCounts[birdCounts$foraging == 'aerial'|birdCounts$foraging == 'foliage','count']
```

We can then obtain the average count of aerial and foliage foragers observed (note that this does not include zero observations!):


```r
mean(birdCounts[birdCounts$foraging == 'aerial'|birdCounts$foraging == 'foliage','count'])
```

----

> **Exercise Seven:** For the birdCounts dataset, address the following using the methods above:
>
> 1. Subset the birdCounts data frame to just insectivore species. Call the data frame "insectivoreCounts".
> 
> 2. How many species are insectivores?
>
> 3. How many sites are contained in the birdCounts dataset?
>
> 4. In how many sites were insectivores observed?
>
> 5. In what proportion of the sites were insectivores observed?
>
> **EXTRA**: Calculate the proportion of sites in which insectivores were observed using a single **nested** function.

----

<img align = "center" src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Git-logo.svg/512px-Git-logo.svg.png" height="150px" width = "150px"/>

