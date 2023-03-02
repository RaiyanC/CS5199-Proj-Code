EdgeWeightedDigraph := function(digraph, weights)
    local digraphVertices, nrVertices, outNeighbours, idx;
    # validity checks

    # if not ForAll(weights, IsList) then
    #     ErrorNoReturn("2nd argument (list) must be a list of lists");
    # fi;
    
    digraphVertices := DigraphVertices(digraph);
    nrVertices := Size(digraphVertices);

    # check number there is an edge weight list for vertex u
    if nrVertices <> Size(weights) then
        ErrorNoReturn("number of out neighbours and weights must be equal");
    fi;

    # check all elements of weights is a list and size/shape is correct
    for u in digraphVertices do
        outNeighbours := OutNeighbors(digraph)[u];
        outNeighbourWeights := weights[u];

        # check number of out neigbours for u and number of weights given is the same
        if Size(outNeigbours) <> Size(outNeighbourWeights) then
            ErrorNoReturn("size of out neighbours and weights for ", u, " must be equal");
        fi;

        for idx in [1..S]
    od;

    SetEdgeWeights(digraph, weights);
    return digraph;
end;