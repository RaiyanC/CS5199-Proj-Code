Floyd := function(digraph, weight)
    local adj_matrix, digraph_vertices, nr_vertices, e,u,v,edges, outs, ins, 
    edge_idx, idx, out_neighbours, in_neighbours, w, mst, 
    visited, i, queue, cost, node, neighbour, next_vertex, total, 
    edges_in_mst, number_of_vertices, distances;

    digraph_vertices := DigraphVertices(digraph);
    nr_vertices := Size(digraph_vertices);
    outs := OutNeighbors(digraph);
    ins := InNeighbors(digraph);

    # Create adjacancy matrix
    adj_matrix := EmptyPlist(nr_vertices);
    for u in digraph_vertices do
        adj_matrix[u] := EmptyPlist(nr_vertices);
        out_neighbours := outs[u];
        for idx in [1..Size(out_neighbours)] do
            v := out_neighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            
            # fill adjacancy matrix
            adj_matrix[u][v] := w;
        od;
    od;

    # fill distances with inf
    distances := EmptyPlist(nr_vertices);
    for u in digraph_vertices do
        distances[u] := EmptyPlist(nr_vertices);
        for v in digraph_vertices do
            distances[u][v] := infinity;

            if adj_matrix[u][v] 
        od;
    od;
             
    return adj_matrix;
end;
