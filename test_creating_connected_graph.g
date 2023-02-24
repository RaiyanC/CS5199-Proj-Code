CreateSCG := function(filt, n, p)
    local randomDigraph, adjMatrix, stronglyConnectedComponents, 
    scc_a, scc_b, i, j, random_u, random_v, adjList, u, v;

    # strong connected digraph must be at least connected
    randomDigraph := RandomDigraph(IsConnectedDigraph, n, p);
    stronglyConnectedComponents := DigraphStronglyConnectedComponents(randomDigraph);

    adjMatrix := AdjacencyMatrixMutableCopy(randomDigraph);

    for i in [1..Size(stronglyConnectedComponents.comps) - 1] do
        scc_a := stronglyConnectedComponents.comps[i];
        scc_b := stronglyConnectedComponents.comps[i+1];

        # add a connection from u -> v
        random_u := scc_a[Random([1..Size(scc_a)])];
        random_v := scc_b[Random([1..Size(scc_b)])];

        adjMatrix[random_u][random_v] := 1;

        # get a different u and v and add edge in the reverse direction
        random_u := scc_b[Random([1..Size(scc_b)])];
        random_v := scc_a[Random([1..Size(scc_a)])];

        adjMatrix[random_u][random_v] := 1;
    od; 

    # convert adjacancy matrix to adjacancy list
    adjList := EmptyPlist(n);
    for u in [1..Size(adjMatrix)] do
        Add(adjList, []);
        for v in [1..Size(adjMatrix[u])] do
            if adjMatrix[u][v] = 1 then
                Add(adjList[u],v);
            fi;
        od;
    od;

    return DigraphNC(adjList);
end;