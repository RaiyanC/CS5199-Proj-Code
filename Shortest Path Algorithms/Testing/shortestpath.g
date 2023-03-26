TestShortestPathAlgorithms := function(n, p)
    local i, rd, bmf, d;
    Print("Running tests on shortest path algorithms... \n");
    for i in [1..n] do
        rd := RandomUniqueEdgeWeightedDigraph(IsStronglyConnectedDigraph,i,p); 
        Print("running.. ", i, " vertices (", Size(DigraphEdges(rd)) ," edges) ..");
        bmf := DIGRAPHS_Edge_Weighted_Bellman_Ford(rd, 1);;
        d := DIGRAPHS_Edge_Weighted_Dijkstra(rd, 1);;
        if bmf.distances <> d.distances then
            Print("Output from Dijkstra\n", d);
            Print("Output from BellmanFord\n", bmf);
            ErrorNoReturn("test with ", i, " vertices failed");
        fi;
        Print("passed!\n");
    od;
    Print("-- ALL TEST CASES PASSED --\n");
    return true;
end;