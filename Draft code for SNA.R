# Project 3 Network Analysis

# Install and Load Packages
library(readr)
library(plyr)
library(tidyverse)
library(igraph)
library(sna)
library(network)
library(entropy)
library(sna)
library(threejs)

# Read data into R
### Edges data
Edges <- read_csv("~/Desktop/Deakin University/Dan Dwyer - PhD Chris Young/Projects/Project 3/R/Data/Edges.csv")
View(Edges)

### Nodes data
nodes <- read_csv("~/Desktop/Deakin University/Dan Dwyer - PhD Chris Young/Projects/Project 3/Gephi/Data/nodes 2016.csv")

###Check data
head(Edges)

# Remove the need for the use of $ for dataframe attributes
attach(Edges)


