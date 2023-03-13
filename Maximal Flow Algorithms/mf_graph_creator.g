CreateRandomMFGraph := function(n, p)
    # this creates random connected graph - we still need to assign random weights
    local randomDigraph, adjMatrix, stronglyConnectedComponents, 
    scc_a, scc_b, i, j, random_u, random_v, adjList, u, v, random_graph, weights, used_weights, digraph_vertices,
    number_of_edges, random_weights, out_neighbours, idx, random_weight_idx, 
    adjacencyList, vertices, startVertex, tree, x;

    # strong connected digraph must be at least connected
    randomDigraph := RandomDigraph(IsConnectedDigraph, n, p);
    stronglyConnectedComponents := DigraphStronglyConnectedComponents(randomDigraph);
    
    adjMatrix := AdjacencyMatrixMutableCopy(randomDigraph);

    for i in [1..Size(stronglyConnectedComponents.comps) - 1] do
        scc_a := stronglyConnectedComponents.comps[i];
        scc_b := stronglyConnectedComponents.comps[i+1];

        # add a connection from u to v
        random_u := Random(scc_a);
        random_v := Random(scc_b);

        adjMatrix[random_u][random_v] := 1;

        # get a different u and v and add edge in the reverse direction
        random_u := Random(scc_b);
        random_v := Random(scc_a);

        adjMatrix[random_u][random_v] := 1;
    od; 
    

    # random_graph := RandomDigraph(IsConnectedDigraph, number_of_vertices, probability); # random connected digraph
    random_graph :=  DigraphByAdjacencyMatrix(adjMatrix);
    digraph_vertices := DigraphVertices(random_graph); 
    number_of_edges := DigraphNrEdges(random_graph) + 1; 

    
    random_weights := Shuffle([1..number_of_edges]);
    weights := [];
    random_weight_idx := 1;


    # Create random weights for each edge. weights are unique [1..number of edges]
    for u in digraph_vertices do
        out_neighbours := OutNeighbors(random_graph)[u];
        Add(weights, []);
        for idx in [1..Size(out_neighbours)] do
            weights[u][idx] := random_weights[random_weight_idx];
            random_weight_idx := random_weight_idx + 1;        
        od;
    od;

    return rec(random_graph := EdgeWeightedDigraph(random_graph, weights), start:=1, destination:=n);
end;