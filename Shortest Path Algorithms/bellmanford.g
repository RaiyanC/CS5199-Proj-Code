# https://github.com/arnab132/Bellman-Ford-Algorithm-Python/blob/main/bellman_ford.py
# Read("../Shortest Path Algorithms/bellmanford.g"); Bellman(g,w,1);
Bellman := function(digraph, source)
    local edge_list, weights, digraphVertices, distances, u, 
    outNeighbours, idx, v, w, _, path, vertex, edge, parents,
    edge_info, edges, d, i, flag;

    weights := EdgeWeights(digraph);

    digraphVertices := DigraphVertices(digraph);
    edge_list := [];
    flag = true;
    
    for u in DigraphVertices(digraph) do
        outNeighbours := OutNeighbors(digraph)[u];
        for idx in [1..Size(outNeighbours)] do
            v := outNeighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            Add(edge_list, [w, u, v, idx]);
        od;
    od;


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

            if Float(distances[u]) <> Float(infinity) and Float(distances[u]) + Float(w) < Float(distances[v]) then
                distances[v] := distances[u] + w;

                # if distance is smaller, copy the path to u and add v to it.
                # if path from x -> y is minimal. path to y is path to x + the edge to y
                # path[v] := ShallowCopy(path[u]);
                # Add(path[v], v);
                
                parents[v] := u;
                edges[v] := idx;
                flag = false;
            fi;
        od;
        if flag = true then
            break;
        fi;
    od;

    # check for negative cycles
    for edge in edge_list do
        w := edge[1];
        u := edge[2];
        v := edge[3];

        if Float(distances[u]) <> Float(infinity) and Float(distances[u]) + Float(w) < Float(distances[v]) then
            ErrorNoReturn("negative cycle exists,");
        fi;
    od;

    # fill lists with fail if no path is possible
    for i in [1..Size(distances)] do
        d := distances[i];
        if Float(d) = Float(infinity) then
            parents[i] := fail;
            edges[i] := fail;
        fi; 
    od;

    return rec(distances:=distances, parents:=parents, edges:=edges);
end;