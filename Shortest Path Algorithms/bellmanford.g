# https://github.com/arnab132/Bellman-Ford-Algorithm-Python/blob/main/bellman_ford.py
# Read("../Shortest Path Algorithms/bellmanford.g"); Bellman(g,w,1);
Bellman := function(digraph, weights, source)
    local edge_list, digraph_vertices, distances, u, 
    out_neighbours, idx, v, w, _, path, vertex, edge, parents,
    edge_info, edges, d, i;

    digraph_vertices := DigraphVertices(digraph);
    edge_list := [];
    for u in DigraphVertices(digraph) do
        out_neighbours := OutNeighbors(digraph)[u];
        for idx in [1..Size(out_neighbours)] do
            v := out_neighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            Add(edge_list, [w, u, v, idx]);
        od;
    od;


    distances := [digraph_vertices];
    parents := [digraph_vertices];
    edges := [digraph_vertices];
   
    for vertex in digraph_vertices do
        distances[vertex] := infinity;
    od;
    
    distances[source] := 0;
    parents[source] := -1;
    edges[source] := -1;

    # relax all edges: update weight with smallest edges
    for _ in digraph_vertices do
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

    # fill lists with -1 if no path is possible
    for i in [1..Size(distances)] do
        d := distances[i];
        if d = infinity then
            parents[i] := -1;
            edges[i] := -1;
        fi; 
    od;

    return rec(distances:=distances, parents:=parents, edges:=edges);
end;