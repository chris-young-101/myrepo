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

# Example of how the data must be analysed (Find 'Match ID' & Find 'club')
#Round 1, 2016 
Rich0116 <- subset(Edges, `Match ID`==98150101 & club=="Richmond")
#Round 1, 2016 TEAM 2
Carl0116 <- subset(Edges, `Match ID`==98150101 & club=='Carlton')

### This process above ideally automated in a form of loop which finds the Match ID and the Club without the need to be specified

#Once Dataframe is created for each Match and each club, these can be converted to graph data
RichNet0116 <- graph.data.frame(Rich0116, directed = T)
CarlNet0116 <- graph.data.frame(Carl0116, directed = T)

# Visualise the networks
plot(RichNet0116, edge.arrow.size = 0.2)
plot(CarlNet0116, edge.arrow.size = 0.2)

### Trial loop for subsetting by Match ID & Club
#for(`Match ID` in 98150101:98152309) 
 # for (club in  'Adelaide Crows':'West Coast Eagles') 
  #  if(club = `Match ID`) 
   #   print(paste("The Match ID is", `Match ID`)
    #        print(paste("The Club is", club)) 

#Would like to return network measures for each 'club' for every 'Match ID' and write this to a .csv in an automated or at least semi-automated manner. 
# If one season of data is analysed this = 198 matches x 2 clubs for each match = 396 seperate analyses
# The network measures may include: Betweenness, Degree (in and out), closeness centrality, betweenness centrality, density, Eigenvector centrality

Rich0116 <- Rich0116 %>%
  select(`Match ID`, Source, Target) %>%
  na.omit()
#Find vector (node) size
vector_Rich0116 <- write.csv(Rich0116, "Rich0116_vector.csv")

#Add a weight (count) of each unique interaction
library(dplyr)
Rich0116 <- ddply(Rich0116, .(Rich0116$Source, Rich0116$Target), nrow)
names(Rich0116) <- c("Source", "Target", "weight")
weight_Rich0116 <- write.csv(Rich0116, "weight_Rich0116.csv")

#Filter out values = to 0 (Umpires)
Rich0116 <- dplyr::filter(Rich0116, Target > 0)

Rich0116_mat <- as.matrix(Rich0116)
g <- graph.edgelist(Rich0116_mat[ ,1:2], directed = T)
E(g)$weight <- as.numeric(Rich0116_mat[,3])

#To See Weights 
library(igraph)
Rich0116_mat <- as.matrix(Rich0116)
g <- graph.edgelist(Rich0116_mat[,1:2], directed = T)
E(g)$weight <- as.numeric(Rich0116_mat[,3])

plot(g)
edge.width = E(g)$weight)
