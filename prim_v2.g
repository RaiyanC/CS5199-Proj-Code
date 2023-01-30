# https://bradfieldcs.com/algos/graphs/prims-spanning-tree-algorithm/
Prims := function(digraph, weights)
    local adj, digraph_vertices,e,u,v,edges, edge_idx, idx, out_neighbours, w, mst, visited, i, queue, cost, node, neighbour, next_vertex, total, edges_in_mst, number_of_vertices;

    digraph_vertices := DigraphVertices(digraph);
    
    # Print("Digraph ", digraph, "\n");
    # Print("Weights ", weights, "\n");

    # Create an adjacancy map for the edges with their associated weight

    # loop through out neighbours, and add in neighbours to adj list
    # as we don't loop through the adj list, we can add an extra in neighbour simultaneously
    adj := HashMap();
    for u in digraph_vertices do
        if not u in adj then 
            adj[u] := HashMap();
        fi;


        out_neighbours := OutNeighbors(digraph)[u];
        for idx in [1..Size(out_neighbours)] do
            v := out_neighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight to the out neighbour

            if not v in adj[u] then
                adj[u][v] := [];
            fi;
            
            Add(adj[u][v], w);

            # adj[u][v] := w; # u: {v: w} # adding in the weight it self

            if not v in adj then
                adj[v] := HashMap();
            fi;

            if not u in adj[v] then
                adj[v][u] := [];
            fi;
            
            Add(adj[v][u], w);

            # adj[v][u] := w; # v: {u: w} # adding an extra in neighbour with the same weight
        od;
    od;

    # Print("adj ", adj, "\n\n\n");

    mst := HashMap();
    visited := HashSet();
    AddSet(visited, 1);

    queue := BinaryHeap({x, y} -> x[1] > y[1]);

    # Add neighbours of first vertex to heap
    for neighbour in KeyValueIterator(adj[1]) do
        v := neighbour[1];
        edges := neighbour[2];

        for edge_idx in [1..Size(edges)] do
            w := adj[1][v][edge_idx];
            Push(queue, [w, 1, v]);
        od; 

        # v := out_neighbours[idx];
        # w := weights[1][idx];
        
        # Push(queue, [w, 1, v]);
    od;


    # Print("queue ", Size(queue), "\n\n\n");

    total := 0;
    edges_in_mst := 0;
    number_of_vertices := Size(digraph_vertices);
    while not IsEmpty(queue) do
        node := Pop(queue);
        cost := node[1];
        u := node[2];
        v := node[3];

        if not v in visited then
            AddSet(visited, v);

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

                    if not next_vertex in visited then
                        Push(queue, [w, v, next_vertex]);
                    fi;
                od; 

                
            od;
        fi;
    od;

    return [total, mst];
    end;