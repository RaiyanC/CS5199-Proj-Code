# https://bradfieldcs.com/algos/graphs/dijkstras-algorithm/
Dijkstra := function(digraph, weights, source)
local adj, digraph_vertices,e,u,v,edges, vertex, distances, 
edge_idx, idx, out_neighbours, w, visited, i, queue, cost, 
node, curr_node, curr_dist, neighbour, total, edges_in_mst,
distance, number_of_vertices, other_vertex, path, parents, edge_info;

    digraph_vertices := DigraphVertices(digraph);
    
    # Create an adjacancy map for the edges with their associated weight
    adj := HashMap();
    for u in digraph_vertices do
        adj[u] := HashMap();
        out_neighbours := OutNeighbors(digraph)[u];
        for idx in [1..Size(out_neighbours)] do
            v := out_neighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            # an edge to v already exists
            if v in adj[u] then
                # check if edge weight is less than curr weight, and keep track of edge idx
                if w < adj[u][v][1] then
                    adj[u][v] := [w, idx];
                fi;
            else # edge doesn't exist already, so add it
                adj[u][v] := [w, idx];
            fi;
        od;

    od;

    distances := [digraph_vertices];
    parents := [digraph_vertices];
    edges := [];
   
    for vertex in digraph_vertices do
        distances[vertex] := infinity;
    od;

    distances[source] := 0;
    parents[source] := -1;
    edges[source] := -1;
    
    visited := BlistList(digraph_vertices, []);


    # make binary heap by priority of index 1 of each element (the cost to get to the node)
    queue := BinaryHeap({x, y} -> x[1] > y[1]);
    Push(queue, [0, source]); # the source vertex with cost 0


    while not IsEmpty(queue) do
        node := Pop(queue);

        curr_dist := node[1];
        u := node[2];

        if visited[u] then
            continue;
        fi;

        visited[u] := true;

        for neighbour in KeyValueIterator(adj[u]) do
            v := neighbour[1];
            edge_info := neighbour[2];
            w := edge_info[1];
            idx := edge_info[2];

            distance := curr_dist + w;

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


    return rec(distances:=distances, parents:=parents, edges:=edges);
end;