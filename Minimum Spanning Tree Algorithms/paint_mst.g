getSmallestEdge := function(digraph, u, v)
    local weights, edgeWeights, smallestEdgeIdx, minWeight, w, outs, idx;

    outs := OutNeighbours(digraph)[u];
    weights := EdgeWeights(digraph);

    edgeWeights := weights[u];

    smallestEdgeIdx := 1;
    minWeight := infinity;
    for idx in [1..Size(edgeWeights)] do
        w := edgeWeights[idx];
        if w < minWeight and outs[idx] = v then
            minWeight := w;
            smallestEdgeIdx := idx;
        fi;
    od;

    return smallestEdgeIdx;
end;
PaintMST := function(digraph, mst, vertColour, mainCOlour, edgeColour)
    local digraphVertices, nrVertices, outsMST, outNeighbours, outNeighboursMST, edgeColours, 
    vertColours, u, v, idxOfSmallestEdge;

    digraphVertices := DigraphVertices(mst);
    nrVertices := Size(digraphVertices);
    outsOriginal := OutNeighbors(digraph);
    outsMST := OutNeighbors(mst);


    edgeColours := EmptyPlist(nrVertices);
    vertColours := EmptyPlist(nrVertices);

    for u in digraphVertices do
        vertColours[u] := vertColour;
        edgeColours[u] := [];
        outNeighboursMST := outsMST[u];
        outNeighboursOriginal := outsOriginal[u];

        # make everything black
        for v in outNeighboursOriginal do
            Add(edgeColours[u], edgeColour);
        od;

        # paint mst edges
        for v in outNeighboursMST do
            idxOfSmallestEdge := getSmallestEdge(digraph, u, v);
            edgeColours[u][idxOfSmallestEdge] := mainCOlour;
        od;
    od;

    return rec(vertColors:=vertColours, edgeColors:=edgeColours);
end;
