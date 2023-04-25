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

minCut := function(digraph)
    local subsets, digraphVertices, nrVertices, nrV, nrEdges, i, u, u_idx, v, v_idx,
    edgeList, outNeigbours, idx, w, weights, randomEdgeIdx, cuts, edgesCut, parent,
    total, x, y, rank;

    # weights := EdgeWeights(digraph);
    digraphVertices := DigraphVertices(digraph);
    nrVertices := Size(digraphVertices);
    nrEdges := Size(DigraphEdges(digraph));

    edgeList := [];
    for u in digraphVertices do
        outNeigbours := OutNeighbors(digraph)[u];
        for idx in [1..Size(outNeigbours)] do
            v := outNeigbours[idx]; # the out neighbour
            # w := weights[u][idx]; # the weight to the out neighbour

            # Add(edgeList, [w, u, v]);
            Add(edgeList, [u, v]);
        od;
    od;

    # sort edge weights by their weight
    i := Size(edgeList);

    parent := [];
    rank := [];

    for v in [1..nrVertices] do
        Add(parent, v);
        Add(rank, 1);
    od;

    edgesCut := [];
    nrV := nrVertices;
    while nrV > 2 do
        randomEdgeIdx := Random([1..Size(edgeList)]);

        u := edgeList[randomEdgeIdx][1];
        v := edgeList[randomEdgeIdx][2];

        x := find(parent, u);
        y := find(parent, v);

        if x <> y then
            nrV := nrV - 1;
            union(parent, rank, x, y);
        fi;
    od;

    cuts := 0;
    total := 0;
    for i in [1..nrEdges] do
        u := edgeList[i][1];
        v := edgeList[i][2];

        x := find(parent, u);
        y := find(parent, v);

        if x <> y then
            Add(edgesCut, [u, v]);
            cuts := cuts + 1;
        fi;
    od;

    return rec(cuts:=cuts, edgesCut:=edgesCut, total:=total);
end;

Karger := function(digraph)
    local digraphVertices, nrVertices, nrEdges, i, upperBound, edgesCut, cutInfo, total;

    digraphVertices := DigraphVertices(digraph);
    nrVertices := Size(digraphVertices);
    nrEdges := Size(DigraphEdges(digraph));
    edgesCut := [];

    # upperBound := Int(nrVertices * Log(nrVertices, 2)/(nrVertices - 1));
    upperBound := nrVertices;

    for i in [1.. upperBound] do
        cutInfo := minCut(digraph);
        if cutInfo.cuts <= nrEdges then
            nrEdges := cutInfo.cuts;
            edgesCut := cutInfo.edgesCut;
        fi;
    od;
    return  rec(cuts:=nrEdges, edgesCut:=edgesCut);
end;
