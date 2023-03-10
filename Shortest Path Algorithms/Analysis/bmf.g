# https://github.com/arnab132/Bellman-Ford-Algorithm-Python/blob/main/bellman_ford.py
# Read("../Shortest Path Algorithms/bellmanford.g"); Bellman(g,w,1);
Bellman := function(digraph, source, probability)
    local edge_list, weights, digraphVertices, distances, u, 
    out_neighbours, idx, v, w, _, path, vertex, edge, parents,
    edge_info, edges, d, i, analysisPath, headers, nrVertices, nrEdges, startTime, endTime, data;


    weights := EdgeWeights(digraph);

    digraphVertices := DigraphVertices(digraph);
    nrVertices := Size(digraphVertices);

    edge_list := [];
    for u in DigraphVertices(digraph) do
        out_neighbours := OutNeighbors(digraph)[u];
        for idx in [1..Size(out_neighbours)] do
            v := out_neighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            Add(edge_list, [w, u, v, idx]);
        od;
    od;

    # ANALYSIS: HERE START TIME
    nrEdges := Size(DigraphEdges(digraph));
    startTime := Runtimes().user_time;
    nrVertices := Size(digraphVertices);

    distances := [digraphVertices];
    parents := [digraphVertices];
    edges := [digraphVertices];
   
    for vertex in digraphVertices do
        distances[vertex] := infinity;
    od;
    
    distances[source] := 0;
    parents[source] := fail;
    edges[source] := fail;

    # relax all edges: update weight with smallest edges
    for _ in digraphVertices do
        for edge in edge_list do
            w := edge[1];
            u := edge[2];
            v := edge[3];
            idx := edge[4];

            if distances[u] <> infinity and distances[u] + w < distances[v] then
                distances[v] := distances[u] + w;

                # if distance is smaller, copy the path to u and add v to it.
                # if path from x -> y is minimal. path to y is path to x + the edge to y
                # path[v] := ShallowCopy(path[u]);
                # Add(path[v], v);
                
                parents[v] := u;
                edges[v] := idx;
            fi;
        od;
    od;

    # check for negative cycles
    for edge in edge_list do
        w := edge[1];
        u := edge[2];
        v := edge[3];

        if distances[u] <> infinity and distances[u] + w < distances[v] then
            return fail;
        fi;
    od;

    # fill lists with fail if no path is possible
    for i in [1..Size(distances)] do
        d := distances[i];
        if d = infinity then
            parents[i] := fail;
            edges[i] := fail;
        fi; 
    od;

    # ANALYSIS: HERE STOP TIME
    endTime := Runtimes().user_time;

    analysisPath := Concatenation("../Shortest Path Algorithms/Analysis/",
                    Concatenation(String(probability), "/bmf.csv"));


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