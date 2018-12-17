library(tidyr)
library(dplyr)
library(readr)

beijing_reduced=read.csv("~/Desktop/reduced_beijing.csv")
newdf=beijing_reduced[,c("followers","district")]

edgeList=newdf %>% 
  group_by(followers, district) %>%
  summarise(Freq = n())
colnames(edgeList) <- c("SourceName", "TargetName", "Weight")
edgeList
edgeList$SourceName<-factor(edgeList$SourceName)
agg <- aggregate(Weight ~ SourceName, edgeList, max)
edgeList <- merge(agg, edgeList)

edgeList <- edgeList[c("SourceName", "TargetName", "Weight")]
edgeList$Weight=edgeList$Weight*0.01

library(igraph)
gD <- igraph::simplify(igraph::graph.data.frame(edgeList, directed=TRUE)) 
nodeList <- data.frame(ID = c(0:(igraph::vcount(gD) - 1)), # because networkD3 library requires IDs to start at 0
                       nName = igraph::V(gD)$name)

(head(nodeList))

getNodeID <- function(x){
  which(x == igraph::V(gD)$name) - 1 # to ensure that IDs start at 0
}

(getNodeID("Joly")) 
edgeList <- plyr::ddply(edgeList, .variables = c("SourceName", "TargetName" , "Weight"), 
                        function (x) data.frame(SourceID = getNodeID(x$SourceName), 
                                                TargetID = getNodeID(x$TargetName)))

(head(edgeList))
nodeList <- cbind(nodeList, nodeDegree=igraph::degree(gD, v = igraph::V(gD), mode = "all"))
betAll <- igraph::betweenness(gD, v = igraph::V(gD), directed = FALSE) / (((igraph::vcount(gD) - 1) * (igraph::vcount(gD)-2)) / 2)
betAll.norm <- (betAll - min(betAll))/(max(betAll) - min(betAll))
nodeList <- cbind(nodeList, nodeBetweenness=100*betAll.norm) # We are scaling the value by multiplying it by 100 for visualization purposes only (to create larger nodes)
rm(betAll, betAll.norm)
(head(nodeList))
dsAll <- igraph::similarity.dice(gD, vids = igraph::V(gD), mode = "all")
(head(dsAll))

#Create  data frame that contains the Dice similarity between any two vertices
F1 <- function(x) {data.frame(diceSim = dsAll[x$SourceID +1, x$TargetID + 1])}
#Place a new column in edgeList with the Dice Sim
(head(edgeList))
edgeList <- plyr::ddply(edgeList, .variables=c("SourceName", "TargetName", "Weight", "SourceID", "TargetID"), 
                        function(x) data.frame(F1(x)))
(head(edgeList))
rm(dsAll, F1, getNodeID, gD)

############################################################################################
# We will also create a set of colors for each edge, based on their dice similarity values
# We'll interpolate edge colors based on using the "colorRampPalette" function, that 
# returns a function corresponding to a color palette of "bias" number of elements (in our case, that
# will be a total number of edges, i.e., number of rows in the edgeList data frame)
F2 <- colorRampPalette(c("#00007F", "#007FFF"), bias = nrow(edgeList), space = "rgb", interpolate = "linear")
colCodes <- F2(length(unique(edgeList$diceSim)))
edges_col <- sapply(edgeList$diceSim, function(x) colCodes[which(sort(unique(edgeList$diceSim)) == x)])

rm(colCodes, F2)
```

```{R}
install.packages("networkD3")
############################################################################################
# Create a networkD3

D3_network_LM <- networkD3::forceNetwork(Links = edgeList, # data frame that contains info about edges
                                         Nodes = nodeList, # data frame that contains info about nodes
                                         Source = "SourceID", # ID of source node 
                                         Target = "TargetID", # ID of target node
                                         Value = "Weight", # value from the edge list (data frame) that will be used to value/weight relationship amongst nodes
                                         NodeID = "nName", # value from the node list (data frame) that contains node description we want to use (e.g., node name)
                                         Nodesize = "nodeBetweenness",  # value from the node list (data frame) that contains value we want to use for a node size
                                         Group = "nodeDegree",  # value from the node list (data frame) that contains value we want to use for node color
                                         height = 500, # Size of the plot (vertical)
                                         width = 1000,  # Size of the plot (horizontal)
                                         fontSize = 20, # Font size
                                         linkDistance = networkD3::JS("function(d) { return 10*d.value; }"), # Function to determine distance between any two nodes, uses variables already defined in forceNetwork function (not variables from a data frame)
                                         linkWidth = networkD3::JS("function(d) { return d.value/5; }"),# Function to determine link/edge thickness, uses variables already defined in forceNetwork function (not variables from a data frame)
                                         opacity = 0.65, # opacity
                                         zoom = TRUE, # ability to zoom when click on the node
                                         opacityNoHover = 0.1, # opacity of labels when static
                                         linkColour = edges_col) # edge colors

# Plot network
D3_network_LM 

# Save network as html file
networkD3::saveNetwork(D3_network_LM, "D3.html", selfcontained = TRUE)
