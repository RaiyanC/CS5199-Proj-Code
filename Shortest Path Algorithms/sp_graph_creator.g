CreateRandomSPGraph := function(number_of_vertices, probability)
    local random_graph, weights, used_weights, digraph_vertices,
    number_of_edges, random_weights, out_neighbours, u, idx, random_weight_idx;

    random_graph := RandomDigraph(IsConnectedDigraph, number_of_vertices, probability); # random connected digraph
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

    return rec(random_graph:=random_graph, weights:=weights, start:=1, destination:=number_of_vertices);
end;