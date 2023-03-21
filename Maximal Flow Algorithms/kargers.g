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
    total, x, y;

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

    edgesCut := [];
    nrV := nrVertices;
    while nrV > 2 do
        randomEdgeIdx := Random([1..Size(edgeList)]);
        w := edgeList[randomEdgeIdx][1];
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
    total := 0;
    for i in [1..nrEdges] do
        w := edgeList[i][1];
        u := edgeList[i][2];
        v := edgeList[i][3];
        
        x := find(parent, u);
        y := find(parent, v);

        if x <> y then
            Add(edgesCut, [u, v]);
            cuts := cuts + 1;
            total := total + w;
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
    total := 0;

    upperBound := Int(nrVertices * LogInt(nrVertices, 2)/(nrVertices - 1));

    for i in [1.. upperBound] do
        cutInfo := minCut(digraph);
        if cutInfo.cuts <= nrEdges then
            nrEdges := cutInfo.cuts;
            edgesCut := cutInfo.edgesCut;
            total := cutInfo.total;
        fi;
    od;

    return  rec(cuts:=nrEdges, edgesCut:=edgesCut, total:=total);
end;