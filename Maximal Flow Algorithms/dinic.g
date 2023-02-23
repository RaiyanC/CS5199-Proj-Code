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

    while BFS(adj_matrix, flow_matrix, source, sink) do
        DFS(adj_matrix, flow_matrix, source, infinity);
    od;

    flow_information := GetFlowInformation(flow_matrix, source);
    return rec(
        parents:=flow_information[1], 
    flows:=flow_information[2],
    max_flow:=flow_information[3]
    );
end;

GetFlowInformation := function(flow_matrix, source)
    local parents, flows, u, v, e, nr_vertices, edges, max_flow, _, i;

    nr_vertices := Size(flow_matrix);

    parents := EmptyPlist(nr_vertices);
    flows := EmptyPlist(nr_vertices);
    max_flow := 0;

    # create empty 2D list for output
    for _ in [1..nr_vertices] do
        Add(parents, []);
        Add(flows, []);
    od; 
    
    # initialise source values
    parents[source] := [];
    flows[source] := [];
    
    # Print("\n\n\n flow matrix ", flow_matrix, "\n\n\n");
    for u in [1..nr_vertices] do
        for v in [1..nr_vertices] do
            for e in [1..Size(flow_matrix[u][v])] do
                if flow_matrix[u][v][e] > 0 then
                    # add parents for each flow
                    for i in [1..Size(flow_matrix[u][v])] do
                        Add(parents[v], u);
                        Add(flows[v], flow_matrix[u][v][i]);
                        if u = source then
                            max_flow := max_flow + flow_matrix[u][v][i];
                        fi;
                    od;
                    break;
                fi;
            od;
            
        od;
    od;


    return [parents, flows, max_flow];
end;

# this bfs holds the levels for the vertices
BFS := function(adj_matrix, flow_matrix, source, sink)
    local nr_vertices, queue,u, v, edge_idx, e, f;

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
            for edge_idx in [1..Size(adj_matrix[u][v])] do
                e := adj_matrix[u][v][edge_idx];
                f := flow_matrix[u][v][edge_idx];
                if f < e and levels[v] = 0 then
                    levels[v] := levels[u] + 1;
                    PlistDequePushBack(queue, v);
                fi;
            od;
        od;
    od;
    return levels[sink] > 0;
end;

DFS := function(adj_matrix, flow_matrix, u, flow)
    local temp, nr_vertices, v, f, min, e, edge_idx, fl;
    temp := flow;
    nr_vertices := Size(adj_matrix);

    # base case, if dfs reaches end
    if u = nr_vertices then
        return flow;
    fi;

    for v in [1..nr_vertices] do
        for edge_idx in [1..Size(adj_matrix[u][v])] do
            e := adj_matrix[u][v][edge_idx];
            fl := flow_matrix[u][v][edge_idx];

            if (levels[v] = levels[u] + 1) and (fl < e) then
                f := DFS(adj_matrix, flow_matrix, v, Minimum((e- fl), temp));

                flow_matrix[u][v][edge_idx] := flow_matrix[u][v][edge_idx] + f;
                flow_matrix[v][u][edge_idx] := flow_matrix[v][u][edge_idx] - f;

                temp := temp - f;
            fi;
        od;
    od;

    if temp = infinity then
      return infinity;
    fi;

    return flow - temp;
end;