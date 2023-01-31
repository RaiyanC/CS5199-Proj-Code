# https://bradfieldcs.com/algos/graphs/dijkstras-algorithm/
Dijkstra := function(digraph, weights, source)
local adj, digraph_vertices,e,u,v,edges, vertex, distances, 
edge_idx, idx, out_neighbours, w, mst, visited, i, queue, cost, 
node, curr_node, curr_dist, neighbour, next_vertex, total, edges_in_mst,
distance, number_of_vertices;

    digraph_vertices := DigraphVertices(digraph);
    
    # Create an adjacancy map for the edges with their associated weight

    # loop through out neighbours, and add in neighbours to adj list
    # as we don't loop through the adj list, we can add an extra in neighbour simultaneously
    adj := HashMap();
    for u in digraph_vertices do

        # if u had no outneighbours, then its map never gets created
        # therefore we make sure every visited vertex has its own map
        # even if its empty, as it may have in neighbours and may need 
        # to be added to
        if not u in adj then 
            adj[u] := HashMap();
        fi;

        out_neighbours := OutNeighbors(digraph)[u];
        for idx in [1..Size(out_neighbours)] do
            v := out_neighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            # Adding an edge for the current direction

            # if out neighbour isnt a vertex already, then create an
            # empty list. 
            if not v in adj[u] then
                adj[u][v] := [];
            fi;
            
            # add, the new vertex with the weight {u: v:[w]}.
            # we cannot simply overwrite the value of the key as the same key will have
            # different values and when the second edge gets added, the first one will get
            # overwritten
            Add(adj[u][v], w);
            

            # Adding a new edge in the reverse direction
            
            # as we are adding the reverse nodes in, if the reverse has yet to be visited
            # create a hashmap for it
            if not v in adj then
                adj[v] := HashMap();
            fi;

            # make a new list for the u node in the neighbour
            if not u in adj[v] then
                adj[v][u] := [];
            fi;
            
            # add the reverse edge
            Add(adj[v][u], w);

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
            edges := neighbour[2];

            for edge_idx in [1..Size(edges)] do
                    w := edges[edge_idx];

                    distance := curr_dist + w;

                    if distance < distances[v] then
                        distances[v] := distance;

                        if not visited[v] then
                            Push(queue, [distance, v]);
                        fi;
                    fi;
                od; 
            
        od;

    od;


    return distances;
end;