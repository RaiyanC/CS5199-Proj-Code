# https://github.com/arnab132/Bellman-Ford-Algorithm-Python/blob/main/bellman_ford.py
# Read("../Shortest Path Algorithms/bellmanford.g"); Bellman(g,w,1);
Bellman := function(digraph, source)
    local edge_list, weights, digraph_vertices, distances, u, 
    out_neighbours, idx, v, w, _, path, vertex, edge, parents,
    edge_info, edges, d, i;

    weights := EdgeWeights(digraph);

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
    parents[source] := fail;
    edges[source] := fail;

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

    # fill lists with fail if no path is possible
    for i in [1..Size(distances)] do
        d := distances[i];
        if d = infinity then
            parents[i] := fail;
            edges[i] := fail;
        fi; 
    od;

    return rec(distances:=distances, parents:=parents, edges:=edges);
end;

Dijkstra := function(digraph, source)
    local weights, digraphVertices, nrVertices, adj, u, outNeighbours, idx, v, w, 
    distances, parents, edges, vertex, visited, queue, node, currDist, neighbour,
    edgeInfo, distance, i, d;

    weights := EdgeWeights(digraph);

    digraphVertices := DigraphVertices(digraph);
    nrVertices := Size(digraphVertices);
    
    # Create an adjacancy map for the edges with their associated weight
    adj := HashMap();
    for u in digraphVertices do
        adj[u] := HashMap();
        outNeighbours := OutNeighbors(digraph)[u];
        for idx in [1..Size(outNeighbours)] do
            v := outNeighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            # an edge to v already exists
            if v in adj[u] then
                # check if edge weight is less than current weight, and keep track of edge idx
                if w < adj[u][v][1] then
                    adj[u][v] := [w, idx];
                fi;
            else # edge doesn't exist already, so add it
                adj[u][v] := [w, idx];
            fi;
        od;

    od;

    distances := EmptyPlist(nrVertices);
    parents := EmptyPlist(nrVertices);
    edges := EmptyPlist(nrVertices);
   
    for vertex in digraphVertices do
        distances[vertex] := infinity;
    od;

    distances[source] := 0;
    parents[source] := fail;
    edges[source] := fail;

    
    visited := BlistList(digraphVertices, []);


    # make binary heap by priority of index 1 of each element (the cost to get to the node)
    queue := BinaryHeap({x, y} -> x[1] > y[1]);
    Push(queue, [0, source]); # the source vertex with cost 0


    while not IsEmpty(queue) do
        node := Pop(queue);

        currDist := node[1];
        u := node[2];

        if visited[u] then
            continue;
        fi;

        visited[u] := true;

        for neighbour in KeyValueIterator(adj[u]) do
            v := neighbour[1];
            edgeInfo := neighbour[2];
            w := edgeInfo[1];
            idx := edgeInfo[2];

            distance := currDist + w;

            if distance < distances[v] then
                distances[v] := distance;
                
                parents[v] := u;
                edges[v] := idx;

                if not visited[v] then
                    Push(queue, [distance, v]);
                fi;
            fi; 
        od;
    od;

    # fill lists with -1 if no path is possible
    for i in [1..Size(distances)] do
        d := distances[i];
        if d = infinity then
            distances[i] := fail;
            parents[i] := fail;
            edges[i] := fail;
        fi; 
    od;

    return rec(distances:=distances, parents:=parents, edges:=edges);
end;

ShortestPath := function(digraph, source)


end;

