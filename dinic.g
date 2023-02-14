levels :=0;
Dinic := function(digraph, weights, source, sink)
    local adj_matrix, digraph_vertices, nr_vertices, e,u,v,edges, outs, ins, 
    edge_idx, idx, out_neighbours, in_neighbours, w, mst, 
    visited, i, j, k, queue, cost, node, neighbour, next_vertex, total, 
    edges_in_mst, number_of_vertices, distances, parents, total_flow, flow_matrix;

    digraph_vertices := DigraphVertices(digraph);
    nr_vertices := Size(digraph_vertices);

    outs := OutNeighbors(digraph);
    ins := InNeighbors(digraph);

    adj_matrix := EmptyPlist(nr_vertices);
    flow_matrix := EmptyPlist(nr_vertices);

    # fill adj and max flow with zeroes
    for u in digraph_vertices do
        adj_matrix[u] := EmptyPlist(nr_vertices);
        flow_matrix[u] := EmptyPlist(nr_vertices);
        for v in digraph_vertices do
            adj_matrix[u][v] := 0;
            flow_matrix[u][v] := 0;
        od;
    od;

    for u in digraph_vertices do
        out_neighbours := outs[u];
        for idx in [1..Size(out_neighbours)] do
            v := out_neighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            if adj_matrix[u][v] <> 0 then
                if w < adj_matrix[u][v] then
                    adj_matrix[u][v] := w;
                fi;
            else 
                adj_matrix[u][v] := w;
            fi;
        od;
    od;

    total_flow := 0;
    while BFS(adj_matrix, flow_matrix, source, sink) do
        total_flow := total_flow + DFS(adj_matrix, flow_matrix, source, 100000);
    od;

    return total_flow;
end;

BFS := function(adj_matrix, flow_matrix, source, sink)
    local nr_vertices, queue,u, v;

    nr_vertices := Size(adj_matrix);
    queue := PlistDeque();
    PlistDequePushFront(queue, source);

    levels := EmptyPlist(nr_vertices);
    # fill levels with zeroes
    for u in [1..nr_vertices] do
        levels[u] := 0;
    od;
    levels[source] := 1;


    while not IsEmpty(queue) do
        u := PlistDequePopFront(queue);
        for v in [1..nr_vertices] do
            if flow_matrix[u][v] < adj_matrix[u][v] and levels[v] = 0 then
                levels[v] := levels[u] + 1;
                PlistDequePushBack(queue, v);
            fi;
        od;
    od;

    return levels[sink] > 0;
end;

DFS := function(adj_matrix, flow_matrix, u, flow)
    local temp, nr_vertices, v, f, min;
    temp := flow;
    nr_vertices := Size(adj_matrix);

    if u = nr_vertices then
        return flow;
    fi;

    for v in [1..nr_vertices] do
        if (levels[v] = levels[u] + 1) and (flow_matrix[u][v] < adj_matrix[u][v]) then
            if adj_matrix[u][v] - flow_matrix[u][v] < temp then
                min := adj_matrix[u][v] - flow_matrix[u][v];
            else
                min := temp;
            fi;

            f := DFS(adj_matrix, flow_matrix, v, min);

            flow_matrix[u][v] := flow_matrix[u][v] + f;
            flow_matrix[v][u] := flow_matrix[u][v] - f;
            temp := temp - f;
        fi;
    od;
    return flow - temp;
end;