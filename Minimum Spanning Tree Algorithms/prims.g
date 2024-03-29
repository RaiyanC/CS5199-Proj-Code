Prims := function(digraph)
    local weights, digraphVertices, outs, adj, u, outNeighbours, inNeighbours, idx, v,
    w, mst, visited, queue, neighbour, total, edgesInMst, nrVertices, node, cost,
    nextVertex, mstWeights;

    weights := EdgeWeights(digraph);

    digraphVertices := DigraphVertices(digraph);
    outs := OutNeighbors(digraph);
    mst := EmptyPlist(Size(digraphVertices));
    mstWeights := EmptyPlist(Size(digraphVertices));
    # Create an adjacancy map for the edges with their associated weight
    adj := HashMap();
    for u in digraphVertices do
        outNeighbours := outs[u];
        Add(mst, []);
        Add(mstWeights, []);
        if not u in adj then 
            adj[u] := HashMap();
        fi;
    
        for idx in [1..Size(outNeighbours)] do
            v := outNeighbours[idx]; # the out neighbour
            w := weights[u][idx]; # the weight of the edge to the out neighbour

            # Adding an edge for the current direction

            # check if there is an edge
            if v in adj[u] then
                # if edge already exists, update minimum for both directions
                if w < adj[u][v] then
                    adj[u][v] := w; 
                    adj[v][u] := w; # this is the reverse edge. necessary to convert from directed to undirected graph
                fi;
            else 
                # if edge doesn't exist already, set it as the weight
                adj[u][v] := w;

                if not v in adj then
                    adj[v] := HashMap();
                fi;

                adj[v][u] := w; # again, adding the reverse edge
            fi;
        od;
    od;

    
    
    visited := BlistList(digraphVertices, [1]);
    queue := BinaryHeap({x, y} -> x[1] > y[1]);

    # Add neighbours of first vertex to heap
    for neighbour in KeyValueIterator(adj[1]) do
        v := neighbour[1];
        w := neighbour[2];

        Push(queue, [w, 1, v]); # weight, u, v
    od;

    total := 0;
    edgesInMst := 0;
    nrVertices := Size(digraphVertices);
    while not IsEmpty(queue) do
        node := Pop(queue);
        cost := node[1];
        u := node[2];
        v := node[3];
        

        if not visited[v] then
            visited[v] := true;
            

            if not IsBound(mst[u]) then
                mst[u] := [];
                mstWeights[u] := [];
            fi;


            Add(mst[u], v);
            Add(mstWeights[u], cost);
            total := total + cost;
            
            # optimisation to break out if MST reached when edges == v - 1
            if edgesInMst = nrVertices - 1 then
                break;
            fi;

            for neighbour in KeyValueIterator(adj[v]) do
                nextVertex := neighbour[1];
                w := neighbour[2];
 
                if not visited[nextVertex] then
                    Push(queue, [w, v, nextVertex]);
                fi;
            od;
        fi;
    od;

    return rec(total:=total, mst:=EdgeWeightedDigraph(mst, mstWeights));
end;