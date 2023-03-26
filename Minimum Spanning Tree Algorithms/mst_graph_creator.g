CreateRandomMSTGraph := function(filt, n, p)
    local randomDigraph, weights, digraphVertices,
    nrEdges, randomWeights, outNeighbours, u, idx, randWeightIdx;

    randomDigraph := RandomDigraph(filt, n, p); # random connected digraph
    digraphVertices := DigraphVertices(randomDigraph); 
    nrEdges := DigraphNrEdges(randomDigraph) + 1; 

    
    randomWeights := Shuffle([1..nrEdges]);
    weights := [];
    randWeightIdx := 1;


    # Create random weights for each edge. weights are unique [1..number of edges + 1]
    for u in digraphVertices do
        outNeighbours := OutNeighbors(randomDigraph)[u];
        Add(weights, []);
        for idx in [1..Size(outNeighbours)] do
            weights[u][idx] := randomWeights[randWeightIdx];
            randWeightIdx := randWeightIdx + 1;        
        od;
    od;
    
    return EdgeWeightedDigraph(randomDigraph, weights);
end;