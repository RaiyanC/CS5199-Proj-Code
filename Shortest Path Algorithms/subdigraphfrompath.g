SubdigraphFromPath := function(digraph, record, destination)
    local start, idx, d, distances, edges, p, parents, nrVertices, outNeighbours,
    u, v, weights, vertex;

    weights := EdgeWeights(digraph);
    distances := record.distances;
    edges := record.edges;
    parents := record.parents;
    nrVertices := Size(distances);

    outNeighbours := EmptyPlist(nrVertices);
    
    # fill out neighbours with empty lists
    for idx in [1..nrVertices] do
        Add(outNeighbours,[]);
    od;

    vertex := destination;
    # while vertex isnt the start vertex
    while parents[vertex] <> fail do
        p := parents[vertex]; # parent of vertex is p

        Add(outNeighbours[p], vertex);
        vertex := p;
    od;

    return Digraph(outNeighbours);
end;

SubdigraphFromPaths := function(digraph, record)
    local start, idx, d, distances, edges, p, parents, nrVertices, outNeighbours,
    u, v, weights;

    weights := EdgeWeights(digraph);
    distances := record.distances;
    edges := record.edges;
    parents := record.parents;
    nrVertices := Size(distances);


    for idx in [1..Size(distances)] do
        d := record.distances[idx];
        # distance to start node is 0
        if Float(d) = Float(0) then
            start := idx;
        fi;
    od;
    
    outNeighbours := EmptyPlist(nrVertices);
    
    # fill out neighbours with empty lists
    for idx in [1..nrVertices] do
        Add(outNeighbours,[]);
    od;

    for idx in [1..Size(parents)] do
        u := parents[idx];
        v := idx;

        # this is the start vertex
        if u = fail then
            continue;
        fi;

        Add(outNeighbours[u], v);
    od;

    return Digraph(outNeighbours);
end;

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

PaintSubdigraph := function(digraph, subdigraph, options)
    # options d, sd, opts: src, srcColor, dest, destColor, vertColor, mainColour, edgeColour
    local digraphVertices, outsOriginal, outNeighboursOriginal, nrVertices, outsSubdigraph, 
    outNeighbours, outNeighboursSubdigraph, edgeColours, 
    vertColours, u, v, idxOfSmallestEdge, opts, mainColour, edgeColour, sourceColour, destColour, vertColour;

    mainColour := "blue";
    edgeColour := "black";
    vertColour := "lightpink";
    sourceColour := "green";
    destColour := "red";
    

    if IsRecord(options) then
        opts := ShallowCopy(options);
    else
        opts := rec();
    fi;

    # optional argument defaults   
    if not IsBound(opts.sourceColour) then
        opts.sourceColour := sourceColour;
    fi;

    if not IsBound(opts.destColour) then
        opts.destColour := destColour;
    fi;

    if not IsBound(opts.vertColour) then
        opts.vertColour := vertColour;
    fi;

    if not IsBound(opts.mainColour) then
        opts.mainColour := mainColour;
    fi;

    if not IsBound(opts.edgeColour) then
        opts.edgeColour := edgeColour;
    fi;

    digraphVertices := DigraphVertices(subdigraph);
    nrVertices := Size(digraphVertices);
    outsOriginal := OutNeighbors(digraph);
    outsSubdigraph := OutNeighbors(subdigraph);

    edgeColours := EmptyPlist(nrVertices);
    vertColours := EmptyPlist(nrVertices);

    for u in digraphVertices do
        vertColours[u] := opts.vertColour;
        edgeColours[u] := [];
        outNeighboursSubdigraph := outsSubdigraph[u];
        outNeighboursOriginal := outsOriginal[u];

        # make everything black
        for v in outNeighboursOriginal do
            Add(edgeColours[u], opts.edgeColour);
        od;

        # paint mst edges
        for v in outNeighboursSubdigraph do
            idxOfSmallestEdge := getSmallestEdge(digraph, u, v);
            edgeColours[u][idxOfSmallestEdge] := opts.mainColour;
        od;
    od;

    # set source and dest colours
    if IsBound(opts.source) then
        if 1 <= opts.source and opts.source <= nrVertices then
            vertColours[opts.source] := opts.sourceColour;
        else
            ErrorNoReturn("source vertex does not exist,");
        fi;
    fi;

    if IsBound(opts.dest) then
        if 1 <= opts.dest and opts.dest <= nrVertices then
            vertColours[opts.dest] := opts.destColour;
        else
            ErrorNoReturn("destination vertex does not exist,"); 
        fi;
    fi;


    return DotColoredDigraph(digraph, vertColours, edgeColours);
end;

