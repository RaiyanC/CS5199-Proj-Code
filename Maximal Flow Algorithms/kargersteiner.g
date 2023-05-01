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

contract := function(digraph, options)
    local subsets, digraphVertices, nrVertices, nrV, nrEdges, i, u, u_idx, v, v_idx,
    edgeList, outNeigbours, idx, w, weights, randomEdgeIdx, cuts, edgesCut, parent,
    total, x, y, rank, opts, default, name;

    default := rec(minV:=2);

    if IsRecord(options) then
        opts := ShallowCopy(options);
    else
        opts := rec();
    fi;

    for name in RecNames(default) do
        if IsBound(opts.(name)) then
            default.(name) := opts.(name);
        fi;
    od;

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
    while nrV > default.minV do
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

    return rec(cuts:=cuts, edgesCut:=edgesCut);
end;

minCut := function(digraph)
    local nrEdges, nrVertices, g, m, upperBound, i, cutInfo, edgesCut;

    nrEdges := Size(DigraphEdges(digraph));
    nrVertices := Size(DigraphVertices(digraph));

    # upperBound := Int(nrVertices * (nrVertices - 1) * Log((nrVertices/2), 2));
    upperBound := nrVertices;
    
    for i in [1 .. upperBound] do
        g := contract(digraph, rec());
        cutInfo := contract(digraph, rec());
        if cutInfo.cuts <= nrEdges then
            nrEdges := cutInfo.cuts;
            edgesCut := cutInfo.edgesCut;
        fi;
    od;

    return rec(cuts:=nrEdges, edgesCut:=edgesCut);
end;

fastMinCut := function(digraph)
    local nrVertices, t, g1, g2;

    nrVertices := Size(DigraphVertices(digraph));
    if (nrVertices <= 6) then
        return minCut(digraph);
    fi;

    t := Int(1 + nrVertices / Sqrt(2));
    g1 := contract(digraph, rec(minV:=2));
    g2 := contract(digraph, rec(minV:=2));

    # return Minimum(g1.cuts, g2.cuts);
    if g1.cuts <= g2.cuts then
        return rec(cuts:=g1.cuts, edgesCut:=g1.edgesCut);
    else
        return rec(cuts:=g2.cuts, edgesCut:=g2.edgesCut);
    fi;
end;

KargerSteiner := function(digraph)
    local digraphVertices, nrVertices, nrEdges, i, upperBound, edgesCut, cutInfo, total;

    digraphVertices := DigraphVertices(digraph);
    nrVertices := Size(digraphVertices);
    nrEdges := Size(DigraphEdges(digraph));
    edgesCut := [];
    total := 0;

    # upperBound := Int(nrVertices * Log(nrVertices, 2)/(nrVertices - 1));
    upperBound := nrVertices;

    for i in [1.. upperBound] do
        cutInfo := fastMinCut(digraph);
        if cutInfo.cuts <= nrEdges then
            nrEdges := cutInfo.cuts;
            edgesCut := cutInfo.edgesCut;
        fi;
    od;
    return  rec(cuts:=nrEdges, edgesCut:=edgesCut);
end;