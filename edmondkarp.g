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

    # adj_matrix := EmptyPlist(nr_vertices);
    # flow_matrix := EmptyPlist(nr_vertices);

    adj_matrix := HashMap();
    flow_matrix := HashMap();

    # fill adj and max flow with zeroes
    for u in digraph_vertices do
        # adj_matrix[u] := EmptyPlist(nr_vertices);
        # flow_matrix[u] := EmptyPlist(nr_vertices);
        adj_matrix[u] := HashMap();
        flow_matrix[u] := HashMap();
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
    
    flow_information := GetFlowInformation(flow_matrix, source);
    return rec(
        parents:=flow_information[1], 
    flows:=flow_information[2],
    edges:=flow_information[3],
    max_flow:=flow_information[4]
    );
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

GetFlowInformation := function(flow_matrix, source)
    local parents, flows, u, v, e, nr_vertices, edges, max_flow, _;

    nr_vertices := Size(flow_matrix);

    parents := EmptyPlist(nr_vertices);
    flows := EmptyPlist(nr_vertices);
    edges := EmptyPlist(nr_vertices);
    max_flow := 0;

    # create empty 2D list for output
    for _ in [1..nr_vertices] do
        Add(parents, []);
        Add(edges, []);
        Add(flows, []);
    od; 
    
    # initialise source values
    parents[source] := [-1];
    flows[source] := [0];
    edges[source] := [-1];
    
    for u in [1..nr_vertices] do
        for v in [1..nr_vertices] do
            for e in [1..Size(flow_matrix[u][v])] do
                 if flow_matrix[u][v][e] > 0 then
                    Add(parents[v], u);
                    Add(flows[v], flow_matrix[u][v][e]);
                    Add(edges[v],e);
                    if u = source then
                        max_flow := max_flow + flow_matrix[source][v][e];
                    fi;
                  fi;
            od;
        od;
    od;


    return [parents, flows, edges, max_flow];
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

        for v in KeyIterator(adj_matrix) do
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