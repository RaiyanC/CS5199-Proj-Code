# https://bradfieldcs.com/algos/graphs/prims-spanning-tree-algorithm/
Prims := function(digraph, weights)
    local adj, digraph_vertices,e,u,v,edges, outs, ins, edge_idx, idx, out_neighbours, in_neighbours, w, mst, visited, i, queue, cost, node, neighbour, next_vertex, total, edges_in_mst, number_of_vertices;

    digraph_vertices := DigraphVertices(digraph);
    outs := OutNeighbors(digraph);
    ins := InNeighbors(digraph);
    
    # Create an adjacancy map for the edges with their associated weight

    # loop through out neighbours, and add in neighbours to adj list
    # as we don't loop through the adj list, we can add an extra in neighbour simultaneously
    adj := HashMap(Size(digraph_vertices));
    
    for u in digraph_vertices do
        out_neighbours := outs[u];
        in_neighbours := ins[u];

        if not u in adj then 
            adj[u] := HashMap();
        fi;

        for idx in [1..Size(out_neighbours)] do
            v := out_neighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            # Adding an edge for the current direction

            # check if there is an edge
            if v in adj[u] then
                # if edge already exists, update minimum for both directions
                if w < adj[u][v] then
                    adj[u][v] := w; 
                    adj[v][u] := w; # reverse edge
                fi;
            else 
                # if edge doesn't exist already, set it as the weight
                adj[u][v] := w;

                if not v in adj then
                    adj[v] := HashMap();
                fi;

                adj[v][u] := w; # reverse edge
            fi;
        od;
    od;
    mst := HashMap();

    visited := BlistList(digraph_vertices, []);
    visited[1] := true;

    queue := BinaryHeap({x, y} -> x[1] > y[1]);

    # Add neighbours of first vertex to heap
    for neighbour in KeyValueIterator(adj[1]) do
        v := neighbour[1];
        w := neighbour[2];

        Push(queue, [w, 1, v]);
    od;

    total := 0;
    edges_in_mst := 0;
    number_of_vertices := Size(digraph_vertices);
    while not IsEmpty(queue) do
        node := Pop(queue);
        cost := node[1];
        u := node[2];
        v := node[3];

        if not visited[v] then
            visited[v] := true;
            

            if not u in mst then
                mst[u] := [];
            fi;


            Add(mst[u], v);
            total := total + cost;
            
            # optimisation to break out if MST reached when edges == v - 1
            if edges_in_mst = number_of_vertices - 1 then
                break;
            fi;

            for neighbour in KeyValueIterator(adj[v]) do
                next_vertex := neighbour[1];
                w := neighbour[2];
 
                if not visited[next_vertex] then
                    Push(queue, [w, v, next_vertex]);
                fi;
            od;
        fi;
    od;

    return [total, mst];
end;