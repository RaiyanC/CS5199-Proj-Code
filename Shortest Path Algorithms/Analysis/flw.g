Floyd := function(digraph, probability)
    local weights, adj_matrix, digraphVertices, nrVertices, e,u,v,edges, outs, ins, 
    edge_idx, idx, out_neighbours, in_neighbours, w, mst, 
    visited, i, j, k, queue, cost, node, neighbour, next_vertex, total, 
    edges_in_mst, number_of_vertices, distances, parents, analysisPath, headers, nrEdges, startTime, endTime, data;;

    weights := EdgeWeights(digraph);
    
    digraphVertices := DigraphVertices(digraph);
    nrVertices := Size(digraphVertices);
    outs := OutNeighbors(digraph);
    ins := InNeighbors(digraph);

    # Create adjacancy matrix
    adj_matrix := EmptyPlist(nrVertices);
    parents := EmptyPlist(nrVertices);
    edges := EmptyPlist(nrVertices);


    for u in digraphVertices do
        adj_matrix[u] := EmptyPlist(nrVertices);
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
    distances := EmptyPlist(nrVertices);
    for u in digraphVertices do
        distances[u] := EmptyPlist(nrVertices);
        parents[u] := EmptyPlist(nrVertices);
        edges[u] := EmptyPlist(nrVertices);

        for v in digraphVertices do
            

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
                parents[u][v] := u;
                edges[u][v] := idx;
            
            fi;
        od;
    od;

    # Print("adj mat ", adj_matrix, "\n\n\n");

    # Print("distance ", distances, "\n\n\n");

    # ANALYSIS: HERE START TIME
    nrEdges := Size(DigraphEdges(digraph));
    startTime := Runtimes().user_time;
    nrVertices := Size(digraphVertices);

    for k in [1..nrVertices] do
        for u in [1..nrVertices] do
            for v in [1..nrVertices] do
                if distances[u][k] < infinity and distances[k][v] < infinity then
                    if distances[u][k] + distances[k][v] < distances[u][v] then
                        distances[u][v] := distances[u][k] + distances[k][v];


                        parents[k][v] := k;
                        # parents[u][k] := u;

                        # Print("u ", u, " k ", k, " v ", v, "\n");
                    fi;
                fi;
            od;
        od;
    od;

    # ANALYSIS: HERE STOP TIME
    endTime := Runtimes().user_time;

    analysisPath := Concatenation("../Shortest Path Algorithms/Analysis/",
                    Concatenation(String(probability), "/flw.csv"));


    data := Concatenation(String(nrVertices), 
    Concatenation(",", 
    Concatenation(String(nrEdges), 
    Concatenation(",",
    Concatenation(String(startTime),
    Concatenation(",",
    Concatenation(String(endTime), "\n")))))));

    AppendTo(analysisPath, data);
    
    return rec(distances:=distances, parents:=parents, edges:=edges);
end;