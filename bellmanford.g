# https://github.com/arnab132/Bellman-Ford-Algorithm-Python/blob/main/bellman_ford.py
Bellman := function(digraph, weights, source)
    local edge_list, digraph_vertices, distances, u, out_neighbours, idx, v, w, _, path, vertex, edge;

    digraph_vertices := DigraphVertices(digraph);
    edge_list := [];
    for u in DigraphVertices(digraph) do
        out_neighbours := OutNeighbors(digraph)[u];
        for idx in [1..Size(out_neighbours)] do
            v := out_neighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            Add(edge_list, [w, u, v]);
        od;
    od;


    distances := [digraph_vertices];
    path := [digraph_vertices];
   
    for vertex in digraph_vertices do
        distances[vertex] := infinity;
        path[vertex] := [];
    od;
    
    distances[source] := 0;
    Add(path[source], source);

    # relax all edges: update weight with smallest edges
    for _ in digraph_vertices do
        for edge in edge_list do
            w := edge[1];
            u := edge[2];
            v := edge[3];

            if distances[u] <> infinity and distances[u] + w < distances[v] then
                distances[v] := distances[u] + w;

                # if distance is smaller, copy the path to u and add v to it.
                # if path from x -> y is minimal. path to y is path to x + the edge to y
                path[v] := ShallowCopy(path[u]);
                Add(path[v], v);
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

    return [distances, path];
end;