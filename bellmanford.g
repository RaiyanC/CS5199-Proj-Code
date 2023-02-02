# https://github.com/arnab132/Bellman-Ford-Algorithm-Python/blob/main/bellman_ford.py
Bellman := function(digraph, weights, source)
    local edge_list, digraph_vertices, distances, u, out_neighbours, idx, v, w, _, edge;

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

    # Print(edge_list, "\n");

    distances := [];
    for _ in digraph_vertices do
        Add(distances, infinity);
    od;
    distances[source] := 0;

    # relax all edges: update weight with smallest edges
    for _ in digraph_vertices do
        for edge in edge_list do
            w := edge[1];
            u := edge[2];
            v := edge[3];

            if distances[u] <> infinity and distances[u] + w < distances[v] then
                distances[v] := distances[u] + w;
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

    return distances;
end;