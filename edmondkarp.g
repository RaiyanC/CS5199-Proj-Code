# edmond karp uses bfs
# http://staff.ustc.edu.cn/~csli/graduate/algorithms/book6/chap27.htm
Edmondkarp := function(digraph, weights, source, sink)
    local adj_matrix, digraph_vertices, nr_vertices, e,u,v,edges, outs, ins, 
    edge_idx, idx, out_neighbours, in_neighbours, w, mst, 
    visited, i, j, k, queue, cost, node, neighbour, next_vertex, total, 
    edges_in_mst, number_of_vertices, distances, parents, flow_matrix, path,
    flow, flow_information, edge;

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
            adj_matrix[u][v] := [0];
            flow_matrix[u][v] := [0];
        od;
    od;

    for u in digraph_vertices do
        out_neighbours := outs[u];
        for idx in [1..Size(out_neighbours)] do
            v := out_neighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            # if edge already exists
            if adj_matrix[u][v][1] <> 0 then
                Add(adj_matrix[u][v], w); 
                Add(flow_matrix[u][v], 0); 
                Add(flow_matrix[v][u], 0);
            else 
                adj_matrix[u][v][1] := w;
            fi;
        od;
    od;

    path := BFS(adj_matrix, flow_matrix, source, sink);

    while path <> -1 do
        flow := GetMinFlow(adj_matrix, flow_matrix, path);

        for edge in path do
            u := edge[1];
            e := edge[2];
            v := edge[3];

            flow_matrix[u][v][e] := flow_matrix[u][v][e] + flow;
            flow_matrix[v][u][e] := flow_matrix[v][u][e] - flow;
        od;

        path := BFS(adj_matrix, flow_matrix, source, sink);
    od;
    
    flow_information := GetFlowInformation(flow_matrix);
    return rec(flow_path:=flow_information[1], 
    max_flow:=GetFlowSum(flow_matrix, source),
    flows:=flow_information[2]);
end;

GetFlowSum := function(flow_matrix, source)
    local sum, i, v, e;
    sum := 0;
    for v in [1..Size(flow_matrix)] do 
        for e in [1..Size(flow_matrix[source,v])] do
            sum := sum + flow_matrix[source][v][e];
        od;
    od;

    return sum;
end;

GetMinFlow := function(adj_matrix, flow_matrix, path)
    local edge, u, e,v, min, remaining_flow;
    min := infinity;
    for edge in path do 
        u := edge[1];
        e := edge[2];
        v := edge[3];

        remaining_flow := adj_matrix[u][v][e] - flow_matrix[u][v][e];
        if  remaining_flow < min then
            min := remaining_flow;
        fi; 
    od;

    return min;
end;

GetFlowInformation := function(flow_matrix)
    local flow_paths, flows, u, v, e, nr_vertices;

    nr_vertices := Size(flow_matrix);
    flow_paths := EmptyPlist(nr_vertices);
    flows := EmptyPlist(nr_vertices);

    for u in [1..nr_vertices] do
        flow_paths[u] := [];
        flows[u] := [];
        for v in [1..nr_vertices] do
            for e in [1..Size(flow_matrix[u][v])] do
                # flow exists 
                if flow_matrix[u][v][e] > 0 then
                    Add(flow_paths[u], [e,v]);
                    Add(flows[u], flow_matrix[u][v][e]);
                fi; 
            od;
        od;
    od;
    return [flow_paths, flows];
end;

BFS := function(adj_matrix, flow_matrix, source, sink)
    local queue, paths, u, v, e, digraph_vertices, nr_vertices, edge, w, edge_idx, residual_flow,idx, visited_edges, f;
    
    nr_vertices := Size(adj_matrix);

    queue := PlistDeque();
    PlistDequePushFront(queue, source);
    
    paths := HashMap(); # edge to sourec, source: [edge, v]
    paths[source] := [];

    if source = sink then
        return paths[source];
    fi;

    while not IsEmpty(queue) do
        u := PlistDequePopFront(queue);

        for v in [1..nr_vertices] do
            # loop through edges for u -> v
            for edge_idx in [1..Size(adj_matrix[u][v])] do
                e := adj_matrix[u][v][edge_idx];
                f := flow_matrix[u][v][edge_idx];

                if e - f > 0 and not v in paths then
                    paths[v] := ShallowCopy(paths[u]);
                    Append(paths[v], [[u,edge_idx,v]]);

                    if v = sink then
                        return paths[v];
                    fi;
                    PlistDequePushBack(queue, v);
                fi;
            od;
        od;
    od;
    return -1;
end;    