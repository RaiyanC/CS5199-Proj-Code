# https://www.programiz.com/dsa/prim-algorithm
Prims := function(digraph, probability)
local nrVertices, weights, digraphVertices, outNeighbours, idx, ins, outs, currVertex, selected, min,
x, y, u, v, adjMatrix, v, e, weightIdx, mst, total, analysisPath,
headers, nrEdges, startTime, endTime, data;

digraphVertices := DigraphVertices(digraph);
weights := EdgeWeights(digraph);
nrVertices := DigraphNrVertices(digraph);
outs := OutNeighbors(digraph);
ins := InNeighbors(digraph);

# check graph is connected
if not IsConnectedDigraph(digraph) then
    ErrorNoReturn("digraph must be connected,");
fi;

# Create 2D array filled with zeros - this is the adjacancy matrix
adjMatrix := EmptyPlist(nrVertices);
for u in [1..nrVertices] do
    adjMatrix[u] := [];
    for v in [1..nrVertices] do
        Add(adjMatrix[u], 0);
    od;
od;


# Fill the 2D array with weights of the edge
for u in digraphVertices do
    outNeighbours := outs[u];
    
    for idx in [1 .. Size(outNeighbours)] do 
        v := outNeighbours[idx]; # the out neighbour
        w := weights[u][idx]; # the weight of the edge to the out neighbour

        if adjMatrix[u][v] = 0 then
            adjMatrix[u][v] := w;
            adjMatrix[v][u] := w;
        else if w < adjMatrix[u][v] then
            adjMatrix[u][v] := w;
            adjMatrix[v][u] := w;
        fi;
    od;
od; 

# ANALYSIS: HERE START TIME
nrEdges := Size(DigraphEdges(digraph));
startTime := Runtimes().user_time;

selected := [];

# Fill selected with false as we haven't explored any vertices yet
for u in [1..nrVertices] do
    Add(selected, false);
od;

selected[1] := true; # start at node 1

mst := HashMap();
currVertex := 1;
total := 0;
while currVertex <= nrVertices do
    min := infinity;
    x := 1;
    y := 1;
    
    for u in [1..nrVertices] do
        if selected[u] = true then 
            for v in [1..nrVertices] do
                if selected[v] = false and adjMatrix[u][v] <> 0 then
                    if min > adjMatrix[u][v] then
                        min := adjMatrix[u][v];
                        x := u;
                        y := v;
                    fi;
                fi;
            od;
        fi;
    od;
    if not x in mst then
        mst[x] := [];
    fi;

    Add(mst[x], y);
    total := total + adjMatrix[x][y];

    selected[y] := true;
    currVertex := currVertex + 1;
od;

# ANALYSIS: HERE STOP TIME
endTime := Runtimes().user_time;

analysisPath := Concatenation("../Minimum Spanning Tree Algorithms/Analysis/",
                Concatenation(String(probability), "/pv1.csv"));


data := Concatenation(String(nrVertices), 
Concatenation(",", 
Concatenation(String(nrEdges), 
Concatenation(",",
Concatenation(String(startTime),
Concatenation(",",
Concatenation(String(endTime), "\n")))))));
AppendTo(analysisPath, data);

return [total, mst];
end;


