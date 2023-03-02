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