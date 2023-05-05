FloydWithPath := function(digraph)
    local weights, adj_matrix, digraph_vertices, nr_vertices, e,u,v,edges, outs, ins, 
    edge_idx, idx, out_neighbours, in_neighbours, w, mst, 
    visited, i, j, k, queue, cost, node, neighbour, next_vertex, total, 
    edges_in_mst, number_of_vertices, distances, parents, path;

    weights := EdgeWeights(digraph);
    
    digraph_vertices := DigraphVertices(digraph);
    nr_vertices := Size(digraph_vertices);
    outs := OutNeighbors(digraph);
    ins := InNeighbors(digraph);

    # Create adjacancy matrix
    adj_matrix := EmptyPlist(nr_vertices);
    parents := EmptyPlist(nr_vertices);
    edges := EmptyPlist(nr_vertices);


    for u in digraph_vertices do
        adj_matrix[u] := EmptyPlist(nr_vertices);
        out_neighbours := outs[u];
        for idx in [1..Size(out_neighbours)] do
            v := out_neighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            # only put min edge in if multiple edges exists
            if IsBound(adj_matrix[u][v]) then
                if w < adj_matrix[u][v][1] then
                    adj_matrix[u][v] := [w, idx];
                fi;
            else 
                adj_matrix[u][v] := [w, idx];
            fi;
        od;
    od;

    # Create distances adj matrix
    distances := EmptyPlist(nr_vertices);
    for u in digraph_vertices do
        distances[u] := EmptyPlist(nr_vertices);
        parents[u] := EmptyPlist(nr_vertices);
        edges[u] := EmptyPlist(nr_vertices);

        for v in digraph_vertices do
            distances[u][v] := infinity;

            if u = v then
                distances[u][v] := 0;
                # if the same node, then the node has no parents
                parents[u][v] := fail;
                edges[u][v] := fail;
            elif IsBound(adj_matrix[u][v]) then
                w := adj_matrix[u][v][1];
                idx := adj_matrix[u][v][2];

                distances[u][v] := w;

                # parent of u -> v is u
                parents[u][v] := v;
                edges[u][v] := idx;
            
            fi;
        od;
    od;

    for k in [1..nr_vertices] do
        for u in [1..nr_vertices] do
            for v in [1..nr_vertices] do
                if distances[u][k] < infinity and distances[k][v] < infinity then
                    if distances[u][k] + distances[k][v] < distances[u][v] then
                        distances[u][v] := distances[u][k] + distances[k][v];
                        parents[u][v] := parents[u][k];
                        edges[u][v] := edges[k][v];
                    fi;
                fi;
            od;
        od;
    od;

    Print("parents \n", parents, "\n\n\n");
    Print("edges \n", edges, "\n\n\n");


    u := 1;
    v := 5;
    # construct path between 1 and 3
    # if parents[u][v][1] = fail then
    #     return [];
    # fi;

    # path := [u];
    # while u <> v do
        
    #     u := parents[u][v][1];
    #     Add(path, u);
    # od;

    # Print("path ", path, "\n\n\n");

    # detect negative cycles
    for i in [1..nr_vertices] do
        if distances[i][i] < 0 then
            ErrorNoReturn("negative cycle exists,");
        fi;
    od;

    # replace infinity with fails
    for u in [1..nr_vertices] do
        for v in [1..nr_vertices] do
            if distances[u][v] = infinity then
                distances[u][v] := fail;
            fi;
        od;
    od;

    
    return distances;
end;