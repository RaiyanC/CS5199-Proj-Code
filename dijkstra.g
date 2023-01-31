# https://bradfieldcs.com/algos/graphs/dijkstras-algorithm/
Dijkstra := function(digraph, weights, source)
local adj, digraph_vertices,e,u,v,edges, vertex, distances, 
edge_idx, idx, out_neighbours, w, mst, visited, i, queue, cost, 
node, curr_node, curr_dist, neighbour, next_vertex, total, edges_in_mst,
distance, number_of_vertices;

    digraph_vertices := DigraphVertices(digraph);
    
    # Create an adjacancy map for the edges with their associated weight
    adj := HashMap();
    for u in digraph_vertices do
        adj[u] := HashMap();
        out_neighbours := OutNeighbors(digraph)[u];
        for idx in [1..Size(out_neighbours)] do
            v := out_neighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            adj[u][v] := w;
        od;

    od;


    distances := [];
    for vertex in digraph_vertices do
        Add(distances, infinity);
    od;

    distances[source] := 0;
    visited := [];
    for vertex in digraph_vertices do
        Add(visited, false);
    od;


    # make binary heap by priority of index 1 of each element (the cost to get to the node)
    queue := BinaryHeap({x, y} -> x[1] > y[1]);
    Push(queue, [0, source]); # the source vertex with cost 0


    while not IsEmpty(queue) do
        node := Pop(queue);
        curr_dist := node[1];
        u := node[2];

        # nodes may be added multiple times, we only want to process
        # a vertex the first time we remove it from the queue.
        # could also use a visited set.
        # if curr_dist > distances[u] then
        #     continue;
        # fi;

        if visited[u] then
            continue;
        fi;

        visited[u] := true;

        for neighbour in KeyValueIterator(adj[u]) do
            v := neighbour[1];
            w := neighbour[2];


            distance := curr_dist + w;

            if distance < distances[v] then
                distances[v] := distance;

                if not visited[v] then
                    Push(queue, [distance, v]);
                fi;
            fi;
            
            
        od;

    od;


    return distances;
end;