Floyd := function(digraph, weights)
    local adj_matrix, digraph_vertices, nr_vertices, e,u,v,edges, outs, ins, 
    edge_idx, idx, out_neighbours, in_neighbours, w, mst, 
    visited, i, j, k, queue, cost, node, neighbour, next_vertex, total, 
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

            # only put min edge in if multiple edges exists
            if IsBound(adj_matrix[u][v]) then
                if w < adj_matrix[u][v] then
                    adj_matrix[u][v] := w;
                fi;
            else 
                adj_matrix[u][v] := w;
            fi;
        od;
    od;

    # Create distances adj matrix
    distances := EmptyPlist(nr_vertices);
    for u in digraph_vertices do
        distances[u] := EmptyPlist(nr_vertices);
        for v in digraph_vertices do
            distances[u][v] := infinity;

            if u = v then
                distances[u][v] := 0;
            elif IsBound(adj_matrix[u][v]) then
                distances[u][v] := adj_matrix[u][v];
            fi;
        od;
    od;
    

    for k in [1..nr_vertices] do
        for i in [1..nr_vertices] do
            for j in [1..nr_vertices] do
                if distances[i][k] < infinity and distances[k][j] < infinity then
                    if distances[i][k] + distances[k][j] < distances[i][j] then
                        distances[i][j] := distances[i][k] + distances[k][j];
                    fi;
                fi;
            od;
        od;
    od;
    
    return distances;
end;