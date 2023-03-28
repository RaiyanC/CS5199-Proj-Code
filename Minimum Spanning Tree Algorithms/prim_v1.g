# https://www.programiz.com/dsa/prim-algorithm
Prims := function(digraph)
local nrVertices, weights, currVertex, selected, min, x, y, i, j, adjMatrix, v, e, weightIdx, mst, total;


weights := EdgeWeights(digraph);
nrVertices := DigraphNrVertices(digraph);


# Create 2D array filled with zeros - this is the adjacancy matrix
adjMatrix := EmptyPlist(nrVertices);
for i in [1..nrVertices] do
    adjMatrix[i] := [];
    for j in [1..nrVertices] do
        Add(adjMatrix[i], 0);
    od;
od;


# Fill the 2D array with weights of the edge
for v in DigraphVertices(digraph) do
    weightIdx := 1;
    for e in OutNeighbors(digraph)[v] do
        adjMatrix[v][e] := weights[v][weightIdx];
        weightIdx := weightIdx + 1;
    od;
od; 

selected := [];

# Fill selected with false as we haven't explored any vertices yet
for i in [1..nrVertices] do
    Add(selected, false);
od;

selected[1] := true; # start at node 1

mst := HashMap();
currVertex := 0;
total := 0;
while currVertex < nrVertices - 1 do
    min := infinity;
    x := 0;
    y := 0;
    
    for i in [1..nrVertices] do
        if selected[i] = true then 
            for j in [1..nrVertices] do
                if selected[j] = false and adjMatrix[i][j] <> 0 then
                    if min > adjMatrix[i][j] then
                        min := adjMatrix[i][j];
                        x := i;
                        y := j;
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


return [total, mst];
end;


