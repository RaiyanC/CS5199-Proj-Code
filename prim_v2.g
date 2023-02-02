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

        # if u had no outneighbours, then its map never gets created
        # therefore we make sure every visited vertex has its own map
        # even if its empty, as it may have in neighbours and may need 
        # to be added to
        if not u in adj then 
            adj[u] := HashMap();
        fi;

        

        for idx in [1..Size(out_neighbours)] do
            v := out_neighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            # Adding an edge for the current direction

            # if out neighbour isnt a vertex already, then create an
            # empty list. 
            if not v in adj[u] then
                # u: v: [number of out + in neighbours]
                adj[u][v] := EmptyPlist(Size(out_neighbours) + Size(in_neighbours));
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

    mst := HashMap();

    visited := BlistList(digraph_vertices, []);
    visited[1] := true;

    queue := BinaryHeap({x, y} -> x[1] > y[1]);

    # Add neighbours of first vertex to heap
    for neighbour in KeyValueIterator(adj[1]) do
        v := neighbour[1];
        edges := neighbour[2];

        # push all the edges outgoing from edge 1. 
        for edge_idx in [1..Size(edges)] do
            w := adj[1][v][edge_idx];
            Push(queue, [w, 1, v]);
        od; 
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
                edges := neighbour[2];
                
                for edge_idx in [1..Size(edges)] do
                    w := edges[edge_idx];;

                    if not visited[next_vertex] then
                        Push(queue, [w, v, next_vertex]);
                    fi;
                od; 

                
            od;
        fi;
    od;

    return [total, mst];
end;