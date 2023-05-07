EdgeWeightedDigraph := function(digraph, weights)
    local digraphVertices, nrVertices, u, outNeighbours, outNeighbourWeights, idx, v, w;

    if IsDigraph(digraph) then
        digraph := DigraphCopy(digraph);
    else
        digraph := Digraph(digraph);
    fi;

    # check all elements of weights is a list
    if not ForAll(weights, IsList) then
        ErrorNoReturn("2nd argument (list) must be a list of lists,");
    fi;
    
    digraphVertices := DigraphVertices(digraph);
    nrVertices := Size(digraphVertices);

    # check number there is an edge weight list for vertex u
    if nrVertices <> Size(weights) then
        ErrorNoReturn("number of out neighbours and weights must be equal,");
    fi;

    # check all elements of weights is a list and size/shape is correct
    for u in digraphVertices do
        outNeighbours := OutNeighbors(digraph)[u];
        outNeighbourWeights := weights[u];

        # check number of out neigbours for u and number of weights given is the same
        if Size(outNeighbours) <> Size(outNeighbourWeights) then
            ErrorNoReturn("size of out neighbours and weights for vertex ", u," must be equal,");
        fi;

        # check all elements of out neighbours are int
        for idx in [1..Size(outNeighbours)] do
            v := outNeighbours[idx];
            w := outNeighbourWeights[v];

            if not (IsInt(v) or IsFloat(v) or IsRat(v)) then
                ErrorNoReturn("out neighbour must be either integer, float or rational,");
            fi;

            if not (IsInt(w) or IsFloat(w) or IsRat(w)) then
                ErrorNoReturn("out neighbour weight must be either integer, float or rational,");
            fi;
        od;
    od;

    SetEdgeWeights(digraph, weights);
    return digraph;
end;