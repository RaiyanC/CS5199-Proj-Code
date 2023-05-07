# https://bradfieldcs.com/algos/graphs/prims-spanning-tree-algorithm/
Prims := function(digraph, weights)
    local adj, digraph_vertices,e,u,v,edges, outs, ins, 
    edge_idx, idx, out_neighbours, in_neighbours, w, mst, visited, 
    i, queue, cost, node, neighbour, next_vertex, total, edges_in_mst, number_of_vertices,
    out_neighbours_size, in_neighbours_size;

    digraph_vertices := DigraphVertices(digraph); # should have 1 exec, has 1 exec
    outs := OutNeighbors(digraph); # should have 1 exec, has 1
    ins := InNeighbors(digraph); # 1, 1
    
    adj := HashMap(Size(digraph_vertices)); # 1, 1
    
    for u in digraph_vertices do
        out_neighbours := outs[u]; # 6, 6
        in_neighbours := ins[u]; # 6, 6
        out_neighbours_size := Size(out_neighbours);
        in_neighbours_size := Size(in_neighbours);


        if not u in adj then # 6, 6
            adj[u] := HashMap(); # 1, .... ?
        fi; # 6, 6


        for idx in [1..Size(out_neighbours)] do # 6, 6
            v := out_neighbours[idx];
            w := weights[u][idx]; 
            


            ## way to get number of edges in and out from u to v so we can initialise this list instead of 
            ## reallocating memory?
            ## could loop through DigraphIn/OutEdges() but is that worse?
            adj[u][v] := [];
            Add(adj[u][v], w);
            

            if not v in adj then
                adj[v] := HashMap();
            fi;

            if not u in adj[v] then
                adj[v][u] := [];
            fi;
            
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