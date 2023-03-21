find := function(parent, i)
    if parent[i] = i then
        return i;
    fi;

    return find(parent, parent[i]);
end;

union := function(parent, rank, x, y)
    local xroot, yroot;

    xroot := find(parent, x);
    yroot := find(parent, y);

    if rank[xroot] < rank[yroot] then
        parent[xroot] := yroot;
    elif rank[xroot] > rank[yroot] then
        parent[yroot] := xroot;
    else
        parent[yroot] := xroot;
        rank[xroot] := rank[xroot] + 1;
    fi;
end;

Karger := function(digraph)
    local subsets, digraphVertices, nrVertices, nrV, nrEdges, i, u, u_idx, v, v_idx,
    edgeList, outNeigbours, idx, w, weights, s1, s2, randomEdgeIdx, cuts, parent, x, y;

    weights := EdgeWeights(digraph);
    digraphVertices := DigraphVertices(digraph);
    nrVertices := Size(digraphVertices);
    nrEdges := Size(DigraphEdges(digraph));
    

    edgeList := [];
    for u in digraphVertices do
        outNeigbours := OutNeighbors(digraph)[u];
        for idx in [1..Size(outNeigbours)] do
            v := outNeigbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            Add(edgeList, [w, u, v]);
        od;
    od;

    parent := [];
    rank := [];

    for v in [1..nrVertices] do
        Add(parent, v);
        Add(rank, 1);
    od;

    nrV := nrVertices;
    while nrV > 2 do
        randomEdgeIdx := Random([1..Size(edgeList)]);
        u := edgeList[randomEdgeIdx][2];
        v := edgeList[randomEdgeIdx][3];

        x := find(parent, u);
        y := find(parent, v);

        if x <> y then
            nrV := nrV - 1;
            union(parent, rank, x, y);
        fi;
    od;

    cuts := 0;
    for i in [1..nrEdges] do
        
        x := find(parent, edgeList[i][2]);
        y := find(parent, edgeList[i][3]);

        if x <> y then
            cuts := cuts + 1;
        fi;
    od;
    return cuts;
end;

# mergeVertices := function(digraph, u_idx, v_idx)
#     local mutableOuts, mutableWeights, head, tail, head_w, tail_w;

#     mutableOuts := OutNeighborsMutableCopy(digraph);
#     mutableWeights := EdgeWeightsMutableCopy(digraph);

#     Print("before ", mutableOuts, " ", mutableWeights, "\n");
#     Print(u_idx, " ", v_idx,"\n");

#     head := mutableOuts[u_idx];
#     tail := mutableOuts[u_idx];
#     head_w := mutableWeights[u_idx];
#     tail_w := mutableWeights[u_idx];

#     # remove the edge between u and v
#     Remove(mutableOuts[u_idx], v_idx);
#     Remove(mutableWeights[u_idx], v_idx);

    
# end;


# contract := function(digraph, min_v)
#     local digraphVertices, nrVertices, nrEdges, outNeigbours, i, upperBound, u, v;

#     digraphVertices := DigraphVertices(digraph);
#     nrVertices := Size(digraphVertices);
#     nrEdges := Size(DigraphEdges(digraph));

#     if min_v = fail then
#         min_v := 2;
#     fi;

#     digraph := EdgeWeightedDigraph(OutNeighborsMutableCopy(digraph), EdgeWeightsMutableCopy(digraph));
#     while nrVertices > min_v do
        # outNeigbours := OutNeighbors(digraph);
        # u := Random([1..Size(outNeigbours)]);
        # v := Random([1..Size(outNeigbours[u])]);
#         mergeVertices(digraph, u, v);
#     od;
# end;

# minCut := function(digraph)
#     local digraphVertices, nrVertices, nrEdges, i, upperBound;

#     digraphVertices := DigraphVertices(digraph);
#     nrVertices := Size(digraphVertices);
#     nrEdges := Size(DigraphEdges(digraph));

#     upperBound := Int(nrVertices * LogInt(nrVertices, 2)/(nrVertices - 1));
#     for i in [1..upperBound] do
#         digraph := contract(digraph, fail);
#         nrEdges := Minimum(nrEdges, Size(DigraphEdges(digraph)));
#     od;
#     return nrEdges;
# end;

# fastMinCut := function(digraph)
#     local digraphVertices, nrVertices, t, g1, g2;

#     digraphVertices := DigraphVertices(digraph);
#     nrVertices := Size(digraphVertices);
    

#     if nrVertices <= 6 then
#         return minCut(digraph);
#     else 
#         t := Floor(1 + nrVertices / Sqrt(2));
#         g1 := contract(digraph, t);
#         g2 := contract(digraph, t);
#     fi;

#     return Minimum(fastMinCut(g1), fastMinCut(g2));
# end;

# Karger := function(digraph)
    # local digraphVertices, nrVertices, nrEdges, i, upperBound;

    # digraphVertices := DigraphVertices(digraph);
    # nrVertices := Size(digraphVertices);
    # nrEdges := Size(DigraphEdges(digraph));

#     upperBound := Int(nrVertices * LogInt(nrVertices, 2)/(nrVertices - 1));
#     for i in [1..upperBound] do
#         nrEdges := Minimum(nrEdges, minCut(digraph));
#     od;
#     return nrEdges;
# end;