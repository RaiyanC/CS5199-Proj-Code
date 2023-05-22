In ./cs5199/

./setup.sh 

# Install Packages
InstallPackage("digraphs");
InstallPackage("profiling");

## Random Graph Creation
rd := RandomUniqueEdgeWeightedDigraph(10,0.1);
EdgeWeights(rd);

rd := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph, 10,0.1);
EdgeWeights(rd);

rd := RandomUniqueEdgeWeightedDigraph(10);

Splash(DotDigraph(rd));

rd := RandomUniqueEdgeWeightedDigraph(10, 1);

# Minimum Spanning Tree
ans := DigraphEdgeWeightedMinimumSpanningTree(rd);
Splash(DotDigraph(ans.mst));

## Visualisation
Splash(DotEdgeWeightedDigraph(rd, ans.mst, rec()));

# Shortest Path
rd := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph, 10, 0.01); # 0.01 because it makes it easier to see 

ans := DigraphEdgeWeightedShortestPath(rd, 1);

-- need to create subdigraph from sp output
sd := DigraphFromPaths(rd, ans);

## Visualisation
Splash(DotEdgeWeightedDigraph(rd, sd, rec()));

-- from 1 to 3
sd := DigraphFromPath(rd, ans, 3);
Splash(DotEdgeWeightedDigraph(rd, sd, rec()));

-- from 3 to 5
ans := DigraphEdgeWeightedShortestPath(rd, 3);
sd := DigraphFromPath(rd, ans, 5);
Splash(DotEdgeWeightedDigraph(rd, sd, rec()));

# Visualisation
rd := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph, 10, 0.01);
ans := DigraphEdgeWeightedShortestPath(rd, 4);
sd := DigraphFromPath(rd, ans, 8);
-- and any other options they might want to see
Splash(DotEdgeWeightedDigraph(rd, sd, rec(source:=4, dest:=8)));


# Maximal Flow
rd := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph, 4, 0.01);
Splash(DotDigraph(rd));

-- demonstrating error
DigraphMaximumFlow(rd, 1, 10);

DigraphMaximumFlow(rd, 1, 4);

-- if needed incase flow output is minimal
EdgeWeights(rd);
OutNeighbours(rd);

## Minimum Cuts
rd := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph, 3, 0.01);
Splash(DotDigraph(rd));
DigraphMinimumCuts(rd);

# Testing and Analysis
python3 analyser.py -p "./1/k.csv" "./0.5/k.csv" "./0.25/k.csv" "./0.125/k.csv" "./0.01/k.csv" "./1/p.csv" "./0.5/p.csv" "./0.25/p.csv" "./0.125/p.csv" "./0.01/p.csv" -c 

# GAP Tests
ProfilePackage("digraphs");

DigraphsTestStandard();
DigraphsTestManualExamples();
DigraphsTestInstall();


# Complexities
-- Minimum Spanning Tree
Prim's
Kruskal's
Boruvka's

-- Shortest Path
Dijkstra's
Bellman-Ford's

-- Shortest Paths
Floyd Warshall's
Johnson's

-- Max Flow
Edmonds-Karp's
Dinic's
Push-Relabel

-- Minimum Cut
Karger-Stein
