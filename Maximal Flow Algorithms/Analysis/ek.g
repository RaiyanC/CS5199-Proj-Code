# edmond karp uses bfs
# http://staff.ustc.edu.cn/~csli/graduate/algorithms/book6/chap27.htm
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

    for u in Keys(flow_matrix) do
        for v in Keys(flow_matrix[u]) do
            for e in [1..Size(flow_matrix[u][v])] do
                if flow_matrix[u][v][e] > 0 then
                    # add parents for each flow
                    for i in [1..Size(flow_matrix[u][v])] do
                        Add(parents[v], u);
                        Add(flows[v], flow_matrix[u][v][i]);
                        # as total flow out of source = total flow into sink. sum up flow when u is the source
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

BFS := function(adj_matrix, flow_matrix, source, sink)
    local queue, paths, u, v, e, digraph_vertices, nr_vertices, edge, w, edge_idx, residual_flow,idx, visited_edges, f;
    
    nr_vertices := Size(adj_matrix);

    queue := PlistDeque();
    PlistDequePushFront(queue, source);
    
    paths := HashMap(); # edge to source, source: [edge, v]
    paths[source] := [];

    if source = sink then
        return paths[source];
    fi;

    while not IsEmpty(queue) do
        u := PlistDequePopFront(queue);

        for v in Keys(adj_matrix[u]) do
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

Edmondkarp := function(digraph, source, sink, probability)
    local weights, adj_matrix, digraphVertices, nr_vertices, e,u,v,edges, outs, ins, 
    edge_idx, idx, out_neighbours, in_neighbours, w, mst, 
    visited, i, j, k, queue, cost, node, neighbour, next_vertex, total, 
    edges_in_mst, number_of_vertices, distances, parents, flow_matrix, path,
    flow, flow_information, edge;

    weights := EdgeWeights(digraph);

    digraphVertices := DigraphVertices(digraph);
    nr_vertices := Size(digraphVertices);
    outs := OutNeighbors(digraph);
    ins := InNeighbors(digraph);

    adj_matrix := HashMap();
    flow_matrix := HashMap();

    # fill adj and max flow with zeroes
    for u in digraphVertices do

        adj_matrix[u] := HashMap();
        flow_matrix[u] := HashMap();

        for v in digraphVertices do
            adj_matrix[u][v] := [0];
            flow_matrix[u][v] := [0];
        od;
    od;

    for u in digraphVertices do
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

    # ANALYSIS: HERE START TIME
    nrEdges := Size(DigraphEdges(digraph));
    startTime := Runtimes().user_time;
    nrVertices := Size(digraphVertices);
    
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

    # ANALYSIS: HERE STOP TIME
    endTime := Runtimes().user_time;

    analysisPath := Concatenation("../Maximal Flow Algorithms/Analysis/",
                    Concatenation(String(probability), "/ek.csv"));


    data := Concatenation(String(nrVertices), 
    Concatenation(",", 
    Concatenation(String(nrEdges), 
    Concatenation(",",
    Concatenation(String(startTime),
    Concatenation(",",
    Concatenation(String(endTime), "\n")))))));

    AppendTo(analysisPath, data);
    return rec(
        parents:=flow_information[1], 
    flows:=flow_information[2],
    max_flow:=flow_information[3]
    );
end;

 