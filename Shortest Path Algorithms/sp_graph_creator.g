CreateRandomSPGraph := function(number_of_vertices, probability)
    local random_graph, weights, used_weights, digraph_vertices, number_of_edges,
    random_weight, out_neighbours, u, idx;

    random_graph := RandomDigraph(IsConnectedDigraph, number_of_vertices, probability); # random connected digraph
    digraph_vertices := DigraphVertices(random_graph); 
    number_of_edges := DigraphNrEdges(random_graph) * 10000; 

    weights := [];
    used_weights := HashSet();


    # Create random weights for each edge. weights are unique [1..number of edges]
    for u in digraph_vertices do
        out_neighbours := OutNeighbors(random_graph)[u];
        Add(weights, []);
        for idx in [1..Size(out_neighbours)] do
            random_weight := Random([1..number_of_edges]);

            while random_weight in used_weights do
                random_weight := Random([1..number_of_edges]);
            od;
            AddSet(used_weights, random_weight);
            weights[u][idx] := random_weight;        
        od;
    od;
    

    return rec(random_graph:=random_graph, weights:=weights, start:=1, destination:=number_of_vertices);
end;